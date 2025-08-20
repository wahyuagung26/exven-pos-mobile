import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_model.freezed.dart';
part 'error_model.g.dart';

/// Model for error details from API or local operations
@freezed
class ErrorModel with _$ErrorModel {
  /// Creates an error model
  const factory ErrorModel({
    /// Error message
    required String message,
    
    /// Error code for categorization
    String? code,
    
    /// HTTP status code if from API
    int? statusCode,
    
    /// Field-specific validation errors
    Map<String, List<String>>? fieldErrors,
    
    /// Stack trace for debugging (not serialized)
    @JsonKey(includeFromJson: false, includeToJson: false)
    StackTrace? stackTrace,
    
    /// Additional error details
    Map<String, dynamic>? details,
    
    /// Error timestamp
    DateTime? timestamp,
    
    /// Request path that caused the error
    String? path,
    
    /// Request ID for tracing
    String? requestId,
  }) = _ErrorModel;

  /// Creates an error model from JSON
  factory ErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorModelFromJson(json);

  /// Private constructor for custom methods
  const ErrorModel._();

  /// Create from exception
  factory ErrorModel.fromException(
    Exception exception, {
    StackTrace? stackTrace,
    int? statusCode,
  }) {
    return ErrorModel(
      message: exception.toString(),
      stackTrace: stackTrace,
      statusCode: statusCode,
      timestamp: DateTime.now(),
    );
  }

  /// Create network error
  factory ErrorModel.networkError({
    String message = 'Network connection failed',
    StackTrace? stackTrace,
  }) {
    return ErrorModel(
      message: message,
      code: 'NETWORK_ERROR',
      stackTrace: stackTrace,
      timestamp: DateTime.now(),
    );
  }

  /// Create timeout error
  factory ErrorModel.timeoutError({
    String message = 'Request timed out',
    StackTrace? stackTrace,
  }) {
    return ErrorModel(
      message: message,
      code: 'TIMEOUT_ERROR',
      stackTrace: stackTrace,
      timestamp: DateTime.now(),
    );
  }

  /// Create validation error
  factory ErrorModel.validationError({
    required String message,
    Map<String, List<String>>? fieldErrors,
  }) {
    return ErrorModel(
      message: message,
      code: 'VALIDATION_ERROR',
      statusCode: 422,
      fieldErrors: fieldErrors,
      timestamp: DateTime.now(),
    );
  }

  /// Create authentication error
  factory ErrorModel.authenticationError({
    String message = 'Authentication failed',
    Map<String, dynamic>? details,
  }) {
    return ErrorModel(
      message: message,
      code: 'AUTHENTICATION_ERROR',
      statusCode: 401,
      details: details,
      timestamp: DateTime.now(),
    );
  }

  /// Create authorization error
  factory ErrorModel.authorizationError({
    String message = 'Insufficient permissions',
    List<String>? requiredPermissions,
  }) {
    return ErrorModel(
      message: message,
      code: 'AUTHORIZATION_ERROR',
      statusCode: 403,
      details: requiredPermissions != null
          ? {'required_permissions': requiredPermissions}
          : null,
      timestamp: DateTime.now(),
    );
  }

  /// Create not found error
  factory ErrorModel.notFoundError({
    required String message,
    String? resource,
    dynamic id,
  }) {
    return ErrorModel(
      message: message,
      code: 'NOT_FOUND',
      statusCode: 404,
      details: {
        if (resource != null) 'resource': resource,
        if (id != null) 'id': id,
      },
      timestamp: DateTime.now(),
    );
  }

  /// Create server error
  factory ErrorModel.serverError({
    String message = 'Internal server error',
    Map<String, dynamic>? details,
  }) {
    return ErrorModel(
      message: message,
      code: 'SERVER_ERROR',
      statusCode: 500,
      details: details,
      timestamp: DateTime.now(),
    );
  }

  /// Create unknown error
  factory ErrorModel.unknownError({
    String message = 'An unexpected error occurred',
    StackTrace? stackTrace,
    Map<String, dynamic>? details,
  }) {
    return ErrorModel(
      message: message,
      code: 'UNKNOWN_ERROR',
      stackTrace: stackTrace,
      details: details,
      timestamp: DateTime.now(),
    );
  }

  /// Check if error is a network error
  bool get isNetworkError => code == 'NETWORK_ERROR';

  /// Check if error is a timeout error
  bool get isTimeoutError => code == 'TIMEOUT_ERROR';

