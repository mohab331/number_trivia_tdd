import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkChecker {
  Future<bool> isConnected();
}

class NetworkCheckerImplementation implements NetworkChecker {
  NetworkCheckerImplementation(this._internetConnectionChecker);

  final InternetConnectionChecker _internetConnectionChecker;

  @override
  Future<bool> isConnected() async {
    return await _internetConnectionChecker.hasConnection;
  }
}
