class ApiConstants {
  static const String baseUrl = 'http://localhost:8080/api/v1';
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}

class StorageConstants {
  static const String tokenKey = 'auth_token';
  static const String tenantIdKey = 'tenant_id';
  static const String userKey = 'user_data';
}

class AppConstants {
  static const String appName = 'JagoKasir';
  static const String version = '1.0.0';
}