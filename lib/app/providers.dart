import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../shared/data/api/api_client.dart';
import '../shared/data/storage/secure_storage.dart';

// Core infrastructure providers
final dioProvider = Provider<Dio>((ref) => ApiClient.instance);

final secureStorageProvider = Provider<SecureStorage>((ref) => SecureStorage());

// Connectivity provider (future enhancement)
final connectivityProvider = Provider<bool>((ref) {
  // For now, assume always connected
  // In Phase 3, we can add actual connectivity checking
  return true;
});

// Theme provider
final themeProvider =
    StateProvider<bool>((ref) => false); // false = light, true = dark
