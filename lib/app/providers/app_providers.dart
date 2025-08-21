import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logger/logger.dart';

import '../constants/app_constants.dart';

// =============================================================================
// HTTP CLIENT PROVIDER
// =============================================================================

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: AppConstants.baseUrl,
    connectTimeout: AppConstants.connectTimeout,
    receiveTimeout: AppConstants.receiveTimeout,
    sendTimeout: AppConstants.sendTimeout,
    headers: AppConstants.defaultHeaders,
    validateStatus: (status) {
      // Consider all 2xx and 3xx status codes as successful
      return status != null && status >= 200 && status < 400;
    },
  ));

  // Add interceptors for authentication, tenant context, and logging
  if (AppConstants.enableApiLogging) {
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
      responseHeader: false,
      error: true,
      logPrint: (obj) {
        // Use our logger instead of default print
        ref.read(loggerProvider).d(obj.toString());
      },
    ));
  }

  // Add authentication interceptor
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      // Add authentication token if available
      final secureStorage = ref.read(secureStorageProvider);
      final token = await secureStorage.read(key: AppConstants.accessTokenKey);
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }

      // Add tenant context if available
      final tenantData = await secureStorage.read(key: AppConstants.tenantDataKey);
      if (tenantData != null) {
        // Extract tenant ID from stored tenant data (assuming JSON format)
        // This would typically be parsed from the stored JSON
        // options.headers[AppConstants.tenantHeaderKey] = tenantId;
      }

      handler.next(options);
    },
    onError: (error, handler) async {
      // Handle token expiration and refresh
      if (error.response?.statusCode == 401) {
        try {
          final refreshed = await _refreshToken(ref);
          if (refreshed) {
            // Retry the original request with new token
            final retryOptions = error.requestOptions;
            final secureStorage = ref.read(secureStorageProvider);
            final newToken = await secureStorage.read(key: AppConstants.accessTokenKey);
            
            if (newToken != null) {
              retryOptions.headers['Authorization'] = 'Bearer $newToken';
              final response = await dio.fetch(retryOptions);
              return handler.resolve(response);
            }
          }
        } catch (e) {
          // Refresh failed, clear tokens and redirect to login
          await _clearAuthTokens(ref);
          // The router will handle redirecting to login based on auth state
        }
      }
      handler.next(error);
    },
  ));

  return dio;
});

// Helper function to refresh token
Future<bool> _refreshToken(Ref ref) async {
  try {
    final dio = Dio(); // Create a new dio instance to avoid interceptor loops
    dio.options.baseUrl = AppConstants.baseUrl;
    
    final secureStorage = ref.read(secureStorageProvider);
    final refreshToken = await secureStorage.read(key: AppConstants.refreshTokenKey);
    
    if (refreshToken == null) return false;

    final response = await dio.post(
      AppConstants.refreshTokenEndpoint,
      data: {'refresh_token': refreshToken},
    );

    if (response.statusCode == 200) {
      final data = response.data;
      await secureStorage.write(
        key: AppConstants.accessTokenKey, 
        value: data['access_token']?.toString(),
      );
      
      if (data['refresh_token'] != null) {
        await secureStorage.write(
          key: AppConstants.refreshTokenKey,
          value: data['refresh_token']?.toString(),
        );
      }
      
      return true;
    }
  } catch (e) {
    ref.read(loggerProvider).e('Token refresh failed: $e');
  }
  
  return false;
}

// Helper function to clear auth tokens
Future<void> _clearAuthTokens(Ref ref) async {
  final secureStorage = ref.read(secureStorageProvider);
  await Future.wait([
    secureStorage.delete(key: AppConstants.accessTokenKey),
    secureStorage.delete(key: AppConstants.refreshTokenKey),
    secureStorage.delete(key: AppConstants.userDataKey),
    secureStorage.delete(key: AppConstants.tenantDataKey),
  ]);
}

// =============================================================================
// SECURE STORAGE PROVIDER
// =============================================================================

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  const androidOptions = AndroidOptions(
    encryptedSharedPreferences: true,
    keyCipherAlgorithm: KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
    storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
  );
  
  const iosOptions = IOSOptions(
    accountName: AppConstants.appName,
    synchronizable: false,
    accessibility: KeychainAccessibility.first_unlock_this_device,
  );
  
  const linuxOptions = LinuxOptions.defaultOptions;
  
  const windowsOptions = WindowsOptions.defaultOptions;
  
  const webOptions = WebOptions(
    dbName: AppConstants.appName,
    publicKey: 'ExVenPOSLiteWebKey',
  );

  return const FlutterSecureStorage(
    aOptions: androidOptions,
    iOptions: iosOptions,
    lOptions: linuxOptions,
    wOptions: windowsOptions,
    webOptions: webOptions,
  );
});

// =============================================================================
// CONNECTIVITY PROVIDER
// =============================================================================

final connectivityProvider = Provider<Connectivity>((ref) {
  return Connectivity();
});

