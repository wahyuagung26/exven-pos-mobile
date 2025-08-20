/// Custom exception hierarchy for the POS application
/// 
/// This file defines the base exception classes and application-specific
/// exceptions with user-friendly error messages and error codes.

/// Base application exception class
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final String? details;
  final DateTime timestamp;
  
  const AppException(
    this.message, {
    this.code,
    this.details,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
  
  @override
  String toString() => 'AppException: $message';
}

/// Base failure class for handling errors in use cases
abstract class Failure {
  final String message;
  final String? code;
  final DateTime timestamp;
  
  const Failure(
    this.message, {
    this.code,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
  
  @override
  String toString() => 'Failure: $message';
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          code == other.code;
  
  @override
  int get hashCode => message.hashCode ^ code.hashCode;
}

/// Authentication related exceptions
class AuthenticationException extends AppException {
  const AuthenticationException(
    super.message, {
    super.code,
    super.details,
    super.timestamp,
  });
  
  @override
  String toString() => 'AuthenticationException: $message';
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure(
    super.message, {
    super.code,
    super.timestamp,
  });
}

/// Authorization related exceptions
class AuthorizationException extends AppException {
  const AuthorizationException(
    super.message, {
    super.code,
    super.details,
    super.timestamp,
  });
  
  @override
  String toString() => 'AuthorizationException: $message';
}

class AuthorizationFailure extends Failure {
  const AuthorizationFailure(
    super.message, {
    super.code,
    super.timestamp,
  });
}

/// Validation related exceptions
class ValidationException extends AppException {
  final Map<String, List<String>>? errors;
  
  const ValidationException(
    super.message, {
    super.code,
    super.details,
    super.timestamp,
    this.errors,
  });
  
  @override
  String toString() => 'ValidationException: $message';
}

class ValidationFailure extends Failure {
  final Map<String, List<String>>? errors;
  
  const ValidationFailure(
    super.message, {
    super.code,
    super.timestamp,
    this.errors,
  });
}

/// Business logic related exceptions
class BusinessException extends AppException {
  const BusinessException(
    super.message, {
    super.code,
    super.details,
    super.timestamp,
  });
  
  @override
  String toString() => 'BusinessException: $message';
}

class BusinessFailure extends Failure {
  const BusinessFailure(
    super.message, {
    super.code,
    super.timestamp,
  });
}

/// Data related exceptions
class DataException extends AppException {
  const DataException(
    super.message, {
    super.code,
    super.details,
    super.timestamp,
  });
  
  @override
  String toString() => 'DataException: $message';
}

class DataFailure extends Failure {
  const DataFailure(
    super.message, {
    super.code,
    super.timestamp,
  });
}

/// Permission related exceptions
class PermissionException extends AppException {
  final String permission;
  
  const PermissionException(
    super.message, {
    required this.permission,
    super.code,
    super.details,
    super.timestamp,
  });
  
  @override
  String toString() => 'PermissionException: $message (Permission: $permission)';
}

class PermissionFailure extends Failure {
  final String permission;
  
  const PermissionFailure(
    super.message, {
    required this.permission,
    super.code,
    super.timestamp,
  });
}

/// Tenant related exceptions
class TenantException extends AppException {
  final String? tenantId;
  
  const TenantException(
    super.message, {
    this.tenantId,
    super.code,
    super.details,
    super.timestamp,
  });
  
  @override
  String toString() => 'TenantException: $message ${tenantId != null ? '(Tenant: $tenantId)' : ''}';
}

class TenantFailure extends Failure {
  final String? tenantId;
  
  const TenantFailure(
    super.message, {
    this.tenantId,
    super.code,
    super.timestamp,
  });
}

/// Subscription related exceptions
class SubscriptionException extends AppException {
  final String? subscriptionId;
  
  const SubscriptionException(
    super.message, {
    this.subscriptionId,
    super.code,
    super.details,
    super.timestamp,
  });
  
  @override
  String toString() => 'SubscriptionException: $message ${subscriptionId != null ? '(Subscription: $subscriptionId)' : ''}';
}

class SubscriptionFailure extends Failure {
  final String? subscriptionId;
  
  const SubscriptionFailure(
    super.message, {
    this.subscriptionId,
    super.code,
    super.timestamp,
  });
}

/// File operation exceptions
class FileException extends AppException {
  final String? filePath;
  
  const FileException(
    super.message, {
    this.filePath,
    super.code,
    super.details,
    super.timestamp,
  });
  
  @override
  String toString() => 'FileException: $message ${filePath != null ? '(File: $filePath)' : ''}';
}

class FileFailure extends Failure {
  final String? filePath;
  
  const FileFailure(
    super.message, {
    this.filePath,
    super.code,
    super.timestamp,
  });
}

/// Configuration related exceptions
class ConfigurationException extends AppException {
  final String? configKey;
  
  const ConfigurationException(
    super.message, {
    this.configKey,
    super.code,
    super.details,
    super.timestamp,
  });
  
  @override
  String toString() => 'ConfigurationException: $message ${configKey != null ? '(Config: $configKey)' : ''}';
}

class ConfigurationFailure extends Failure {
  final String? configKey;
  
  const ConfigurationFailure(
    super.message, {
    this.configKey,
    super.code,
    super.timestamp,
  });
}

/// Feature not available exceptions
class FeatureNotAvailableException extends AppException {
  final String feature;
  final String? requiredPlan;
  
  const FeatureNotAvailableException(
    super.message, {
    required this.feature,
    this.requiredPlan,
    super.code,
    super.details,
    super.timestamp,
  });
  
  @override
  String toString() => 'FeatureNotAvailableException: $message (Feature: $feature)';
}

class FeatureNotAvailableFailure extends Failure {
  final String feature;
  final String? requiredPlan;
  
  const FeatureNotAvailableFailure(
    super.message, {
    required this.feature,
    this.requiredPlan,
    super.code,
    super.timestamp,
  });
}

/// Timeout exceptions
class TimeoutException extends AppException {
  final Duration timeout;
  
  const TimeoutException(
    super.message, {
    required this.timeout,
    super.code,
    super.details,
    super.timestamp,
  });
  
  @override
  String toString() => 'TimeoutException: $message (Timeout: ${timeout.inMilliseconds}ms)';
}

class TimeoutFailure extends Failure {
  final Duration timeout;
  
  const TimeoutFailure(
    super.message, {
    required this.timeout,
    super.code,
    super.timestamp,
  });
}

/// Conflict exceptions (for optimistic locking, concurrent modifications)
class ConflictException extends AppException {
  final String? resourceId;
  final String? conflictType;
  
  const ConflictException(
    super.message, {
    this.resourceId,
    this.conflictType,
    super.code,
    super.details,
    super.timestamp,
  });
  
  @override
  String toString() => 'ConflictException: $message ${resourceId != null ? '(Resource: $resourceId)' : ''}';
}

class ConflictFailure extends Failure {
  final String? resourceId;
  final String? conflictType;
  
  const ConflictFailure(
    super.message, {
    this.resourceId,
    this.conflictType,
    super.code,
    super.timestamp,
  });
}

/// Resource not found exceptions
class NotFoundException extends AppException {
  final String? resourceType;
  final String? resourceId;
  
  const NotFoundException(
    super.message, {
    this.resourceType,
    this.resourceId,
    super.code,
    super.details,
    super.timestamp,
  });
  
  @override
  String toString() => 'NotFoundException: $message ${resourceType != null ? '($resourceType${resourceId != null ? ': $resourceId' : ''})' : ''}';
}

class NotFoundFailure extends Failure {
  final String? resourceType;
  final String? resourceId;
  
  const NotFoundFailure(
    super.message, {
    this.resourceType,
    this.resourceId,
    super.code,
    super.timestamp,
  });
}

/// Rate limiting exceptions
class RateLimitException extends AppException {
  final int retryAfterSeconds;
  
  const RateLimitException(
    super.message, {
    required this.retryAfterSeconds,
    super.code,
    super.details,
    super.timestamp,
  });
  
  @override
  String toString() => 'RateLimitException: $message (Retry after: ${retryAfterSeconds}s)';
}

class RateLimitFailure extends Failure {
  final int retryAfterSeconds;
  
  const RateLimitFailure(
    super.message, {
    required this.retryAfterSeconds,
    super.code,
    super.timestamp,
  });
}

/// Predefined common exceptions with user-friendly messages in Indonesian
class CommonExceptions {
  // Authentication errors
  static const invalidCredentials = AuthenticationException(
    'Email atau password tidak valid',
    code: 'INVALID_CREDENTIALS',
  );
  
  static const accountLocked = AuthenticationException(
    'Akun telah dikunci. Silakan hubungi administrator',
    code: 'ACCOUNT_LOCKED',
  );
  
  static const accountInactive = AuthenticationException(
    'Akun tidak aktif. Silakan hubungi administrator',
    code: 'ACCOUNT_INACTIVE',
  );
  
  static const tokenExpired = AuthenticationException(
    'Sesi telah berakhir. Silakan login kembali',
    code: 'TOKEN_EXPIRED',
  );
  
  // Authorization errors
  static const accessDenied = AuthorizationException(
    'Anda tidak memiliki izin untuk mengakses fitur ini',
    code: 'ACCESS_DENIED',
  );
  
  static const insufficientPermissions = AuthorizationException(
    'Izin tidak mencukupi untuk melakukan tindakan ini',
    code: 'INSUFFICIENT_PERMISSIONS',
  );
  
  // Business logic errors
  static const insufficientStock = BusinessException(
    'Stok tidak mencukupi untuk transaksi ini',
    code: 'INSUFFICIENT_STOCK',
  );
  
  static const invalidTransaction = BusinessException(
    'Transaksi tidak valid',
    code: 'INVALID_TRANSACTION',
  );
  
  static const duplicateEntry = BusinessException(
    'Data sudah ada dalam sistem',
    code: 'DUPLICATE_ENTRY',
  );
  
  // Tenant errors
  static const tenantNotFound = TenantException(
    'Tenant tidak ditemukan',
    code: 'TENANT_NOT_FOUND',
  );
  
  static const tenantInactive = TenantException(
    'Tenant tidak aktif',
    code: 'TENANT_INACTIVE',
  );
  
  // Subscription errors
  static const subscriptionExpired = SubscriptionException(
    'Langganan telah berakhir. Silakan perpanjang langganan',
    code: 'SUBSCRIPTION_EXPIRED',
  );
  
  static const subscriptionLimitReached = SubscriptionException(
    'Batas langganan telah tercapai',
    code: 'SUBSCRIPTION_LIMIT_REACHED',
  );
  
  // File operation errors
  static const fileNotFound = FileException(
    'File tidak ditemukan',
    code: 'FILE_NOT_FOUND',
  );
  
  static const fileTooLarge = FileException(
    'Ukuran file terlalu besar',
    code: 'FILE_TOO_LARGE',
  );
  
  static const unsupportedFileType = FileException(
    'Tipe file tidak didukung',
    code: 'UNSUPPORTED_FILE_TYPE',
  );
  
  // Configuration errors
  static const configurationMissing = ConfigurationException(
    'Konfigurasi aplikasi tidak lengkap',
    code: 'CONFIGURATION_MISSING',
  );
  
  // Feature availability errors
  static FeatureNotAvailableException featureRequiresPremium(String feature) =>
      FeatureNotAvailableException(
        'Fitur $feature memerlukan langganan Premium',
        feature: feature,
        requiredPlan: 'Premium',
        code: 'FEATURE_REQUIRES_PREMIUM',
      );
  
  // Timeout errors
  static TimeoutException requestTimeout(Duration timeout) =>
      TimeoutException(
        'Permintaan timeout setelah ${timeout.inSeconds} detik',
        timeout: timeout,
        code: 'REQUEST_TIMEOUT',
      );
  
  // Resource not found errors
  static NotFoundException productNotFound(String productId) =>
      NotFoundException(
        'Produk tidak ditemukan',
        resourceType: 'Product',
        resourceId: productId,
        code: 'PRODUCT_NOT_FOUND',
      );
  
  static NotFoundException customerNotFound(String customerId) =>
      NotFoundException(
        'Pelanggan tidak ditemukan',
        resourceType: 'Customer',
        resourceId: customerId,
        code: 'CUSTOMER_NOT_FOUND',
      );
  
  static NotFoundException transactionNotFound(String transactionId) =>
      NotFoundException(
        'Transaksi tidak ditemukan',
        resourceType: 'Transaction',
        resourceId: transactionId,
        code: 'TRANSACTION_NOT_FOUND',
      );
  
  static NotFoundException outletNotFound(String outletId) =>
      NotFoundException(
        'Outlet tidak ditemukan',
        resourceType: 'Outlet',
        resourceId: outletId,
        code: 'OUTLET_NOT_FOUND',
      );
  
  // Rate limiting errors
  static RateLimitException tooManyRequests(int retryAfter) =>
      RateLimitException(
        'Terlalu banyak permintaan. Silakan coba lagi dalam $retryAfter detik',
        retryAfterSeconds: retryAfter,
        code: 'TOO_MANY_REQUESTS',
      );
}

/// Predefined common failures for use cases
class CommonFailures {
  static const authenticationFailure = AuthenticationFailure(
    'Autentikasi gagal',
    code: 'AUTHENTICATION_FAILED',
  );
  
  static const authorizationFailure = AuthorizationFailure(
    'Autorisasi gagal',
    code: 'AUTHORIZATION_FAILED',
  );
  
  static const validationFailure = ValidationFailure(
    'Validasi data gagal',
    code: 'VALIDATION_FAILED',
  );
  
  static const businessFailure = BusinessFailure(
    'Proses bisnis gagal',
    code: 'BUSINESS_FAILED',
  );
  
  static const dataFailure = DataFailure(
    'Operasi data gagal',
    code: 'DATA_FAILED',
  );
  
  static const notFoundFailure = NotFoundFailure(
    'Data tidak ditemukan',
    code: 'NOT_FOUND',
  );
  
  static const conflictFailure = ConflictFailure(
    'Terjadi konflik data',
    code: 'CONFLICT',
  );
  
  static const timeoutFailure = TimeoutFailure(
    'Operasi timeout',
    timeout: Duration(seconds: 30),
    code: 'TIMEOUT',
  );
}