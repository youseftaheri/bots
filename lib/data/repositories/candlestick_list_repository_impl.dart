import 'package:my_flutter_test_app1/data/error/exceptions.dart';
import 'package:my_flutter_test_app1/data/model/candlestickData.dart';
import 'package:my_flutter_test_app1/data/network/network_status.dart';
import 'package:my_flutter_test_app1/data/testApp/repositories/candlestick_list_remote_repository.dart';

import '../../locator.dart';
import 'abstract/candlestick_list_repository.dart';


class CandlestickListRepositoryImpl extends CandlestickListRepository {

  @override
  Future<List<CandlestickData>> getCandlestickListResult({String page}) async {
    try
    {
      NetworkStatus networkStatus = sl();
      CandlestickListRepository candlestickListRepository;
      if ( networkStatus.isConnected != null ) {
        candlestickListRepository = RemoteCandlestickListRepository(testApp: sl());
      } else {
        candlestickListRepository = null;//LocalCandlestickListRepository();
      }


      return await candlestickListRepository.getCandlestickListResult(page: page);
    } on HttpRequestException {
      throw RemoteServerException();
    }
  }
}
