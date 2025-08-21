class ApiConstants {
  static const String baseUrl = 'https://api.yourapp.com/v1';
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}

class StorageConstants {
  static const String tokenKey = 'auth_token';
  static const String tenantIdKey = 'tenant_id';
  static const String userKey = 'current_user';
}

class RouteConstants {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String products = '/products';
  static const String productDetail = '/product-detail';
}
