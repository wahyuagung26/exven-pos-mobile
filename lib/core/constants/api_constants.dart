class ApiConstants {
  static const String baseUrl = 'http://localhost:8089';
  static const String mockBaseUrl = 'http://localhost:8089';

  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}
