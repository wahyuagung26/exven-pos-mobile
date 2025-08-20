import 'package:dio/dio.dart';

import '../../storage/secure_storage.dart';

/// Interceptor for handling multi-tenant requests
/// Adds tenant ID to all requests for proper data isolation
class TenantInterceptor extends Interceptor {
  final SecureStorage _secureStorage = SecureStorage();
  
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip tenant header for auth endpoints
    if (_isAuthEndpoint(options.path)) {
      handler.next(options);
      return;
    }

    // Get current tenant ID from secure storage
    final tenantId = await _secureStorage.getCurrentTenantId();
    
    if (tenantId != null && tenantId.isNotEmpty) {
      // Add tenant header
      options.headers['X-Tenant-ID'] = tenantId;
      
      // Optionally add tenant ID to query parameters for certain endpoints
      if (_shouldAddToQueryParams(options.path)) {
        options.queryParameters['tenant_id'] = tenantId;
      }
    }
    
    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    // Check if response contains tenant switch information
    if (response.data is Map<String, dynamic>) {
      final data = response.data as Map<String, dynamic>;
      
      // Check for tenant switch response
      if (data.containsKey('tenant_id') && data.containsKey('tenant_switch')) {
        final newTenantId = data['tenant_id']?.toString();
        if (newTenantId != null) {
          await _secureStorage.saveCurrentTenantId(newTenantId);
        }
      }
      
      // Check for tenant information in login response
      if (_isLoginResponse(response.requestOptions.path) && 
          data.containsKey('tenant')) {
        final tenantData = data['tenant'];
        if (tenantData is Map<String, dynamic>) {
          final tenantId = tenantData['id']?.toString();
          if (tenantId != null) {
            await _secureStorage.saveCurrentTenantId(tenantId);
          }
        }
      }
    }
    
    handler.next(response);
  }

  /// Check if endpoint is auth-related (doesn't require tenant)
  bool _isAuthEndpoint(String path) {
    final authEndpoints = [
      '/auth/login',
      '/auth/register',
      '/auth/forgot-password',
      '/auth/reset-password',
      '/auth/verify-email',
      '/auth/refresh',
    ];
    
    return authEndpoints.any((endpoint) => path.contains(endpoint));
  }

  /// Check if tenant ID should be added to query parameters
  bool _shouldAddToQueryParams(String path) {
    // Some endpoints might require tenant ID in query params
    // instead of or in addition to headers
    final queryParamEndpoints = [
      '/reports',
      '/analytics',
      '/exports',
    ];
    
    return queryParamEndpoints.any((endpoint) => path.contains(endpoint));
  }

  /// Check if response is from login endpoint
  bool _isLoginResponse(String path) {
    return path.contains('/auth/login');
  }
}

/// Extension for tenant-specific requests
extension TenantRequestExtension on RequestOptions {
  /// Get tenant ID from headers
  String? get tenantId => headers['X-Tenant-ID'] as String?;
  
  /// Set tenant ID in headers
  set tenantId(String? value) {
    if (value != null) {
      headers['X-Tenant-ID'] = value;
    } else {
      headers.remove('X-Tenant-ID');
    }
  }
  
  /// Check if request has tenant ID
  bool get hasTenantId => headers.containsKey('X-Tenant-ID');
  
  /// Create a copy with tenant ID
  RequestOptions withTenantId(String tenantId) {
    final newOptions = copyWith();
    newOptions.headers['X-Tenant-ID'] = tenantId;
    return newOptions;
  }
}