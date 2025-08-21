import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../utils/constants.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  // Token management
  Future<void> saveToken(String token) async {
    await _storage.write(key: StorageConstants.tokenKey, value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: StorageConstants.tokenKey);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: StorageConstants.tokenKey);
  }

  // Tenant management
  Future<void> saveTenantId(String tenantId) async {
    await _storage.write(key: StorageConstants.tenantIdKey, value: tenantId);
  }

  Future<String?> getTenantId() async {
    return await _storage.read(key: StorageConstants.tenantIdKey);
  }

  Future<void> deleteTenantId() async {
    await _storage.delete(key: StorageConstants.tenantIdKey);
  }

  // User data
  Future<void> saveUserData(String userData) async {
    await _storage.write(key: StorageConstants.userKey, value: userData);
  }

  Future<String?> getUserData() async {
    return await _storage.read(key: StorageConstants.userKey);
  }

  Future<void> deleteUserData() async {
    await _storage.delete(key: StorageConstants.userKey);
  }

  // Clear all data
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}