import 'package:dio/dio.dart';
import '../../../domain/failures/failures.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final failure = _mapDioErrorToFailure(err);
    
    // You can add global error handling here
    // Example: show global error dialog, log to analytics, etc.
    
    handler.next(err);
  }

  Failure _mapDioErrorToFailure(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const Failure.network('Connection timeout. Please try again.');
      
      case DioExceptionType.connectionError:
        return const Failure.network('No internet connection. Please check your network.');
      
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data?['message'] ?? 'Server error occurred';
        
        switch (statusCode) {
          case 400:
            return Failure.validation(message);
          case 401:
            return const Failure.auth('Authentication failed. Please login again.');
          case 403:
            return const Failure.auth('Access denied. Insufficient permissions.');
          case 404:
            return const Failure.network('Resource not found');
          case 422:
            return Failure.validation(message);
          case 500:
            return const Failure.network('Server error. Please try again later.');
          default:
            return Failure.network(message, statusCode);
        }
      
      case DioExceptionType.cancel:
        return const Failure.network('Request was cancelled');
      
      default:
        return Failure.unknown(error.message ?? 'An unexpected error occurred');
    }
  }
}