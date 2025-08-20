/// Storage keys and configuration for secure storage and local database
/// 
/// This file contains all storage-related constants including secure storage keys,
/// SQLite table names, shared preferences keys, and cache configuration for the
/// multi-tenant POS system.

/// Secure Storage Keys
/// Used with flutter_secure_storage for sensitive data
class SecureStorageKeys {
  // Authentication
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String tokenExpiry = 'token_expiry';
  static const String tokenType = 'token_type';
  
  // User Data
  static const String userId = 'user_id';
  static const String userRole = 'user_role';
  static const String userPermissions = 'user_permissions';
  static const String userEmail = 'user_email';
  static const String userName = 'user_name';
  
  // Tenant Data
  static const String tenantId = 'tenant_id';
  static const String tenantName = 'tenant_name';
  static const String currentOutletId = 'current_outlet_id';
  static const String outletIds = 'outlet_ids';
  
  // Device Data
  static const String deviceId = 'device_id';
  static const String deviceName = 'device_name';
  static const String lastSyncTimestamp = 'last_sync_timestamp';
  
  // Biometric Authentication
  static const String biometricEnabled = 'biometric_enabled';
  static const String biometricKey = 'biometric_key';
  
  // Offline Data
  static const String offlineMode = 'offline_mode';
  static const String pendingSyncCount = 'pending_sync_count';
  static const String lastOnlineTimestamp = 'last_online_timestamp';
  
  // Settings
  static const String printerSettings = 'printer_settings';
  static const String receiptSettings = 'receipt_settings';
  static const String paymentSettings = 'payment_settings';
}

/// Shared Preferences Keys
/// Used for non-sensitive app preferences and settings
class PreferencesKeys {
  // App Settings
  static const String appLanguage = 'app_language';
  static const String appTheme = 'app_theme';
  static const String firstLaunch = 'first_launch';
  static const String onboardingCompleted = 'onboarding_completed';
  
  // User Preferences
  static const String defaultOutlet = 'default_outlet';
  static const String lastSelectedOutlet = 'last_selected_outlet';
  static const String autoSelectOutlet = 'auto_select_outlet';
  static const String rememberCredentials = 'remember_credentials';
  
  // Display Settings
  static const String fontSize = 'font_size';
  static const String showTutorials = 'show_tutorials';
  static const String compactMode = 'compact_mode';
  static const String showPrices = 'show_prices';
  
  // Transaction Settings
  static const String autoSelectCustomer = 'auto_select_customer';
  static const String defaultPaymentMethod = 'default_payment_method';
  static const String askForCustomer = 'ask_for_customer';
  static const String printReceipt = 'print_receipt';
  
  // Sync Settings
  static const String autoSync = 'auto_sync';
  static const String syncFrequency = 'sync_frequency';
  static const String wifiOnlySync = 'wifi_only_sync';
  static const String backgroundSync = 'background_sync';
  
  // Cache Settings
  static const String cacheTimeout = 'cache_timeout';
  static const String maxCacheSize = 'max_cache_size';
  static const String clearCacheOnLogout = 'clear_cache_on_logout';
  
  // Analytics & Tracking
  static const String analyticsEnabled = 'analytics_enabled';
  static const String crashReportsEnabled = 'crash_reports_enabled';
  static const String usageStatsEnabled = 'usage_stats_enabled';
  
  // Notification Settings
  static const String pushNotificationsEnabled = 'push_notifications_enabled';
  static const String lowStockAlerts = 'low_stock_alerts';
  static const String salesNotifications = 'sales_notifications';
  static const String systemUpdates = 'system_updates';
}

/// SQLite Database Constants
/// Table names and configuration for local database
class DatabaseConstants {
  // Database Info
  static const String databaseName = 'pos_local.db';
  static const int databaseVersion = 1;
  
  // Table Names
  static const String productsTable = 'products';
  static const String categoriesTable = 'product_categories';
  static const String customersTable = 'customers';
  static const String transactionsTable = 'transactions';
  static const String transactionItemsTable = 'transaction_items';
  static const String stocksTable = 'product_stocks';
  static const String stockMovementsTable = 'stock_movements';
  static const String outletsTable = 'outlets';
  static const String usersTable = 'users';
  static const String syncQueueTable = 'sync_queue';
  static const String configsTable = 'configs';
  static const String cacheTable = 'cache';
  
  // Common Column Names
  static const String id = 'id';
  static const String tenantId = 'tenant_id';
  static const String outletId = 'outlet_id';
  static const String name = 'name';
  static const String isActive = 'is_active';
  static const String isSynced = 'is_synced';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
  static const String syncedAt = 'synced_at';
  static const String lastModified = 'last_modified';
  
  // Sync Related Columns
  static const String syncAction = 'sync_action';
  static const String syncStatus = 'sync_status';
  static const String syncRetryCount = 'sync_retry_count';
  static const String syncError = 'sync_error';
  static const String conflictResolution = 'conflict_resolution';
}

