import 'package:dio/dio.dart';

import '../../storage/secure_storage.dart';

/// Interceptor for handling authentication
/// Adds authentication token to requests and handles token refresh
class AuthInterceptor extends Interceptor {
  final SecureStorage _secureStorage = SecureStorage();
  
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip auth for public endpoints
    if (_isPublicEndpoint(options.path)) {
      handler.next(options);
      return;
    }

    // Get access token from secure storage
    final accessToken = await _secureStorage.getAccessToken();
    
    if (accessToken != null && accessToken.isNotEmpty) {
      // Add authorization header
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    
    handler.next(options);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Check if error is due to expired token
    if (err.response?.statusCode == 401) {
      // Check if this was already a token refresh attempt
      if (err.requestOptions.path.contains('refresh')) {
        // Token refresh failed, clear tokens and redirect to login
        await _handleAuthenticationFailure();
        handler.next(err);
        return;
      }

      // Try to refresh token
      final refreshSuccess = await _refreshToken(err.requestOptions);
      
      if (refreshSuccess) {
        // Retry the original request with new token
        try {
          final response = await _retryRequest(err.requestOptions);
          handler.resolve(response);
          return;
        } catch (e) {
          // Retry failed
          handler.next(err);
          return;
        }
      } else {
        // Refresh failed, clear tokens
        await _handleAuthenticationFailure();
      }
    }
    
    handler.next(err);
  }

  /// Check if endpoint is public (doesn't require authentication)
  bool _isPublicEndpoint(String path) {
    final publicEndpoints = [
      '/auth/login',
      '/auth/register',
      '/auth/forgot-password',
      '/auth/reset-password',
      '/auth/verify-email',
      '/health',
      '/version',
    ];
    
    return publicEndpoints.any((endpoint) => path.contains(endpoint));
  }

  /// Refresh access token using refresh token
  Future<bool> _refreshToken(RequestOptions requestOptions) async {
    try {
      final refreshToken = await _secureStorage.getRefreshToken();
      
      if (refreshToken == null || refreshToken.isEmpty) {
        return false;
      }

      // Create new Dio instance for token refresh to avoid interceptor loop
      final dio = Dio(BaseOptions(
        baseUrl: requestOptions.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ));

      final response = await dio.post(
        '/auth/refresh',
        data: {'refresh_token': refreshToken},
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        
        // Save new tokens
        final newAccessToken = data['access_token'] as String?;
        final newRefreshToken = data['refresh_token'] as String?;
        
        if (newAccessToken != null) {
          await _secureStorage.saveAccessToken(newAccessToken);
        }
        
        if (newRefreshToken != null) {
          await _secureStorage.saveRefreshToken(newRefreshToken);
        }
        
        return true;
      }
      
      return false;
    } catch (e) {
      // Token refresh failed
      return false;
    }
  }

  /// Retry the original request with new token
  Future<Response> _retryRequest(RequestOptions requestOptions) async {
    // Get new access token
    final accessToken = await _secureStorage.getAccessToken();
    
    if (accessToken != null && accessToken.isNotEmpty) {
      // Update authorization header
      requestOptions.headers['Authorization'] = 'Bearer $accessToken';
    }

    // Create new Dio instance for retry to avoid interceptor loop
    final dio = Dio(BaseOptions(
      baseUrl: requestOptions.baseUrl,
      connectTimeout: requestOptions.connectTimeout,
      receiveTimeout: requestOptions.receiveTimeout,
      sendTimeout: requestOptions.sendTimeout,
    ));

    // Perform the request
    return await dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: Options(
        method: requestOptions.method,
        headers: requestOptions.headers,
        responseType: requestOptions.responseType,
        contentType: requestOptions.contentType,
      ),
    );
  }

  /// Handle authentication failure
  Future<void> _handleAuthenticationFailure() async {
    // Clear all auth-related data
    await _secureStorage.clearTokens();
    await _secureStorage.clearUserData();
    
    // Note: Navigation to login screen should be handled by the app's
    // authentication state management (e.g., Riverpod provider)
    // This interceptor just clears the data
  }
}