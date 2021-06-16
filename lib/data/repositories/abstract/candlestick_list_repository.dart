import 'package:my_flutter_test_app1/data/model/candlestickData.dart';

abstract class CandlestickListRepository {
  Future<List<CandlestickData>> getCandlestickListResult({
    String page,
  });
}