final connectivityStreamProvider = StreamProvider<List<ConnectivityResult>>((ref) {
  return ref.read(connectivityProvider).onConnectivityChanged;
});

final isConnectedProvider = Provider<bool>((ref) {
  final connectivityState = ref.watch(connectivityStreamProvider);
  return connectivityState.when(
    data: (results) => !results.contains(ConnectivityResult.none),
    loading: () => true, // Assume connected while loading
    error: (_, __) => false,
  );
});

// =============================================================================
// NETWORK INFO PROVIDER
// =============================================================================

final networkInfoProvider = Provider<NetworkInfo>((ref) {
  return NetworkInfo(ref.read(connectivityProvider));
});

class NetworkInfo {
  final Connectivity connectivity;

  NetworkInfo(this.connectivity);

  Future<bool> get isConnected async {
    final results = await connectivity.checkConnectivity();
    return !results.contains(ConnectivityResult.none);
  }

  Stream<bool> get connectionStream {
    return connectivity.onConnectivityChanged.map(
      (results) => !results.contains(ConnectivityResult.none),
    );
  }

  Future<List<ConnectivityResult>> get connectionType {
    return connectivity.checkConnectivity();
  }
}

// =============================================================================
// LOGGER PROVIDER
// =============================================================================

final loggerProvider = Provider<Logger>((ref) {
  return Logger(
    filter: AppConstants.enableDebugMode 
        ? DevelopmentFilter() 
        : ProductionFilter(),
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
    output: ConsoleOutput(),
  );
});

// =============================================================================
// APP STATE PROVIDERS
// =============================================================================

// App theme provider
final appThemeProvider = StateNotifierProvider<AppThemeNotifier, ThemeMode>((ref) {
  return AppThemeNotifier(ref);
});

class AppThemeNotifier extends StateNotifier<ThemeMode> {
  final Ref ref;

  AppThemeNotifier(this.ref) : super(ThemeMode.system) {
    _loadTheme();
  }

  void _loadTheme() async {
    final secureStorage = ref.read(secureStorageProvider);
    final theme = await secureStorage.read(key: AppConstants.appThemeKey);
    
    switch (theme) {
      case 'light':
        state = ThemeMode.light;
        break;
      case 'dark':
        state = ThemeMode.dark;
        break;
      default:
        state = ThemeMode.system;
        break;
    }
  }

  void setTheme(ThemeMode theme) async {
    state = theme;
    final secureStorage = ref.read(secureStorageProvider);
    await secureStorage.write(
      key: AppConstants.appThemeKey,
      value: theme.name,
    );
  }
}

// App language provider
final appLanguageProvider = StateNotifierProvider<AppLanguageNotifier, String>((ref) {
  return AppLanguageNotifier(ref);
});

class AppLanguageNotifier extends StateNotifier<String> {
  final Ref ref;

  AppLanguageNotifier(this.ref) : super('id') {
    _loadLanguage();
  }

  void _loadLanguage() async {
    final secureStorage = ref.read(secureStorageProvider);
    final language = await secureStorage.read(key: AppConstants.appLanguageKey);
    state = language ?? 'id';
  }

  void setLanguage(String language) async {
    state = language;
    final secureStorage = ref.read(secureStorageProvider);
    await secureStorage.write(
      key: AppConstants.appLanguageKey,
      value: language,
    );
  }
}

// =============================================================================
// ERROR TRACKING PROVIDER
// =============================================================================

final errorTrackingProvider = Provider<ErrorTracking>((ref) {
  return ErrorTracking(ref);
});

class ErrorTracking {
  final Ref ref;

  ErrorTracking(this.ref);

  void reportError(dynamic error, StackTrace? stackTrace) {
    if (AppConstants.enableCrashReporting) {
      // Integrate with crash reporting service like Firebase Crashlytics
      // FirebaseCrashlytics.instance.recordError(error, stackTrace);
      ref.read(loggerProvider).e('Error: $error\nStackTrace: $stackTrace');
    }
  }

  void reportMessage(String message, {Map<String, dynamic>? parameters}) {
    if (AppConstants.enableCrashReporting) {
      // Report non-fatal message to crash reporting service
      ref.read(loggerProvider).i('Message: $message, Parameters: $parameters');
    }
  }
}

// =============================================================================
// CACHE PROVIDER (Placeholder for Phase 2)
// =============================================================================

final cacheProvider = Provider<CacheManager>((ref) {
  return CacheManager(ref);
});

class CacheManager {
  final Ref ref;

  CacheManager(this.ref);

  // Placeholder for cache implementation
  Future<T?> get<T>(String key) async {
    // TODO: Implement caching in Phase 2
    return null;
  }

  Future<void> put<T>(String key, T value, {Duration? expiry}) async {
    // TODO: Implement caching in Phase 2
  }

  Future<void> remove(String key) async {
    // TODO: Implement caching in Phase 2
  }

  Future<void> clear() async {
    // TODO: Implement caching in Phase 2
  }
}