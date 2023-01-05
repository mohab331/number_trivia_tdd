import 'package:test_driven/domain/index.dart';
import 'package:test_driven/presentation/pages/home/cubit/home_cubit.dart';

import '../../dependency_injector.dart';
import '../../index.dart';

class CubitInjectors implements BaseInjector {
  static final _cubitInjectors = [
    () => diInstance.registerFactory<HomeCubit>(
          () => HomeCubit(
            getConcreteNumberTriviaUseCase:
                diInstance<GetConcreteNumberTriviaUseCase>(),
            getRandomNumberTriviaUseCase:
                diInstance<GetRandomNumberTriviaUseCase>(),
          ),
        ),
  ];

  @override
  void injectModules() {
    for (final cubitInjector in _cubitInjectors) {
      cubitInjector.call();
    }
  }
}
