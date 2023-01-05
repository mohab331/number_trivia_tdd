import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:test_driven/app_bloc_observer.dart';
import 'package:test_driven/core/constants/index.dart';
import 'package:test_driven/core/dependency_injectors/dependency_injector.dart';

import 'presentation/pages/home/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await DependencyInjector.injectModules();
  runApp(const MyTriviaApp());
}

class MyTriviaApp extends StatelessWidget {
  const MyTriviaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
