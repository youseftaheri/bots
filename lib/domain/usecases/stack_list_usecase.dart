import 'package:my_flutter_test_app1/data/model/stackData.dart';
import 'package:my_flutter_test_app1/data/repositories/abstract/stack_list_repository.dart';
import '../../locator.dart';
import 'base_use_case.dart';

abstract class StackListUseCase
    implements BaseUseCase<StackListResult, StackListParams> {}

class StackListUseCaseImpl implements StackListUseCase {
  @override
  Future<StackListResult> execute(StackListParams params) async {
    try {
      StackListRepository _stackListRepository = sl();
      List<StackData> stacks = await _stackListRepository.getStackListResult(
          page: params.page,
      );
      return StackListResult(
          stacks,
          stacks.length
      );

    } catch (e) {
      return StackListResult(
          null,
          0,
          exception: EmptyStackListException()
      );
    }
  }
}

class StackListResult {
  final List<StackData> stacks;
  final int quantity;
  final Exception exception;

  StackListResult(
      this.stacks,
      this.quantity,{
        this.exception
      }
      );

  bool get validResults => exception == null;
}

class StackListParams {
  final String page;

  StackListParams({
    this.page,
  });
}

class EmptyStackListException implements Exception {}