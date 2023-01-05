import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'injectors/index.dart';

GetIt diInstance = GetIt.instance;

class DependencyInjector {
  static Future<void> injectModules() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    diInstance.registerLazySingleton<SharedPreferences>(
      () => sharedPreference,
    );
    diInstance.registerLazySingleton<Dio>(
      () => _setDefaultDioClient(),
    );

    InjectHolder.injectAllModules();
  }

  static Dio _setDefaultDioClient() {
    final baseOptions = BaseOptions(
      baseUrl: 'http://numbersapi.com/',
      contentType: 'application/json',
      headers: {'Content-Type': 'application/json'},
      connectTimeout: 12000,
      receiveTimeout: 9000,
    );
    return Dio(baseOptions)
      ..interceptors.add(
        PrettyDioLogger(
          responseHeader: true,
          requestHeader: true,
          requestBody: true,
        ),
      );
  }
}
