class AppConstants {
  // Application Information
  static const String appName = 'ExVen POS Lite';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';
  static const String appDescription = 'Multi-tenant Point of Sale system';

  // API Configuration
  static const Map<String, String> apiUrls = {
    'development': 'http://localhost:8080/api',
    'staging': 'https://staging-api.exvenpos.com/api',
    'production': 'https://api.exvenpos.com/api',
  };

  // Current environment - should be loaded from environment or config
  static const String currentEnvironment = 'development';
  static String get baseUrl => apiUrls[currentEnvironment]!;

  // API Endpoints
  static const String authEndpoint = '/auth';
  static const String loginEndpoint = '/auth/login';
  static const String logoutEndpoint = '/auth/logout';
  static const String refreshTokenEndpoint = '/auth/refresh';
  static const String userProfileEndpoint = '/auth/profile';
  
  static const String tenantsEndpoint = '/tenants';
  static const String outletsEndpoint = '/outlets';
  static const String productsEndpoint = '/products';
  static const String categoriesEndpoint = '/categories';
  static const String customersEndpoint = '/customers';
  static const String transactionsEndpoint = '/transactions';
  static const String reportsEndpoint = '/reports';

  // Network Configuration
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);
  
  // Retry Configuration
  static const int maxRetryAttempts = 3;
  static const Duration retryDelay = Duration(seconds: 1);
  
  // Request Headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-App-Version': appVersion,
  };

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  static const int minPageSize = 5;

  // Local Storage Keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';
  static const String tenantDataKey = 'tenant_data';
  static const String lastSelectedOutletKey = 'last_selected_outlet';
  static const String appThemeKey = 'app_theme';
  static const String appLanguageKey = 'app_language';
  static const String rememberLoginKey = 'remember_login';
  static const String biometricEnabledKey = 'biometric_enabled';
  
  // Cache Configuration
  static const Duration cacheMaxAge = Duration(minutes: 5);
  static const Duration cacheStaleAge = Duration(minutes: 30);
  static const int maxCacheSize = 10 * 1024 * 1024; // 10MB

  // Session Configuration
  static const Duration sessionTimeout = Duration(hours: 8);
  static const Duration sessionWarningTime = Duration(minutes: 5);
  static const Duration tokenRefreshThreshold = Duration(minutes: 10);

  // File Upload
  static const int maxFileSize = 5 * 1024 * 1024; // 5MB
  static const List<String> allowedImageExtensions = [
    'jpg', 'jpeg', 'png', 'gif', 'webp'
  ];
  static const List<String> allowedDocumentExtensions = [
    'pdf', 'doc', 'docx', 'xls', 'xlsx', 'csv'
  ];

  // Validation Rules
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 128;
  static const int minUsernameLength = 3;
  static const int maxUsernameLength = 50;
  static const int maxEmailLength = 255;
  static const int maxNameLength = 100;
  static const int maxDescriptionLength = 500;
  
  // Currency & Formatting
  static const String defaultCurrency = 'IDR';
  static const String currencySymbol = 'Rp';
  static const String defaultLocale = 'id_ID';
  static const String defaultTimezone = 'Asia/Jakarta';
  
  // Business Rules
  static const double maxDiscountPercentage = 100.0;
  static const double maxTaxPercentage = 50.0;
  static const int maxTransactionItems = 100;
  static const double minTransactionAmount = 0.01;
  static const double maxTransactionAmount = 999999999.99;
  
  // UI Configuration
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration splashDuration = Duration(seconds: 3);
  static const Duration debounceDelay = Duration(milliseconds: 500);
  static const Duration snackBarDuration = Duration(seconds: 4);
  static const Duration tooltipDelay = Duration(milliseconds: 700);
  
  // Grid Configuration
  static const int productGridCrossAxisCount = 2;
  static const double productGridChildAspectRatio = 0.75;
  static const double gridSpacing = 8.0;
  
  // List Configuration
  static const double listItemHeight = 72.0;
  static const double compactListItemHeight = 56.0;
  static const int maxSearchResults = 50;
  
  // Error Messages
  static const String networkErrorMessage = 'Tidak ada koneksi internet';
  static const String serverErrorMessage = 'Terjadi kesalahan pada server';
  static const String timeoutErrorMessage = 'Koneksi timeout';
  static const String unauthorizedErrorMessage = 'Sesi telah berakhir';
  static const String forbiddenErrorMessage = 'Akses ditolak';
  static const String notFoundErrorMessage = 'Data tidak ditemukan';
  static const String validationErrorMessage = 'Data tidak valid';
  static const String unknownErrorMessage = 'Terjadi kesalahan yang tidak diketahui';
  
  // Success Messages
  static const String loginSuccessMessage = 'Login berhasil';
  static const String logoutSuccessMessage = 'Logout berhasil';
  static const String saveSuccessMessage = 'Data berhasil disimpan';
  static const String updateSuccessMessage = 'Data berhasil diperbarui';
  static const String deleteSuccessMessage = 'Data berhasil dihapus';
  
  // Feature Flags
  static const bool enableBiometric = true;
  static const bool enableOfflineMode = false; // Phase 2
  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;
  static const bool enablePushNotifications = true;
  static const bool enableDarkMode = true;
  static const bool enableMultiLanguage = true;
  
  // Development Flags
  static const bool enableDebugMode = true;
  static const bool enableApiLogging = true;
  static const bool enablePerformanceMonitoring = true;
  
  // Multi-tenant Configuration
  static const String tenantHeaderKey = 'X-Tenant-ID';
  static const String outletHeaderKey = 'X-Outlet-ID';
  
  // Role-based Access Control
  static const List<String> systemRoles = [
    'super_admin',
    'tenant_owner', 
    'manager',
    'cashier'
  ];
  
  static const Map<String, List<String>> rolePermissions = {
    'super_admin': ['*'],
    'tenant_owner': ['tenant.*'],
    'manager': [
      'outlet.*', 
      'reports.*', 
      'products.*', 
      'customers.*',
      'users.read',
      'users.update'
    ],
    'cashier': [
      'sales.*', 
      'customers.read', 
      'customers.create',
      'customers.update',
      'products.read'
    ],
  };
  
  // Subscription Plans
  static const List<String> subscriptionFeatures = [
    'basic_pos',
    'advanced_reports',
    'customer_management',
    'inventory_management',
    'multi_payment',
    'api_access',
    'custom_integration',
    'data_retention_unlimited'
  ];
}