  /// Check if error is a validation error
  bool get isValidationError =>
      code == 'VALIDATION_ERROR' || statusCode == 422;

  /// Check if error is an authentication error
  bool get isAuthenticationError =>
      code == 'AUTHENTICATION_ERROR' || statusCode == 401;

  /// Check if error is an authorization error
  bool get isAuthorizationError =>
      code == 'AUTHORIZATION_ERROR' || statusCode == 403;

  /// Check if error is a not found error
  bool get isNotFoundError => code == 'NOT_FOUND' || statusCode == 404;

  /// Check if error is a server error
  bool get isServerError =>
      code == 'SERVER_ERROR' || (statusCode != null && statusCode! >= 500);

  /// Check if error is retryable
  bool get isRetryable =>
      isNetworkError || isTimeoutError || (statusCode == 503);

  /// Get user-friendly error message
  String get userMessage {
    if (isNetworkError) {
      return 'Please check your internet connection and try again.';
    }
    if (isTimeoutError) {
      return 'The request took too long. Please try again.';
    }
    if (isAuthenticationError) {
      return 'Please log in to continue.';
    }
    if (isAuthorizationError) {
      return 'You do not have permission to perform this action.';
    }
    if (isNotFoundError) {
      return 'The requested resource was not found.';
    }
    if (isServerError) {
      return 'Something went wrong on our end. Please try again later.';
    }
    if (isValidationError && fieldErrors != null && fieldErrors!.isNotEmpty) {
      return fieldErrors!.values.expand((msgs) => msgs).join(', ');
    }
    return message;
  }

  /// Get all field error messages as a flat list
  List<String> get allFieldErrors {
    if (fieldErrors == null) return [];
    return fieldErrors!.values.expand((messages) => messages).toList();
  }

  /// Get error message for a specific field
  String? getFieldError(String field) {
    if (fieldErrors == null || !fieldErrors!.containsKey(field)) return null;
    final errors = fieldErrors![field];
    return errors != null && errors.isNotEmpty ? errors.first : null;
  }

  /// Check if a specific field has errors
  bool hasFieldError(String field) {
    return fieldErrors != null &&
        fieldErrors!.containsKey(field) &&
        fieldErrors![field]!.isNotEmpty;
  }
}

/// Error severity levels
enum ErrorSeverity {
  /// Low severity - can be ignored or retried
  low,
  
  /// Medium severity - should be handled but not critical
  medium,
  
  /// High severity - must be handled immediately
  high,
  
  /// Critical severity - system failure
  critical,
}

/// Extended error model with severity
@freezed
class SeverityErrorModel with _$SeverityErrorModel {
  /// Creates a severity error model
  const factory SeverityErrorModel({
    required ErrorModel error,
    required ErrorSeverity severity,
    String? category,
    Map<String, dynamic>? context,
  }) = _SeverityErrorModel;

  /// Creates a severity error model from JSON
  factory SeverityErrorModel.fromJson(Map<String, dynamic> json) =>
      _$SeverityErrorModelFromJson(json);

  /// Private constructor for custom methods
  const SeverityErrorModel._();

  /// Determine severity from error
  factory SeverityErrorModel.fromError(
    ErrorModel error, {
    Map<String, dynamic>? context,
  }) {
    ErrorSeverity severity;
    String? category;

    if (error.isServerError) {
      severity = ErrorSeverity.critical;
      category = 'server';
    } else if (error.isAuthenticationError || error.isAuthorizationError) {
      severity = ErrorSeverity.high;
      category = 'auth';
    } else if (error.isValidationError) {
      severity = ErrorSeverity.medium;
      category = 'validation';
    } else if (error.isNetworkError || error.isTimeoutError) {
      severity = ErrorSeverity.medium;
      category = 'network';
    } else if (error.isNotFoundError) {
      severity = ErrorSeverity.low;
      category = 'not_found';
    } else {
      severity = ErrorSeverity.medium;
      category = 'unknown';
    }

    return SeverityErrorModel(
      error: error,
      severity: severity,
      category: category,
      context: context,
    );
  }

  /// Check if error is critical
  bool get isCritical => severity == ErrorSeverity.critical;

  /// Check if error is high severity
  bool get isHighSeverity =>
      severity == ErrorSeverity.high || severity == ErrorSeverity.critical;

  /// Check if error should be reported
  bool get shouldReport => isHighSeverity;

  /// Check if error should show notification
  bool get shouldNotify => severity != ErrorSeverity.low;
}