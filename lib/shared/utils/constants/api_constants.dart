/// API endpoint paths and configuration constants for the POS system
/// 
/// This file contains all API-related constants including base URLs,
/// endpoints, headers, timeouts, and configuration values for the
/// multi-tenant POS system.

/// API Configuration Constants
class ApiConstants {
  // Base Configuration
  static const String baseUrl = 'http://localhost:8080/api/v1';
  static const String baseUrlProduction = 'https://api.exvenpos.com/v1';
  
  // Timeouts (in milliseconds)
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const int sendTimeout = 30000;
  
  // Request Configuration
  static const int maxRetries = 3;
  static const int retryDelay = 1000; // milliseconds
  static const int maxContentLength = 10 * 1024 * 1024; // 10MB
  
  // Headers
  static const String contentTypeHeader = 'Content-Type';
  static const String authorizationHeader = 'Authorization';
  static const String tenantIdHeader = 'X-Tenant-ID';
  static const String acceptLanguageHeader = 'Accept-Language';
  static const String userAgentHeader = 'User-Agent';
  static const String deviceIdHeader = 'X-Device-ID';
  
  // Content Types
  static const String contentTypeJson = 'application/json';
  static const String contentTypeFormData = 'multipart/form-data';
  static const String contentTypeUrlEncoded = 'application/x-www-form-urlencoded';
  
  // Default Values
  static const String defaultLanguage = 'id';
  static const String userAgent = 'ExVenPOS-Mobile/1.0.0';
  
  /// Authentication Endpoints
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String verifyToken = '/auth/verify';
  static const String changePassword = '/auth/change-password';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String profile = '/auth/profile';
  
  /// Tenant Management Endpoints
  static const String tenants = '/tenants';
  static const String tenantProfile = '/tenants/profile';
  static const String tenantSettings = '/tenants/settings';
  static const String tenantSubscription = '/tenants/subscription';
  
  /// User Management Endpoints
  static const String users = '/users';
  static const String userProfile = '/users/profile';
  static const String userOutlets = '/users/outlets';
  static const String userPermissions = '/users/permissions';
  
  /// Role Management Endpoints
  static const String roles = '/roles';
  static const String rolePermissions = '/roles/permissions';
  
  /// Outlet Management Endpoints
  static const String outlets = '/outlets';
  static const String outletUsers = '/outlets/{id}/users';
  static const String outletProducts = '/outlets/{id}/products';
  static const String outletSettings = '/outlets/{id}/settings';
  
  /// Product Management Endpoints
  static const String products = '/products';
  static const String productCategories = '/product-categories';
  static const String productSearch = '/products/search';
  static const String productBulkUpdate = '/products/bulk-update';
  static const String productStock = '/products/{id}/stock';
  static const String productImages = '/products/{id}/images';
  
  /// Stock Management Endpoints
  static const String stocks = '/stocks';
  static const String stockMovements = '/stock-movements';
  static const String stockAdjustment = '/stocks/adjustment';
  static const String stockTransfer = '/stocks/transfer';
  static const String stockOpname = '/stocks/opname';
  
  /// Customer Management Endpoints
  static const String customers = '/customers';
  static const String customerSearch = '/customers/search';
  static const String customerPoints = '/customers/{id}/points';
  static const String customerTransactions = '/customers/{id}/transactions';
  
  /// Transaction Endpoints
  static const String transactions = '/transactions';
  static const String transactionItems = '/transactions/{id}/items';
  static const String transactionPayments = '/transactions/{id}/payments';
  static const String transactionRefund = '/transactions/{id}/refund';
  static const String transactionVoid = '/transactions/{id}/void';
  static const String transactionReceipt = '/transactions/{id}/receipt';
  
  /// Report Endpoints
  static const String reports = '/reports';
  static const String salesReport = '/reports/sales';
  static const String inventoryReport = '/reports/inventory';
  static const String customerReport = '/reports/customers';
  static const String profitReport = '/reports/profit';
  static const String dashboardSummary = '/reports/dashboard';
  
  /// Sync Endpoints (for offline support)
  static const String syncStatus = '/sync/status';
  static const String syncData = '/sync/data';
  static const String syncConflicts = '/sync/conflicts';
  static const String syncResolve = '/sync/resolve';
  
  /// File Upload Endpoints
  static const String uploadImage = '/uploads/images';
  static const String uploadAvatar = '/uploads/avatars';
  static const String uploadLogo = '/uploads/logos';
  static const String uploadReceipt = '/uploads/receipts';
  
  /// System Endpoints
  static const String healthCheck = '/health';
  static const String version = '/version';
  static const String configs = '/configs';
  
  /// Subscription Plan Endpoints
  static const String subscriptionPlans = '/subscription-plans';
  static const String subscriptionStatus = '/subscription/status';
  static const String subscriptionUpgrade = '/subscription/upgrade';
  
  /// Audit & Logs Endpoints
  static const String auditLogs = '/audit-logs';
  static const String activityLogs = '/activity-logs';
  
