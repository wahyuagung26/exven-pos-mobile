import '../../../../core/errors/exceptions.dart';
import '../../../../data/datasources/remote/api_client.dart';
import '../models/login_response_model.dart';
import '../models/register_response_model.dart';
import '../models/token_pair_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  });

  Future<RegisterResponseModel> register({
    required String tenantName,
    String? businessType,
    required String email,
    String? phone,
    required String password,
    required String fullName,
  });

  Future<TokenPairModel> refreshToken({
    required String refreshToken,
  });

  Future<void> logout();

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  });

  Future<void> resetPassword({
    required String email,
  });

  Future<void> verifyEmail({
    required String token,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiClient.post(
        '/api/v1/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return LoginResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          message: response.data['message'] ?? 'Login failed',
          code: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: 'Login failed: $e');
    }
  }

  @override
  Future<RegisterResponseModel> register({
    required String tenantName,
    String? businessType,
    required String email,
    String? phone,
    required String password,
    required String fullName,
  }) async {
    try {
      final response = await apiClient.post(
        '/api/v1/auth/register',
        data: {
          'tenant_name': tenantName,
          if (businessType != null) 'business_type': businessType,
          'email': email,
          if (phone != null) 'phone': phone,
          'password': password,
          'full_name': fullName,
        },
      );

      if (response.statusCode == 201) {
        return RegisterResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          message: response.data['message'] ?? 'Registration failed',
          code: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: 'Registration failed: $e');
    }
  }

  @override
  Future<TokenPairModel> refreshToken({
    required String refreshToken,
  }) async {
    try {
      final response = await apiClient.post(
        '/api/v1/auth/refresh',
        data: {
          'refresh_token': refreshToken,
        },
      );

      if (response.statusCode == 200) {
        return TokenPairModel.fromJson(response.data['data']);
      } else {
        throw ServerException(
          message: response.data['message'] ?? 'Token refresh failed',
          code: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: 'Token refresh failed: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      final response = await apiClient.post('/api/v1/auth/logout');

      if (response.statusCode != 200) {
        throw ServerException(
          message: response.data['message'] ?? 'Logout failed',
          code: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: 'Logout failed: $e');
    }
  }

  @override
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final response = await apiClient.post(
        '/api/v1/auth/change-password',
        data: {
          'old_password': oldPassword,
          'new_password': newPassword,
        },
      );

      if (response.statusCode != 200) {
        throw ServerException(
          message: response.data['message'] ?? 'Password change failed',
          code: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: 'Password change failed: $e');
    }
  }

  @override
  Future<void> resetPassword({
    required String email,
  }) async {
    try {
      final response = await apiClient.post(
        '/api/v1/auth/reset-password',
        data: {
          'email': email,
        },
      );

      if (response.statusCode != 200) {
        throw ServerException(
          message: response.data['message'] ?? 'Password reset failed',
          code: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: 'Password reset failed: $e');
    }
  }

  @override
  Future<void> verifyEmail({
    required String token,
  }) async {
    try {
      final response = await apiClient.post(
        '/api/v1/auth/verify-email',
        data: {
          'token': token,
        },
      );

      if (response.statusCode != 200) {
        throw ServerException(
          message: response.data['message'] ?? 'Email verification failed',
          code: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: 'Email verification failed: $e');
    }
  }
}