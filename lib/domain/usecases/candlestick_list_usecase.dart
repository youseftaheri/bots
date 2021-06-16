import 'package:my_flutter_test_app1/data/model/candlestickData.dart';
import 'package:my_flutter_test_app1/data/repositories/abstract/candlestick_list_repository.dart';
import '../../locator.dart';
import 'base_use_case.dart';

abstract class CandlestickListUseCase
    implements BaseUseCase<CandlestickListResult, CandlestickListParams> {}

class CandlestickListUseCaseImpl implements CandlestickListUseCase {
  @override
  Future<CandlestickListResult> execute(CandlestickListParams params) async {
    try {
      CandlestickListRepository _candlestickListRepository = sl();
      List<CandlestickData> candlesticks = await _candlestickListRepository.getCandlestickListResult(
          page: params.page,
      );
      return CandlestickListResult(
          candlesticks,
          candlesticks.length
      );

    } catch (e) {
      return CandlestickListResult(
          null,
          0,
          exception: EmptyCandlestickListException()
      );
    }
  }
}

class CandlestickListResult {
  final List<CandlestickData> candlesticks;
  final int quantity;
  final Exception exception;

  CandlestickListResult(
      this.candlesticks,
      this.quantity,{
        this.exception
      }
      );

  bool get validResults => exception == null;
}

class CandlestickListParams {
  final String page;

  CandlestickListParams({
    this.page,
  });
}

class EmptyCandlestickListException implements Exception {}