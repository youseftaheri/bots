import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:my_flutter_test_app1/data/network/network_request.dart';
import 'data/network/network_status.dart';
import 'data/repositories/abstract/candlestick_list_repository.dart';
import 'data/repositories/abstract/cubic_list_repository.dart';
import 'data/repositories/abstract/realtime_data_service.dart';
import 'data/repositories/abstract/stack_list_repository.dart';
import 'data/repositories/candlestick_list_repository_impl.dart';
import 'data/repositories/cubic_list_repository_impl.dart';
import 'data/repositories/realtime_data_service_impl.dart';
import 'data/repositories/stack_list_repository_impl.dart';
import 'domain/usecases/candlestick_list_usecase.dart';
import 'package:http/http.dart' as http;
import 'domain/usecases/cubic_list_usecase.dart';
import 'domain/usecases/stack_list_usecase.dart';


final sl = GetIt.instance;

//Service locator description
void init() {
  //Singleton for NetworkStatus identification
  sl.registerLazySingleton<NetworkStatus>(() => NetworkStatusImpl(DataConnectionChecker()));

  //Singleton for HTTP request
  sl.registerLazySingleton(() => http.Client());

  sl.registerLazySingleton<NetworkRequestAbstract>(() => NetworkRequest(client: sl()),);

  sl.registerLazySingleton<CandlestickListRepository>(() => CandlestickListRepositoryImpl(),);
  sl.registerFactory<CandlestickListUseCase>(() => CandlestickListUseCaseImpl());

  sl.registerLazySingleton<CubicListRepository>(() => CubicListRepositoryImpl(),);
  sl.registerFactory<CubicListUseCase>(() => CubicListUseCaseImpl());

  sl.registerLazySingleton<StackListRepository>(() => StackListRepositoryImpl(),);
  sl.registerFactory<StackListUseCase>(() => StackListUseCaseImpl());

  sl.registerLazySingleton<RealtimeDataService>(() => RealtimeDataServiceImpl());

}
