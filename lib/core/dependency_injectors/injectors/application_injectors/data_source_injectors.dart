import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_driven/core/dependency_injectors/dependency_injector.dart';
import 'package:test_driven/core/dependency_injectors/injectors/base_injector.dart';
import 'package:test_driven/data/data/local/number_trivia_local_DS.dart';
import 'package:test_driven/data/data/remote/index.dart';

import '../../../Network/network_checker.dart';

/// [DataSourcesInjector] hold all application data sources dependencies
class DataSourcesInjector implements BaseInjector {
  static final _dataSourcesInjectors = [
    () => diInstance.registerLazySingleton<NetworkChecker>(
          () => NetworkCheckerImplementation(
            InternetConnectionChecker(),
          ),
        ),
    () => diInstance.registerLazySingleton<NumberTriviaRemoteDS>(
          () => NumberTriviaRemoteDSImpl(
            dio: diInstance<Dio>(),
          ),
        ),
    () => diInstance.registerLazySingleton<NumberTriviaLocalDS>(
          () => NumberTriviaLocalDSImpl(
            sharedPreferences: diInstance<SharedPreferences>(),
          ),
        ),
  ];

  /// iterate and inject all data sources
  @override
  void injectModules() {
    for (final dataSourceInjector in _dataSourcesInjectors) {
      dataSourceInjector.call();
    }
  }
}
