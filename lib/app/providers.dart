import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../shared/data/api/api_client.dart';
import '../shared/data/storage/secure_storage.dart';

// Core infrastructure providers
final dioProvider = Provider<Dio>((ref) => ApiClient.instance);

final secureStorageProvider = Provider<SecureStorage>((ref) => SecureStorage());

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

// Legacy provider for compatibility
final flutterSecureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

// Connectivity provider (future enhancement)
final connectivityProvider = Provider<bool>((ref) {
  // For now, assume always connected
  // In Phase 3, we can add actual connectivity checking
  return true;
});

// Authentication state providers
final isAuthenticatedProvider = StateProvider<bool>((ref) {
  return false;
});

final currentUserProvider = StateProvider<Map<String, dynamic>?>((ref) {
  return null;
});