import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Secure storage service for sensitive data
/// Uses flutter_secure_storage for encrypted storage on device
class SecureStorage {
  static final SecureStorage _instance = SecureStorage._internal();
  factory SecureStorage() => _instance;
  SecureStorage._internal();

  /// Flutter secure storage instance
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
      // Required for API 21 and below
      sharedPreferencesName: 'pos_secure_prefs',
      preferencesKeyPrefix: 'pos_',
    ),
    iOptions: IOSOptions(
      groupId: 'group.com.exven.pos',
      accountName: 'ExVenPOS',
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
    lOptions: LinuxOptions(
      applicationId: 'com.exven.pos',
    ),
    webOptions: WebOptions(
      dbName: 'pos_secure_storage',
      publicKey: 'pos_public_key',
    ),
    mOptions: MacOsOptions(
      groupId: 'group.com.exven.pos',
      accountName: 'ExVenPOS',
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
    wOptions: WindowsOptions(
      serviceName: 'ExVenPOS',
      packageName: 'com.exven.pos',
    ),
  );

  // Storage keys
  static const String _keyAccessToken = 'access_token';
  static const String _keyRefreshToken = 'refresh_token';
  static const String _keyTokenExpiry = 'token_expiry';
  static const String _keyCurrentUserId = 'current_user_id';
  static const String _keyCurrentTenantId = 'current_tenant_id';
  static const String _keyUserProfile = 'user_profile';
  static const String _keyTenantInfo = 'tenant_info';
  static const String _keyDeviceId = 'device_id';
  static const String _keyBiometricEnabled = 'biometric_enabled';
  static const String _keyLastLoginEmail = 'last_login_email';
  static const String _keyRememberLogin = 'remember_login';

  /// Save access token
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _keyAccessToken, value: token);
  }

  /// Get access token
  Future<String?> getAccessToken() async {
    return await _storage.read(key: _keyAccessToken);
  }

  /// Save refresh token
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _keyRefreshToken, value: token);
  }

  /// Get refresh token
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _keyRefreshToken);
  }

  /// Save token expiry timestamp
  Future<void> saveTokenExpiry(DateTime expiry) async {
    await _storage.write(
      key: _keyTokenExpiry,
      value: expiry.millisecondsSinceEpoch.toString(),
    );
  }

  /// Get token expiry timestamp
  Future<DateTime?> getTokenExpiry() async {
    final expiryStr = await _storage.read(key: _keyTokenExpiry);
    if (expiryStr != null) {
      return DateTime.fromMillisecondsSinceEpoch(int.parse(expiryStr));
    }
    return null;
  }

  /// Check if token is expired (with 5 minute buffer)
  Future<bool> isTokenExpired() async {
    final expiry = await getTokenExpiry();
    if (expiry == null) return true;
    
    final now = DateTime.now();
    final bufferTime = expiry.subtract(const Duration(minutes: 5));
    return now.isAfter(bufferTime);
  }

  /// Save current user ID
  Future<void> saveCurrentUserId(String userId) async {
    await _storage.write(key: _keyCurrentUserId, value: userId);
  }

  /// Get current user ID
  Future<String?> getCurrentUserId() async {
    return await _storage.read(key: _keyCurrentUserId);
  }

  /// Save current tenant ID
  Future<void> saveCurrentTenantId(String tenantId) async {
    await _storage.write(key: _keyCurrentTenantId, value: tenantId);
  }

  /// Get current tenant ID
  Future<String?> getCurrentTenantId() async {
    return await _storage.read(key: _keyCurrentTenantId);
  }

  /// Save user profile data
  Future<void> saveUserProfile(Map<String, dynamic> profile) async {
    final jsonString = json.encode(profile);
    await _storage.write(key: _keyUserProfile, value: jsonString);
  }

  /// Get user profile data
  Future<Map<String, dynamic>?> getUserProfile() async {
    final jsonString = await _storage.read(key: _keyUserProfile);
    if (jsonString != null) {
      return json.decode(jsonString) as Map<String, dynamic>;
    }
    return null;
  }

  /// Save tenant information
  Future<void> saveTenantInfo(Map<String, dynamic> tenantInfo) async {
    final jsonString = json.encode(tenantInfo);
    await _storage.write(key: _keyTenantInfo, value: jsonString);
  }

  /// Get tenant information
  Future<Map<String, dynamic>?> getTenantInfo() async {
    final jsonString = await _storage.read(key: _keyTenantInfo);
    if (jsonString != null) {
      return json.decode(jsonString) as Map<String, dynamic>;
    }
    return null;
  }

  /// Save device ID
  Future<void> saveDeviceId(String deviceId) async {
    await _storage.write(key: _keyDeviceId, value: deviceId);
  }

  /// Get device ID
  Future<String?> getDeviceId() async {
    return await _storage.read(key: _keyDeviceId);
  }

  /// Save biometric authentication preference
  Future<void> setBiometricEnabled(bool enabled) async {
    await _storage.write(
      key: _keyBiometricEnabled,
      value: enabled.toString(),
    );
  }

  /// Get biometric authentication preference
  Future<bool> isBiometricEnabled() async {
    final value = await _storage.read(key: _keyBiometricEnabled);
    return value == 'true';
  }

  /// Save last login email for convenience
  Future<void> saveLastLoginEmail(String email) async {
    await _storage.write(key: _keyLastLoginEmail, value: email);
  }

  /// Get last login email
  Future<String?> getLastLoginEmail() async {
    return await _storage.read(key: _keyLastLoginEmail);
  }

  /// Save remember login preference
  Future<void> setRememberLogin(bool remember) async {
    await _storage.write(key: _keyRememberLogin, value: remember.toString());
  }

  /// Get remember login preference
  Future<bool> shouldRememberLogin() async {
    final value = await _storage.read(key: _keyRememberLogin);
    return value == 'true';
  }

  /// Clear all authentication tokens
  Future<void> clearTokens() async {
    await _storage.delete(key: _keyAccessToken);
    await _storage.delete(key: _keyRefreshToken);
    await _storage.delete(key: _keyTokenExpiry);
  }

  /// Clear all user-related data
  Future<void> clearUserData() async {
    await _storage.delete(key: _keyCurrentUserId);
    await _storage.delete(key: _keyUserProfile);
  }

  /// Clear tenant-related data
  Future<void> clearTenantData() async {
    await _storage.delete(key: _keyCurrentTenantId);
    await _storage.delete(key: _keyTenantInfo);
  }

  /// Clear all stored data (logout)
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  /// Clear all data except preferences and device info
  Future<void> clearSessionData() async {
    await clearTokens();
    await clearUserData();
    await clearTenantData();
    // Keep device ID, biometric preference, and last login email
  }

  /// Check if user is logged in (has valid tokens)
  Future<bool> isLoggedIn() async {
    final accessToken = await getAccessToken();
    final isExpired = await isTokenExpired();
    return accessToken != null && accessToken.isNotEmpty && !isExpired;
  }

  /// Check if refresh token is available
  Future<bool> canRefreshToken() async {
    final refreshToken = await getRefreshToken();
    return refreshToken != null && refreshToken.isNotEmpty;
  }

  /// Save complete authentication data
  Future<void> saveAuthData({
    required String accessToken,
    required String refreshToken,
    required DateTime expiryTime,
    required String userId,
    required String tenantId,
    Map<String, dynamic>? userProfile,
    Map<String, dynamic>? tenantInfo,
  }) async {
    await saveAccessToken(accessToken);
    await saveRefreshToken(refreshToken);
    await saveTokenExpiry(expiryTime);
    await saveCurrentUserId(userId);
    await saveCurrentTenantId(tenantId);
    
    if (userProfile != null) {
      await saveUserProfile(userProfile);
    }
    
    if (tenantInfo != null) {
      await saveTenantInfo(tenantInfo);
    }
  }

  /// Get all authentication data
  Future<Map<String, dynamic>?> getAuthData() async {
    final accessToken = await getAccessToken();
    final refreshToken = await getRefreshToken();
    final expiry = await getTokenExpiry();
    final userId = await getCurrentUserId();
    final tenantId = await getCurrentTenantId();
    
    if (accessToken == null || userId == null || tenantId == null) {
      return null;
    }
    
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'expiry': expiry?.toIso8601String(),
      'user_id': userId,
      'tenant_id': tenantId,
      'user_profile': await getUserProfile(),
      'tenant_info': await getTenantInfo(),
    };
  }

  /// Save custom encrypted data
  Future<void> saveEncrypted(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Read custom encrypted data
  Future<String?> readEncrypted(String key) async {
    return await _storage.read(key: key);
  }

  /// Delete custom encrypted data
  Future<void> deleteEncrypted(String key) async {
    await _storage.delete(key: key);
  }

  /// Check if key exists
  Future<bool> containsKey(String key) async {
    return await _storage.containsKey(key: key);
  }

  /// Get all stored keys
  Future<Map<String, String>> readAll() async {
    return await _storage.readAll();
  }
}