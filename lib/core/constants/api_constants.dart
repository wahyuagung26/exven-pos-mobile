class ApiConstants {
  static const String baseUrl = 'https://api.example.com';
  static const String mockBaseUrl = 'https://mock.api.example.com';
  
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}