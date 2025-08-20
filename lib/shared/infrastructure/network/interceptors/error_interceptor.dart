import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../data/models/error_model.dart';
import '../../services/notification_service.dart';

/// Interceptor for global error handling and user notification
/// Converts Dio errors to standardized error models and shows user-friendly messages
class ErrorInterceptor extends Interceptor {
  final NotificationService? _notificationService;
  
  /// Creates an error interceptor
  ErrorInterceptor({
    NotificationService? notificationService,
  }) : _notificationService = notificationService;

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    final errorModel = _convertDioErrorToErrorModel(err);
    
    // Show user-friendly notification for appropriate errors
    _showErrorNotification(errorModel);
    
    // Log error in debug mode
    if (kDebugMode) {
      debugPrint('API Error: ${errorModel.message}');
      if (errorModel.stackTrace != null) {
        debugPrint('Stack Trace: ${errorModel.stackTrace}');
      }
    }
    
    // Convert DioException to our custom error model
    final customError = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: errorModel,
      message: errorModel.message,
      stackTrace: err.stackTrace,
    );
    
    handler.next(customError);
  }

  /// Convert DioException to standardized ErrorModel
  ErrorModel _convertDioErrorToErrorModel(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ErrorModel.timeoutError(
          message: 'Connection timeout. Please check your internet connection.',
          stackTrace: error.stackTrace,
        );
        
      case DioExceptionType.sendTimeout:
        return ErrorModel.timeoutError(
          message: 'Send timeout. Please try again.',
          stackTrace: error.stackTrace,
        );
        
      case DioExceptionType.receiveTimeout:
        return ErrorModel.timeoutError(
          message: 'Receive timeout. Please try again.',
          stackTrace: error.stackTrace,
        );
        
      case DioExceptionType.connectionError:
        return ErrorModel.networkError(
          message: 'No internet connection. Please check your connection and try again.',
          stackTrace: error.stackTrace,
        );
        
      case DioExceptionType.badResponse:
        return _handleBadResponse(error);
        
      case DioExceptionType.cancel:
        return ErrorModel(
          message: 'Request was cancelled',
          code: 'REQUEST_CANCELLED',
          timestamp: DateTime.now(),
          stackTrace: error.stackTrace,
        );
        
      case DioExceptionType.badCertificate:
        return ErrorModel(
          message: 'Certificate verification failed. Please check your connection.',
          code: 'BAD_CERTIFICATE',
          timestamp: DateTime.now(),
          stackTrace: error.stackTrace,
        );
        
      case DioExceptionType.unknown:
        return ErrorModel.unknownError(
          message: error.message ?? 'An unexpected error occurred',
          stackTrace: error.stackTrace,
        );
    }
  }

  /// Handle bad response errors (4xx, 5xx status codes)
  ErrorModel _handleBadResponse(DioException error) {
    final response = error.response!;
    final statusCode = response.statusCode ?? 500;
    final data = response.data;
    
    // Try to extract error information from response
    String message = 'An error occurred';
    String? code;
    Map<String, List<String>>? fieldErrors;
    Map<String, dynamic>? details;
    
    if (data is Map<String, dynamic>) {
      message = data['message'] as String? ?? 
                data['error'] as String? ?? 
                message;
      code = data['code'] as String?;
      details = data;
      
      // Extract field errors
      if (data['errors'] is Map<String, dynamic>) {
        fieldErrors = _extractFieldErrors(data['errors'] as Map<String, dynamic>);
      } else if (data['field_errors'] is Map<String, dynamic>) {
        fieldErrors = _extractFieldErrors(data['field_errors'] as Map<String, dynamic>);
      }
    } else if (data is String) {
      message = data;
    }
    
    // Create appropriate error model based on status code
    switch (statusCode) {
      case 400:
        return ErrorModel.validationError(
          message: message,
          fieldErrors: fieldErrors,
        );
        
      case 401:
        return ErrorModel.authenticationError(
          message: message.isEmpty ? 'Authentication required' : message,
          details: details,
        );
        
      case 403:
        return ErrorModel.authorizationError(
          message: message.isEmpty ? 'Access denied' : message,
        );
        
      case 404:
        return ErrorModel.notFoundError(
          message: message.isEmpty ? 'Resource not found' : message,
        );
        
      case 422:
        return ErrorModel.validationError(
          message: message.isEmpty ? 'Validation failed' : message,
          fieldErrors: fieldErrors,
        );
        
      case 429:
        return ErrorModel(
          message: message.isEmpty ? 'Too many requests. Please try again later.' : message,
          code: 'RATE_LIMIT_EXCEEDED',
          statusCode: statusCode,
          timestamp: DateTime.now(),
        );
        
      case 500:
      case 502:
      case 503:
      case 504:
        return ErrorModel.serverError(
          message: message.isEmpty ? 'Server error. Please try again later.' : message,
          details: details,
        );
        
      default:
        return ErrorModel(
          message: message,
          code: code ?? 'HTTP_ERROR',
          statusCode: statusCode,
          details: details,
          timestamp: DateTime.now(),
        );
    }
  }

  /// Extract field errors from response data
  Map<String, List<String>> _extractFieldErrors(Map<String, dynamic> errorsData) {
    final fieldErrors = <String, List<String>>{};
    
    errorsData.forEach((key, value) {
      if (value is List) {
        fieldErrors[key] = value.cast<String>();
      } else if (value is String) {
        fieldErrors[key] = [value];
      } else {
        fieldErrors[key] = [value.toString()];
      }
    });
    
    return fieldErrors;
  }

  /// Show error notification to user
  void _showErrorNotification(ErrorModel error) {
    if (_notificationService == null) return;
    
    // Don't show notifications for certain types of errors
    if (_shouldSkipNotification(error)) {
      return;
    }
    
    // Get user-friendly message
    final message = error.userMessage;
    
    // Determine notification type based on error
    NotificationType notificationType;
    if (error.isNetworkError || error.isTimeoutError) {
      notificationType = NotificationType.warning;
    } else if (error.isValidationError) {
      notificationType = NotificationType.info;
    } else if (error.isServerError) {
      notificationType = NotificationType.error;
    } else {
      notificationType = NotificationType.error;
    }
    
    // Show notification
    _notificationService!.showNotification(
      title: _getNotificationTitle(error),
      message: message,
      type: notificationType,
    );
  }

  /// Determine if notification should be skipped
  bool _shouldSkipNotification(ErrorModel error) {
    // Skip notifications for certain errors
    const skipCodes = [
      'REQUEST_CANCELLED',
      'AUTHENTICATION_ERROR', // Auth errors are usually handled by auth flow
    ];
    
    return error.code != null && skipCodes.contains(error.code);
  }

  /// Get appropriate notification title based on error type
  String _getNotificationTitle(ErrorModel error) {
    if (error.isNetworkError || error.isTimeoutError) {
      return 'Connection Error';
    } else if (error.isValidationError) {
      return 'Invalid Input';
    } else if (error.isAuthorizationError) {
      return 'Access Denied';
    } else if (error.isServerError) {
      return 'Server Error';
    } else {
      return 'Error';
    }
  }
}