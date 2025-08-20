import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import '../../core/constants/api_constants.dart';
import '../../core/errors/failures.dart';
import 'auth_util.dart';

class HttpUtil {
  static final Dio _dio = Dio();

  static void _setupDio() {
    _dio.options.baseUrl = ApiConstants.mockBaseUrl;
    _dio.options.connectTimeout = ApiConstants.connectionTimeout;
    _dio.options.receiveTimeout = ApiConstants.receiveTimeout;
    _dio.options.headers = Map<String, dynamic>.from(ApiConstants.defaultHeaders);
    
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }

  static Future<Either<Failure, Response<T>>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool requireAuth = false,
    Map<String, String>? additionalHeaders,
  }) async {
    return _makeRequest<T>(
      () => _dio.get<T>(path, queryParameters: queryParameters),
      requireAuth: requireAuth,
      additionalHeaders: additionalHeaders,
    );
  }

  static Future<Either<Failure, Response<T>>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool requireAuth = false,
    Map<String, String>? additionalHeaders,
  }) async {
    return _makeRequest<T>(
      () => _dio.post<T>(path, data: data, queryParameters: queryParameters),
      requireAuth: requireAuth,
      additionalHeaders: additionalHeaders,
    );
  }

  static Future<Either<Failure, Response<T>>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool requireAuth = false,
    Map<String, String>? additionalHeaders,
  }) async {
    return _makeRequest<T>(
      () => _dio.put<T>(path, data: data, queryParameters: queryParameters),
      requireAuth: requireAuth,
      additionalHeaders: additionalHeaders,
    );
  }

  static Future<Either<Failure, Response<T>>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool requireAuth = false,
    Map<String, String>? additionalHeaders,
  }) async {
    return _makeRequest<T>(
      () => _dio.delete<T>(path, data: data, queryParameters: queryParameters),
      requireAuth: requireAuth,
      additionalHeaders: additionalHeaders,
    );
  }

  static Future<Either<Failure, Response<T>>> _makeRequest<T>(
    Future<Response<T>> Function() request, {
    bool requireAuth = false,
    Map<String, String>? additionalHeaders,
  }) async {
    try {
      _setupDio();

      if (requireAuth) {
        final token = await AuthUtil.getAuthToken();
        if (token != null) {
          _dio.options.headers['Authorization'] = 'Bearer $token';
        }
      }

      if (additionalHeaders != null) {
        _dio.options.headers.addAll(additionalHeaders);
      }

      final response = await request();
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  static Failure _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkFailure(message: 'Connection timeout');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data?['message'] ?? 'Server error';
        
        switch (statusCode) {
          case 400:
            return ValidationFailure(message: message);
          case 401:
            return AuthFailure(message: 'Authentication failed');
          case 403:
            return AuthFailure(message: 'Access denied');
          case 404:
            return NotFoundFailure(message: 'Resource not found');
          case 422:
            return ValidationFailure(message: message);
          case 500:
          default:
            return ServerFailure(message: message);
        }
      case DioExceptionType.cancel:
        return NetworkFailure(message: 'Request cancelled');
      case DioExceptionType.unknown:
        return NetworkFailure(message: 'Network error occurred');
      default:
        return NetworkFailure(message: 'Connection error');
    }
  }

  static void updateBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  static void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  static void removeAuthToken() {
    _dio.options.headers.remove('Authorization');
  }

  static void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }
}