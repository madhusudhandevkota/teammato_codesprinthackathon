abstract class Exception {}

class NoInternetConnectionException extends Exception {}

class ServerException implements Exception {
  final String message;
  ServerException({
    this.message = "Server Error Occured",
  });
}
class HiveException implements Exception {
  final String message;
  HiveException({
    this.message = "Hive Connection Error",
  });
}
