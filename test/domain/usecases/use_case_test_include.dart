import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:my_flutter_test_app1/data/repositories/abstract/candlestick_list_repository.dart';
import 'package:my_flutter_test_app1/data/network/network_status.dart';
import 'package:my_flutter_test_app1/data/repositories/abstract/cubic_list_repository.dart';
import 'package:my_flutter_test_app1/data/testApp/repositories/candlestick_list_remote_repository.dart';
import 'package:my_flutter_test_app1/data/network/network_request.dart';
import 'package:my_flutter_test_app1/data/testApp/repositories/cubic_list_remote_repository.dart';

class MockTestAppWrapper extends Mock implements NetworkRequestAbstract { }

final sl = GetIt.instance;

void setupLocator() {
  sl.allowReassignment = true;

  MockTestAppWrapper testApp = MockTestAppWrapper();

  sl.registerLazySingleton<MockTestAppWrapper>(
        () => testApp,
  );

  sl.registerLazySingleton<NetworkRequestAbstract>(
        () => testApp,
  );

  sl.registerLazySingleton<CandlestickListRepository>(
        () => RemoteCandlestickListRepository(testApp: testApp),
  );

  sl.registerLazySingleton<CubicListRepository>(
        () => RemoteCubicListRepository(testApp: testApp),
  );

  sl.registerLazySingleton<NetworkStatus>(() => NetworkStatusImpl(DataConnectionChecker()));
}