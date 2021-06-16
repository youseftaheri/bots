import 'package:my_flutter_test_app1/data/error/exceptions.dart';
import 'package:my_flutter_test_app1/data/model/cubicData.dart';
import 'package:my_flutter_test_app1/data/network/network_status.dart';
import 'package:my_flutter_test_app1/data/testApp/repositories/cubic_list_remote_repository.dart';

import '../../locator.dart';
import 'abstract/cubic_list_repository.dart';


class CubicListRepositoryImpl extends CubicListRepository {

  @override
  Future<List<CubicData>> getCubicListResult({String page}) async {
    try
    {
      NetworkStatus networkStatus = sl();
      CubicListRepository cubicListRepository;
      if ( networkStatus.isConnected != null ) {
        cubicListRepository = RemoteCubicListRepository(testApp: sl());
      } else {
        cubicListRepository = null;//LocalCubicListRepository();
      }


      return await cubicListRepository.getCubicListResult(page: page);
    } on HttpRequestException {
      throw RemoteServerException();
    }
  }
}
