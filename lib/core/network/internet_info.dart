import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class InternetInfo {
  Future<bool> get isConnected;
}

class InternetInfoImp implements InternetInfo {
  final InternetConnectionChecker connectionChecker;

  InternetInfoImp({required this.connectionChecker});

  @override
  Future<bool> get isConnected async {
    return connectionChecker.hasConnection;
  }
}
