class ServerException implements Exception {
  final String? message;
  final int? code;

  ServerException({this.message, this.code});
}

class CacheException implements Exception {
  final String? message;

  CacheException({this.message});
}

class NetworkException implements Exception {
  final String? message;

  NetworkException({this.message});
}

class ValidationException implements Exception {
  final String? message;

  ValidationException({this.message});
}