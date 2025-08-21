class ApiConstants {
  static const String baseUrl = 'http://localhost:8080/api/v1';
  static const Duration connectTimeout = Duration(milliseconds: 30000);
  static const Duration receiveTimeout = Duration(milliseconds: 30000);
  static const Duration sendTimeout = Duration(milliseconds: 30000);
  
  // Endpoints
  static const String authLogin = '/auth/login';
  static const String authRegister = '/auth/register';
  static const String authLogout = '/auth/logout';
  static const String authRefresh = '/auth/refresh';
  static const String authMe = '/auth/me';
}