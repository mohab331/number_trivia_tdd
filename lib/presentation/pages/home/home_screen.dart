import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_driven/core/dependency_injectors/dependency_injector.dart';
import 'package:test_driven/core/index.dart';

import 'cubit/index.dart';
import 'home_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          AppStrings.homeScreenAppBarTitle,
        ),
      ),
      body: BlocProvider(
        create: (context) => diInstance<HomeCubit>(),
        child: HomeContent(),
      ),
    );
  }
}
