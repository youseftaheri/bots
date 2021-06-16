import 'package:my_flutter_test_app1/data/model/cubicData.dart';
import 'package:my_flutter_test_app1/data/repositories/abstract/cubic_list_repository.dart';
import '../../locator.dart';
import 'base_use_case.dart';

abstract class CubicListUseCase
    implements BaseUseCase<CubicListResult, CubicListParams> {}

class CubicListUseCaseImpl implements CubicListUseCase {
  @override
  Future<CubicListResult> execute(CubicListParams params) async {
    try {
      CubicListRepository _cubicListRepository = sl();
      List<CubicData> cubics = await _cubicListRepository.getCubicListResult(
          page: params.page,
      );
      return CubicListResult(
          cubics,
          cubics.length
      );

    } catch (e) {
      return CubicListResult(
          null,
          0,
          exception: EmptyCubicListException()
      );
    }
  }
}

class CubicListResult {
  final List<CubicData> cubics;
  final int quantity;
  final Exception exception;

  CubicListResult(
      this.cubics,
      this.quantity,{
        this.exception
      }
      );

  bool get validResults => exception == null;
}

class CubicListParams {
  final String page;

  CubicListParams({
    this.page,
  });
}

class EmptyCubicListException implements Exception {}