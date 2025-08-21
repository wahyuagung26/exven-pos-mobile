import 'package:freezed_annotation/freezed_annotation.dart';

import 'pagination_model.dart';

part 'api_response_model.freezed.dart';

/// Standard API response wrapper model
@Freezed(genericArgumentFactories: true)
class ApiResponseModel<T> with _$ApiResponseModel<T> {
  /// Creates an API response model
  const factory ApiResponseModel({
    /// Response message from server
    required String message,
    
    /// Response data payload
    required T? data,
    
    /// Pagination metadata for list responses
    PaginationModel? meta,
    
    /// Field-specific errors for validation failures
    Map<String, List<String>>? errors,
    
    /// Response timestamp
    DateTime? timestamp,
    
    /// Request ID for tracing
    String? requestId,
  }) = _ApiResponseModel<T>;


  /// Private constructor for custom methods
  const ApiResponseModel._();

  /// Check if response is successful (has data and no errors)
  bool get isSuccess => data != null && (errors == null || errors!.isEmpty);

  /// Check if response has errors
  bool get hasErrors => errors != null && errors!.isNotEmpty;

  /// Get flat list of all error messages
  List<String> get errorMessages {
    if (errors == null) return [];
    return errors!.values.expand((messages) => messages).toList();
  }

  /// Get first error message if any
  String? get firstError {
    if (!hasErrors) return null;
    return errorMessages.firstOrNull;
  }
}

/// Success response factory
@freezed
class SuccessResponse<T> with _$SuccessResponse<T> {
  /// Creates a success response
  const factory SuccessResponse({
    required String message,
    required T data,
    PaginationModel? meta,
  }) = _SuccessResponse<T>;

}

/// Error response model
@freezed
class ErrorResponse with _$ErrorResponse {
  /// Creates an error response
  const factory ErrorResponse({
    required String message,
    String? code,
    Map<String, List<String>>? errors,
    int? statusCode,
    String? path,
    DateTime? timestamp,
    String? requestId,
  }) = _ErrorResponse;

  /// Creates an error response from JSON
  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);

  /// Private constructor for custom methods
  const ErrorResponse._();

  /// Check if error is a validation error
  bool get isValidationError =>
      statusCode == 422 || (errors != null && errors!.isNotEmpty);

  /// Check if error is an authentication error
  bool get isAuthenticationError => statusCode == 401;

  /// Check if error is an authorization error
  bool get isAuthorizationError => statusCode == 403;

  /// Check if error is a not found error
  bool get isNotFoundError => statusCode == 404;

  /// Check if error is a server error
  bool get isServerError => statusCode != null && statusCode! >= 500;

  /// Get flat list of all error messages
  List<String> get errorMessages {
    if (errors == null) return [message];
    final fieldErrors = errors!.values.expand((messages) => messages).toList();
    return fieldErrors.isEmpty ? [message] : fieldErrors;
  }
}

/// Paginated response model
@Freezed(genericArgumentFactories: true)
class PaginatedResponse<T> with _$PaginatedResponse<T> {
  /// Creates a paginated response
  const factory PaginatedResponse({
    required String message,
    required List<T> data,
    required PaginationModel meta,
    DateTime? timestamp,
    String? requestId,
  }) = _PaginatedResponse<T>;


  /// Private constructor for custom methods
  const PaginatedResponse._();

  /// Check if has more pages
  bool get hasMore => meta.hasNextPage;

  /// Check if is first page
  bool get isFirstPage => meta.currentPage == 1;

  /// Check if is last page
  bool get isLastPage => !meta.hasNextPage;

  /// Get total items count
  int get totalItems => meta.totalItems;

  /// Get current page number
  int get currentPage => meta.currentPage;
}

/// Batch operation response
@freezed
class BatchResponse with _$BatchResponse {
  /// Creates a batch operation response
  const factory BatchResponse({
    required String message,
    required int successCount,
    required int failureCount,
    required int totalCount,
    List<BatchItemResult>? results,
    DateTime? timestamp,
  }) = _BatchResponse;

  /// Creates a batch response from JSON
  factory BatchResponse.fromJson(Map<String, dynamic> json) =>
      _$BatchResponseFromJson(json);

  /// Private constructor for custom methods
  const BatchResponse._();

  /// Check if all operations succeeded
  bool get isFullSuccess => failureCount == 0;

  /// Check if all operations failed
  bool get isFullFailure => successCount == 0;

  /// Check if partially successful
  bool get isPartialSuccess => successCount > 0 && failureCount > 0;

  /// Get success rate percentage
  double get successRate =>
      totalCount > 0 ? (successCount / totalCount) * 100 : 0;
}

/// Individual batch item result
@freezed
class BatchItemResult with _$BatchItemResult {
  /// Creates a batch item result
  const factory BatchItemResult({
    required int index,
    required bool success,
    String? id,
    String? error,
    Map<String, dynamic>? data,
  }) = _BatchItemResult;

  /// Creates a batch item result from JSON
  factory BatchItemResult.fromJson(Map<String, dynamic> json) =>
      _$BatchItemResultFromJson(json);
}

/// File upload response
@freezed
class FileUploadResponse with _$FileUploadResponse {
  /// Creates a file upload response
  const factory FileUploadResponse({
    required String message,
    required String fileId,
    required String fileName,
    required String fileUrl,
    required int fileSize,
    required String mimeType,
    Map<String, dynamic>? metadata,
    DateTime? uploadedAt,
  }) = _FileUploadResponse;

  /// Creates a file upload response from JSON
  factory FileUploadResponse.fromJson(Map<String, dynamic> json) =>
      _$FileUploadResponseFromJson(json);
}

/// Token response for authentication
@freezed
class TokenResponse with _$TokenResponse {
  /// Creates a token response
  const factory TokenResponse({
    required String accessToken,
    required String tokenType,
    required int expiresIn,
    String? refreshToken,
    String? scope,
    Map<String, dynamic>? user,
  }) = _TokenResponse;

  /// Creates a token response from JSON
  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);

  /// Private constructor for custom methods
  const TokenResponse._();

  /// Get expiry date time
  DateTime get expiryDateTime =>
      DateTime.now().add(Duration(seconds: expiresIn));

  /// Check if token is expired (with 5 minute buffer)
  bool get isExpired =>
      DateTime.now().isAfter(
        expiryDateTime.subtract(const Duration(minutes: 5)),
      );

  /// Get formatted authorization header value
  String get authorizationHeader => '$tokenType $accessToken';
}