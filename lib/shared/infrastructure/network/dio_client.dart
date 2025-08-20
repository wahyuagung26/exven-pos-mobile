import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'interceptors/auth_interceptor.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'interceptors/tenant_interceptor.dart';

/// Dio client configuration and initialization
class DioClient {
  static Dio? _instance;
  
  /// Base URL for API endpoints
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:8080/api/v1',
  );
  
  /// Connection timeout in milliseconds
  static const int connectionTimeout = 30000;
  
  /// Receive timeout in milliseconds
  static const int receiveTimeout = 30000;
  
  /// Send timeout in milliseconds
  static const int sendTimeout = 30000;

  /// Private constructor to prevent instantiation
  DioClient._();

  /// Get singleton instance of Dio client
  static Dio getInstance() {
    if (_instance == null) {
      _instance = _createDioClient();
    }
    return _instance!;
  }

  /// Create and configure Dio client
  static Dio _createDioClient() {
    final dio = Dio(_createBaseOptions());
    _addInterceptors(dio);
    return dio;
  }

  /// Create base options for Dio
  static BaseOptions _createBaseOptions() {
    return BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(milliseconds: connectionTimeout),
      receiveTimeout: const Duration(milliseconds: receiveTimeout),
      sendTimeout: const Duration(milliseconds: sendTimeout),
      headers: _defaultHeaders(),
      responseType: ResponseType.json,
      contentType: 'application/json',
      validateStatus: (status) {
        // Accept any status code less than 500
        return status != null && status < 500;
      },
    );
  }

  /// Default headers for all requests
  static Map<String, dynamic> _defaultHeaders() {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'X-App-Version': '1.0.0',
      'X-Platform': _getPlatform(),
    };
  }

  /// Get current platform
  static String _getPlatform() {
    if (kIsWeb) return 'web';
    if (defaultTargetPlatform == TargetPlatform.iOS) return 'ios';
    if (defaultTargetPlatform == TargetPlatform.android) return 'android';
    return 'unknown';
  }

  /// Add interceptors to Dio instance
  static void _addInterceptors(Dio dio) {
    // Clear any existing interceptors
    dio.interceptors.clear();
    
    // Add interceptors in order of execution
    dio.interceptors.addAll([
      // Authentication interceptor (adds auth token)
      AuthInterceptor(),
      
      // Tenant interceptor (adds tenant ID)
      TenantInterceptor(),
      
      // Logging interceptor (logs requests/responses)
      if (kDebugMode) LoggingInterceptor(),
      
      // Error interceptor (handles errors globally)
      ErrorInterceptor(),
    ]);
  }

  /// Reset the Dio instance (useful for logout or configuration changes)
  static void reset() {
    _instance = null;
  }

  /// Update base URL dynamically
  static void updateBaseUrl(String newBaseUrl) {
    if (_instance != null) {
      _instance!.options.baseUrl = newBaseUrl;
    }
  }

  /// Add custom interceptor
  static void addInterceptor(Interceptor interceptor) {
    getInstance().interceptors.add(interceptor);
  }

  /// Remove interceptor by type
  static void removeInterceptor<T extends Interceptor>() {
    getInstance().interceptors.removeWhere((interceptor) => interceptor is T);
  }

  /// Create a new Dio instance with custom configuration
  static Dio createCustomInstance({
    String? baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    Map<String, dynamic>? headers,
    List<Interceptor>? interceptors,
  }) {
    final options = BaseOptions(
      baseUrl: baseUrl ?? DioClient.baseUrl,
      connectTimeout: connectTimeout ?? const Duration(milliseconds: connectionTimeout),
      receiveTimeout: receiveTimeout ?? const Duration(milliseconds: receiveTimeout),
      sendTimeout: sendTimeout ?? const Duration(milliseconds: sendTimeout),
      headers: headers ?? _defaultHeaders(),
      responseType: ResponseType.json,
      contentType: 'application/json',
    );

    final dio = Dio(options);
    
    if (interceptors != null) {
      dio.interceptors.addAll(interceptors);
    }
    
    return dio;
  }
}

/// Extension methods for Dio
extension DioExtensions on Dio {
  /// Perform a GET request with retry logic
  Future<Response<T>> getWithRetry<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    int maxRetries = 3,
    Duration retryDelay = const Duration(seconds: 1),
  }) async {
    int attempt = 0;
    
    while (attempt < maxRetries) {
      try {
        return await get<T>(
          path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
        );
      } on DioException catch (e) {
        attempt++;
        
        if (attempt >= maxRetries || !_isRetryable(e)) {
          rethrow;
        }
        
        await Future.delayed(retryDelay * attempt);
      }
    }
    
    throw DioException(
      requestOptions: RequestOptions(path: path),
      message: 'Max retry attempts exceeded',
    );
  }

  /// Perform a POST request with retry logic
  Future<Response<T>> postWithRetry<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
    int maxRetries = 3,
    Duration retryDelay = const Duration(seconds: 1),
  }) async {
    int attempt = 0;
    
    while (attempt < maxRetries) {
      try {
        return await post<T>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        );
      } on DioException catch (e) {
        attempt++;
        
        if (attempt >= maxRetries || !_isRetryable(e)) {
          rethrow;
        }
        
        await Future.delayed(retryDelay * attempt);
      }
    }
    
    throw DioException(
      requestOptions: RequestOptions(path: path),
      message: 'Max retry attempts exceeded',
    );
  }

  /// Check if error is retryable
  bool _isRetryable(DioException error) {
    // Retry on network errors
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.connectionError) {
      return true;
    }
    
    // Retry on specific status codes
    if (error.response != null) {
      final statusCode = error.response!.statusCode;
      // Retry on 503 Service Unavailable or 429 Too Many Requests
      return statusCode == 503 || statusCode == 429;
    }
    
    return false;
  }
}

/// Configuration class for API endpoints
class ApiEndpoints {
  // Auth endpoints
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String currentUser = '/auth/me';
  
  // Tenant endpoints
  static const String tenants = '/tenants';
  static const String currentTenant = '/tenants/current';
  
  // Product endpoints
  static const String products = '/products';
  static const String categories = '/categories';
  
  // Customer endpoints
  static const String customers = '/customers';
  
  // Transaction endpoints
  static const String transactions = '/transactions';
  static const String transactionItems = '/transaction-items';
  
  // Report endpoints
  static const String reports = '/reports';
  static const String salesReport = '/reports/sales';
  static const String inventoryReport = '/reports/inventory';
  
  // Helper method to build endpoint with ID
  static String withId(String endpoint, dynamic id) => '$endpoint/$id';
  
  // Helper method to build nested endpoint
  static String nested(String parent, dynamic parentId, String child) =>
      '$parent/$parentId/$child';
}