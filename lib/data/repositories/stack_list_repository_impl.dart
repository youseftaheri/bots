import 'package:my_flutter_test_app1/data/error/exceptions.dart';
import 'package:my_flutter_test_app1/data/model/stackData.dart';
import 'package:my_flutter_test_app1/data/network/network_status.dart';
import 'package:my_flutter_test_app1/data/testApp/repositories/stack_list_remote_repository.dart';

import '../../locator.dart';
import 'abstract/stack_list_repository.dart';


class StackListRepositoryImpl extends StackListRepository {

  @override
  Future<List<StackData>> getStackListResult({String page}) async {
    try
    {
      NetworkStatus networkStatus = sl();
      StackListRepository stackListRepository;
      if ( networkStatus.isConnected != null ) {
        stackListRepository = RemoteStackListRepository(testApp: sl());
      } else {
        stackListRepository = null;//LocalStackListRepository();
      }


      return await stackListRepository.getStackListResult(page: page);
    } on HttpRequestException {
      throw RemoteServerException();
    }
  }
}
