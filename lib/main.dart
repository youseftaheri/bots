import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:my_flutter_test_app1/config/theme.dart';
import 'package:my_flutter_test_app1/data/repositories/abstract/candlestick_list_repository.dart';
import 'package:my_flutter_test_app1/presentation/features/main_screen.dart';
import 'package:my_flutter_test_app1/presentation/features/splash_screen.dart';
import 'config/routes.dart';
import 'config/routes.dart';
import 'config/theme.dart';
import 'locator.dart';

import 'locator.dart' as service_locator;

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Cubit bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() async {
  service_locator.init();

  var delegate = await LocalizationDelegate.create(
    fallbackLocale: 'en_US',
    supportedLocales: ['en_US', 'de'],
  );

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Bloc.observer = SimpleBlocDelegate();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors.colorPrimaryDark,
  ));

  runApp(
    MultiRepositoryProvider(
        providers: [
          RepositoryProvider<CandlestickListRepository>(
            create: (context) => sl(),
          ),
          // RepositoryProvider<LoginRepository>(
          //   create: (context) => sl(),
          // ),
          // RepositoryProvider<LoginRepository>(
          //   create: (context) => sl(),
          // ),
        ],
        child: LocalizedApp(
          delegate,
          TestAppApp(),
        ),
      ),
  );
}

class TestAppApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return LocalizationProvider(
        state: LocalizationProvider.of(context).state,
        child: MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            localizationDelegate,
          ],
          supportedLocales: localizationDelegate.supportedLocales,
          debugShowCheckedModeBanner: false,
          locale: localizationDelegate.currentLocale,
          title: 'My Test App',
          theme: MyAppTheme.of(context),
          routes: _registerRoutes(),
        ));
  }

  Map<String, WidgetBuilder> _registerRoutes() {
    return <String, WidgetBuilder>{
      TestAppRoutes.splash: (context) => SplashScreen(),
      TestAppRoutes.main: (context) => MainScreen(),
    };
  }
}
