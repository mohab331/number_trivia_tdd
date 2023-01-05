import 'package:test_driven/core/dependency_injectors/dependency_injector.dart';
import 'package:test_driven/core/index.dart';
import 'package:test_driven/data/data/index.dart';
import 'package:test_driven/data/index.dart';
import 'package:test_driven/domain/index.dart';

/// [ReposInjector] hold all application repos dependencies
class ReposInjector implements BaseInjector {
  static final _reposInjectors = [
    () => diInstance.registerLazySingleton<BaseNumberTriviaRepository>(
          () => BaseNumberTriviaRepoImpl(
            numberTriviaLocalDS: diInstance<NumberTriviaLocalDS>(),
            numberTriviaRemoteDS: diInstance<NumberTriviaRemoteDS>(),
            networkChecker: diInstance<NetworkChecker>(),
          ),
        ),
  ];

  /// iterate and inject all repos
  @override
  void injectModules() {
    for (final reposInjector in _reposInjectors) {
      reposInjector.call();
    }
  }
}