/// Cache Configuration
/// Settings for caching data in memory and storage
class CacheConstants {
  // Cache Keys Prefixes
  static const String productsCacheKey = 'products_';
  static const String categoriesCacheKey = 'categories_';
  static const String customersCacheKey = 'customers_';
  static const String outletsCacheKey = 'outlets_';
  static const String usersCacheKey = 'users_';
  static const String reportsCacheKey = 'reports_';
  static const String dashboardCacheKey = 'dashboard_';
  
  // Cache Durations (in minutes)
  static const int shortCacheDuration = 5;
  static const int mediumCacheDuration = 30;
  static const int longCacheDuration = 60;
  static const int dailyCacheDuration = 1440; // 24 hours
  static const int weeklyCacheDuration = 10080; // 7 days
  
  // Cache Sizes (in MB)
  static const int maxMemoryCacheSize = 50;
  static const int maxDiskCacheSize = 200;
  static const int maxImageCacheSize = 100;
  
  // Cache Cleanup Settings
  static const int cacheCleanupInterval = 1440; // 24 hours in minutes
  static const double cacheCleanupThreshold = 0.8; // 80% full
}

/// File Storage Constants
/// Configuration for file storage and uploads
class FileStorageConstants {
  // Directory Names
  static const String documentsDir = 'documents';
  static const String imagesDir = 'images';
  static const String receiptsDir = 'receipts';
  static const String logsDir = 'logs';
  static const String cacheDir = 'cache';
  static const String tempDir = 'temp';
  static const String backupDir = 'backup';
  
  // File Extensions
  static const List<String> imageExtensions = ['.jpg', '.jpeg', '.png', '.gif'];
  static const List<String> documentExtensions = ['.pdf', '.doc', '.docx', '.txt'];
  static const String receiptExtension = '.pdf';
  static const String logExtension = '.log';
  static const String backupExtension = '.db';
  
  // File Size Limits (in bytes)
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  static const int maxDocumentSize = 10 * 1024 * 1024; // 10MB
  static const int maxReceiptSize = 2 * 1024 * 1024; // 2MB
  static const int maxLogFileSize = 50 * 1024 * 1024; // 50MB
  
  // File Naming Patterns
  static const String timestampFormat = 'yyyyMMdd_HHmmss';
  static const String productImagePrefix = 'product_';
  static const String avatarImagePrefix = 'avatar_';
  static const String receiptPrefix = 'receipt_';
  static const String logFilePrefix = 'pos_log_';
  static const String backupFilePrefix = 'backup_';
}

/// Sync Queue Constants
/// Configuration for offline synchronization
class SyncConstants {
  // Sync Actions
  static const String create = 'CREATE';
  static const String update = 'UPDATE';
  static const String delete = 'DELETE';
  static const String upload = 'UPLOAD';
  
  // Sync Status
  static const String pending = 'PENDING';
  static const String inProgress = 'IN_PROGRESS';
  static const String completed = 'COMPLETED';
  static const String failed = 'FAILED';
  static const String conflict = 'CONFLICT';
  static const String skipped = 'SKIPPED';
  
  // Priority Levels
  static const int highPriority = 1;
  static const int mediumPriority = 2;
  static const int lowPriority = 3;
  
  // Retry Configuration
  static const int maxRetryCount = 3;
  static const int retryDelay = 5; // seconds
  static const int conflictTimeout = 300; // 5 minutes
  
  // Batch Sync Settings
  static const int syncBatchSize = 50;
  static const int maxSyncDuration = 300; // 5 minutes
  static const int syncCheckInterval = 30; // seconds
}

/// Application Storage Limits
/// Configuration for storage quotas and limits
class StorageLimits {
  // Database Size Limits (in MB)
  static const int maxDatabaseSize = 500;
  static const int warningDatabaseSize = 400;
  
  // Record Count Limits
  static const int maxCachedProducts = 10000;
  static const int maxCachedCustomers = 5000;
  static const int maxCachedTransactions = 1000;
  static const int maxPendingSyncItems = 500;
  
  // Cleanup Thresholds
  static const int oldTransactionDays = 30;
  static const int oldLogDays = 7;
  static const int oldCacheDays = 3;
  static const int oldTempFileHours = 2;
  
  // Free Space Requirements (in MB)
  static const int minFreeSpace = 100;
  static const int recommendedFreeSpace = 500;
}

/// Environment-specific Storage Settings
enum StorageEnvironment {
  development,
  staging,
  production,
}

extension StorageEnvironmentExtension on StorageEnvironment {
  String get databaseName {
    switch (this) {
      case StorageEnvironment.development:
        return 'pos_dev.db';
      case StorageEnvironment.staging:
        return 'pos_staging.db';
      case StorageEnvironment.production:
        return 'pos_local.db';
    }
  }
  
  bool get enableDebugLogging => this != StorageEnvironment.production;
  bool get enableVerboseSync => this == StorageEnvironment.development;
  int get logLevel => this == StorageEnvironment.production ? 2 : 0;
}