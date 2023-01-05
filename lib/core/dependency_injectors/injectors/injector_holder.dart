import 'package:test_driven/core/dependency_injectors/injectors/application_injectors/index.dart';

import 'base_injector.dart';

class InjectHolder {
  static final List<BaseInjector> _applicationInjectors = [
    DataSourcesInjector(),
    ReposInjector(),
    UseCasesInjectors(),
    CubitInjectors(),
  ];

  static void injectAllModules() {
    for (final injector in _applicationInjectors) {
      injector.injectModules();
    }
  }
}