  /// Notification Endpoints
  static const String notifications = '/notifications';
  static const String notificationSettings = '/notifications/settings';
  static const String notificationMarkRead = '/notifications/{id}/read';
}

/// HTTP Status Codes
class HttpStatusCodes {
  // Success
  static const int ok = 200;
  static const int created = 201;
  static const int accepted = 202;
  static const int noContent = 204;
  
  // Redirection
  static const int multipleChoices = 300;
  static const int movedPermanently = 301;
  static const int found = 302;
  static const int notModified = 304;
  
  // Client Error
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int methodNotAllowed = 405;
  static const int conflict = 409;
  static const int unprocessableEntity = 422;
  static const int tooManyRequests = 429;
  
  // Server Error
  static const int internalServerError = 500;
  static const int badGateway = 502;
  static const int serviceUnavailable = 503;
  static const int gatewayTimeout = 504;
}

/// API Response Keys
class ApiResponseKeys {
  static const String message = 'message';
  static const String data = 'data';
  static const String meta = 'meta';
  static const String errors = 'errors';
  static const String success = 'success';
  static const String statusCode = 'status_code';
  
  // Pagination Keys
  static const String currentPage = 'current_page';
  static const String totalPages = 'total_pages';
  static const String totalItems = 'total_items';
  static const String itemsPerPage = 'items_per_page';
  static const String hasNext = 'has_next';
  static const String hasPrevious = 'has_previous';
}

/// Query Parameters
class QueryParams {
  static const String page = 'page';
  static const String limit = 'limit';
  static const String search = 'search';
  static const String sortBy = 'sort_by';
  static const String sortOrder = 'sort_order';
  static const String filter = 'filter';
  static const String startDate = 'start_date';
  static const String endDate = 'end_date';
  static const String status = 'status';
  static const String category = 'category';
  static const String outlet = 'outlet';
  static const String userId = 'user_id';
  static const String customerId = 'customer_id';
  
  // Default Values
  static const int defaultPage = 1;
  static const int defaultLimit = 20;
  static const int maxLimit = 100;
  static const String defaultSortOrder = 'desc';
}

/// Error Codes
class ApiErrorCodes {
  // Authentication Errors
  static const String invalidCredentials = 'INVALID_CREDENTIALS';
  static const String tokenExpired = 'TOKEN_EXPIRED';
  static const String invalidToken = 'INVALID_TOKEN';
  static const String accountLocked = 'ACCOUNT_LOCKED';
  static const String accountInactive = 'ACCOUNT_INACTIVE';
  
  // Authorization Errors
  static const String insufficientPermissions = 'INSUFFICIENT_PERMISSIONS';
  static const String accessDenied = 'ACCESS_DENIED';
  static const String roleNotFound = 'ROLE_NOT_FOUND';
  
  // Tenant Errors
  static const String tenantNotFound = 'TENANT_NOT_FOUND';
  static const String tenantInactive = 'TENANT_INACTIVE';
  static const String subscriptionExpired = 'SUBSCRIPTION_EXPIRED';
  static const String subscriptionLimitReached = 'SUBSCRIPTION_LIMIT_REACHED';
  
  // Validation Errors
  static const String validationFailed = 'VALIDATION_FAILED';
  static const String duplicateEntry = 'DUPLICATE_ENTRY';
  static const String invalidFormat = 'INVALID_FORMAT';
  static const String requiredField = 'REQUIRED_FIELD';
  
  // Business Logic Errors
  static const String insufficientStock = 'INSUFFICIENT_STOCK';
  static const String productNotFound = 'PRODUCT_NOT_FOUND';
  static const String customerNotFound = 'CUSTOMER_NOT_FOUND';
  static const String transactionNotFound = 'TRANSACTION_NOT_FOUND';
  static const String outletNotFound = 'OUTLET_NOT_FOUND';
  
  // System Errors
  static const String serverError = 'SERVER_ERROR';
  static const String databaseError = 'DATABASE_ERROR';
  static const String networkError = 'NETWORK_ERROR';
  static const String serviceUnavailable = 'SERVICE_UNAVAILABLE';
  
  // File Upload Errors
  static const String fileTooLarge = 'FILE_TOO_LARGE';
  static const String unsupportedFileType = 'UNSUPPORTED_FILE_TYPE';
  static const String uploadFailed = 'UPLOAD_FAILED';
}

/// Environment Configuration
enum ApiEnvironment {
  development,
  staging,
  production,
}

extension ApiEnvironmentExtension on ApiEnvironment {
  String get baseUrl {
    switch (this) {
      case ApiEnvironment.development:
        return 'http://localhost:8080/api/v1';
      case ApiEnvironment.staging:
        return 'https://staging-api.exvenpos.com/v1';
      case ApiEnvironment.production:
        return 'https://api.exvenpos.com/v1';
    }
  }
  
  bool get isProduction => this == ApiEnvironment.production;
  bool get isDevelopment => this == ApiEnvironment.development;
  bool get isStaging => this == ApiEnvironment.staging;
}