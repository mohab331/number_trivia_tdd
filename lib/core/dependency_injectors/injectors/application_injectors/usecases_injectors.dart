import 'package:test_driven/core/dependency_injectors/injectors/base_injector.dart';
import 'package:test_driven/domain/index.dart';

import '../../dependency_injector.dart';

class UseCasesInjectors implements BaseInjector {
  static final _useCaseInjectors = [
    () => diInstance.registerLazySingleton<GetConcreteNumberTriviaUseCase>(
          () => GetConcreteNumberTriviaUseCase(
            diInstance<BaseNumberTriviaRepository>(),
          ),
        ),
    () => diInstance.registerLazySingleton<GetRandomNumberTriviaUseCase>(
          () => GetRandomNumberTriviaUseCase(
            diInstance<BaseNumberTriviaRepository>(),
          ),
        ),
  ];

  /// Iterate and inject all use cases
  @override
  void injectModules() {
    for (final useCaseInjector in _useCaseInjectors) {
      useCaseInjector.call();
    }
  }
}
