import '../../core/utils/dependency_injection.dart';
import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../../features/auth/domain/entities/user.dart';

/// Legacy AuthUtil that bridges the gap with the new Clean Architecture auth system
/// This class provides backward compatibility for existing code
class AuthUtil {
  static AuthLocalDataSource get _localDataSource => getIt<AuthLocalDataSource>();

  /// Get the current access token
  static Future<String?> getAuthToken() async {
    try {
      return await _localDataSource.getAccessToken();
    } catch (e) {
      return null;
    }
  }

  /// Get the current refresh token
  static Future<String?> getRefreshToken() async {
    try {
      return await _localDataSource.getRefreshToken();
    } catch (e) {
      return null;
    }
  }

  /// Get the currently logged in user
  static Future<User?> getLoggedUser() async {
    try {
      final userModel = await _localDataSource.getCachedUser();
      return userModel?.toEntity();
    } catch (e) {
      return null;
    }
  }

  /// Check if user is currently logged in
  static Future<bool> isLoggedIn() async {
    try {
      final token = await getAuthToken();
      final user = await getLoggedUser();
      return token != null && token.isNotEmpty && user != null;
    } catch (e) {
      return false;
    }
  }

  /// Clear all auth data (legacy method)
  /// Note: This directly clears data without going through the auth repository
  /// For proper logout, use the AuthNotifier.logout() method instead
  static Future<void> logout() async {
    try {
      await _localDataSource.clearAuthData();
    } catch (e) {
      // Silently fail for backward compatibility
    }
  }

  /// Clear user data only
  static Future<void> clearUserData() async {
    // This method is deprecated as we now manage tokens and user data together
    // Use logout() instead for complete cleanup
    await logout();
  }

  // Deprecated methods - these are no longer supported in the new architecture
  // as token and user management is now handled by the repository layer
  
  @Deprecated('Use AuthRepository.login() instead')
  static Future<void> setAuthToken(String token) async {
    throw UnsupportedError(
      'setAuthToken is deprecated. Use AuthRepository.login() instead',
    );
  }

  @Deprecated('Use AuthRepository methods instead')
  static Future<void> setLoggedUser(User user) async {
    throw UnsupportedError(
      'setLoggedUser is deprecated. User data is now managed by AuthRepository',
    );
  }

  @Deprecated('Use AuthRepository methods instead')
  static Future<void> updateLoggedUser(User user) async {
    throw UnsupportedError(
      'updateLoggedUser is deprecated. User data is now managed by AuthRepository',
    );
  }
}