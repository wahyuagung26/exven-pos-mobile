# Flutter POS Client: Simplified Clean Architecture

## 🎯 Core Principles (Anti-Hallucination Design)

1. **Minimal Viable Structure** - Hanya folder yang benar-benar dibutuhkan
2. **Consistent Naming** - Strict conventions tanpa pengecualian
3. **Clear Decision Trees** - Kapan pakai pattern apa
4. **Complete Examples** - Implementasi lengkap, bukan skeleton
5. **MVP-First Approach** - Kompleksitas bertahap

## 📁 Simplified Project Structure

```
pos_flutter/
├── lib/
│   ├── main.dart
│   ├── app/
│   │   ├── app.dart                 # Main app widget
│   │   ├── router.dart              # GoRouter setup
│   │   └── providers.dart           # Global providers
│   ├── features/
│   │   ├── auth/
│   │   │   ├── data/
│   │   │   │   ├── models/          # JSON models only
│   │   │   │   ├── sources/         # API & local data
│   │   │   │   └── repository.dart  # Repository implementation
│   │   │   ├── domain/
│   │   │   │   ├── entities/        # Business objects
│   │   │   │   ├── repository.dart  # Repository interface
│   │   │   │   └── usecases/        # Business logic
│   │   │   ├── ui/
│   │   │   │   ├── pages/           # Screen widgets
│   │   │   │   └── widgets/         # UI components
│   │   │   └── providers.dart       # Feature providers
│   │   └── products/
│   │       └── [same structure as auth]
│   ├── shared/
│   │   ├── data/
│   │   │   ├── api/                 # HTTP client & interceptors
│   │   │   └── storage/             # Secure storage
│   │   ├── domain/
│   │   │   ├── entities/            # Common entities
│   │   │   └── failures/            # Error types
│   │   ├── ui/
│   │   │   ├── theme/               # App theme
│   │   │   └── widgets/             # Common widgets
│   │   └── utils/
│   │       ├── constants.dart
│   │       ├── extensions.dart
│   │       └── helpers.dart
│   └── l10n/                        # Localization
├── test/                            # Tests mirror lib structure
└── assets/                          # Static assets
```

## 🏗️ Architecture Decision Trees

### Provider Selection Matrix

| Use Case | Provider Type | Example |
|----------|---------------|---------|
| Repository/Service injection | `Provider<T>` | `Provider<AuthRepository>` |
| UI state with mutations | `StateNotifierProvider` | `StateNotifierProvider<LoginNotifier, LoginState>` |
| One-time async operation | `FutureProvider` | `FutureProvider<UserEntity>` |
| Real-time data stream | `StreamProvider` | `StreamProvider<List<Product>>` |
| Computed values | `Provider` | `Provider<bool>((ref) => ref.watch(authProvider).isLoggedIn)` |

### File Naming Convention (STRICT)

```
Files: snake_case.dart
Classes: PascalCase
Variables: camelCase
Constants: SCREAMING_SNAKE_CASE

✅ EXAMPLES:
auth_repository.dart -> class AuthRepository
login_usecase.dart -> class LoginUseCase  
api_constants.dart -> class ApiConstants
```

## 🔐 Simplified Authentication System

### Complete Auth State Management

```dart
// features/auth/providers.dart
@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(UserEntity user) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.error(String message) = _Error;
}

class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  AuthNotifier(this._loginUseCase, this._logoutUseCase, this._getCurrentUserUseCase) 
    : super(const AuthState.initial());

  Future<void> checkAuthStatus() async {
    state = const AuthState.loading();
    
    final result = await _getCurrentUserUseCase();
    result.fold(
      (failure) => state = const AuthState.unauthenticated(),
      (user) => state = AuthState.authenticated(user),
    );
  }

  Future<void> login(String email, String password) async {
    state = const AuthState.loading();
    
    final result = await _loginUseCase(LoginParams(email, password));
    result.fold(
      (failure) => state = AuthState.error(failure.message),
      (user) => state = AuthState.authenticated(user),
    );
  }

  Future<void> logout() async {
    await _logoutUseCase();
    state = const AuthState.unauthenticated();
  }
}

// Provider definitions
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.read(authRemoteDataSourceProvider),
    secureStorage: ref.read(secureStorageProvider),
  );
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.read(authRepositoryProvider));
});

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  return LogoutUseCase(ref.read(authRepositoryProvider));
});

final getCurrentUserUseCaseProvider = Provider<GetCurrentUserUseCase>((ref) {
  return GetCurrentUserUseCase(ref.read(authRepositoryProvider));
});

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    ref.read(loginUseCaseProvider),
    ref.read(logoutUseCaseProvider),
    ref.read(getCurrentUserUseCaseProvider),
  );
});

// Computed providers for common checks
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authNotifierProvider);
  return authState.maybeWhen(
    authenticated: (_) => true,
    orElse: () => false,
  );
});

final currentUserProvider = Provider<UserEntity?>((ref) {
  final authState = ref.watch(authNotifierProvider);
  return authState.maybeWhen(
    authenticated: (user) => user,
    orElse: () => null,
  );
});
```

### Simplified Access Control

```dart
// shared/ui/widgets/access_guard.dart
class AccessGuard extends ConsumerWidget {
  final Widget child;
  final Widget? fallback;
  final List<String>? requiredPermissions;
  final List<UserRole>? allowedRoles;
  final bool requireAuth;

  const AccessGuard({
    super.key,
    required this.child,
    this.fallback,
    this.requiredPermissions,
    this.allowedRoles,
    this.requireAuth = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    
    return authState.when(
      initial: () => const LoadingWidget(),
      loading: () => const LoadingWidget(),
      authenticated: (user) {
        // Check permissions
        if (requiredPermissions != null) {
          final hasPermissions = requiredPermissions!.every(
            (permission) => user.permissions.contains(permission),
          );
          if (!hasPermissions) {
            return fallback ?? const UnauthorizedWidget();
          }
        }
        
        // Check roles
        if (allowedRoles != null) {
          if (!allowedRoles!.contains(user.role)) {
            return fallback ?? const UnauthorizedWidget();
          }
        }
        
        return child;
      },
      unauthenticated: () => requireAuth ? (fallback ?? const LoginPromptWidget()) : child,
      error: (message) => ErrorWidget(message: message),
    );
  }
}

// Usage examples:
AccessGuard(
  requiredPermissions: ['products.manage'],
  child: ProductManagementPage(),
)

AccessGuard(
  allowedRoles: [UserRole.admin, UserRole.manager],
  child: ReportsPage(),
)
```

## 🌐 Complete HTTP Client Setup

```dart
// shared/data/api/api_client.dart
class ApiClient {
  static Dio? _instance;
  
  static Dio get instance {
    _instance ??= _createDio();
    return _instance!;
  }
  
  static Dio _createDio() {
    final dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json'},
    ));
    
    dio.interceptors.addAll([
      AuthInterceptor(),
      TenantInterceptor(), 
      LoggingInterceptor(),
      ErrorInterceptor(),
    ]);
    
    return dio;
  }
}

// Complete interceptor implementations
class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final storage = GetIt.instance<SecureStorage>();
    final token = await storage.getToken();
    
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    
    handler.next(options);
  }
  
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Handle token expiry
      final storage = GetIt.instance<SecureStorage>();
      await storage.deleteToken();
      
      // Navigate to login - use your navigation method
      GetIt.instance<AppRouter>().go('/login');
    }
    
    handler.next(err);
  }
}

class TenantInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final storage = GetIt.instance<SecureStorage>();
    final tenantId = await storage.getTenantId();
    
    if (tenantId != null) {
      options.headers['X-Tenant-ID'] = tenantId;
    }
    
    handler.next(options);
  }
}

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final failure = _mapDioErrorToFailure(err);
    
    // Log error for debugging
    debugPrint('API Error: ${failure.message}');
    
    // You can show global error handling here if needed
    
    handler.next(err);
  }
  
  NetworkFailure _mapDioErrorToFailure(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure('Connection timeout');
      case DioExceptionType.connectionError:
        return const NetworkFailure('No internet connection');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data?['message'] ?? 'Server error';
        return NetworkFailure(message, statusCode);
      default:
        return const NetworkFailure('Something went wrong');
    }
  }
}
```

## 📱 Complete Repository Pattern

```dart
// features/auth/domain/repository.dart
abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(String email, String password);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, UserEntity>> getCurrentUser();
}

// features/auth/data/repository.dart
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final SecureStorage _secureStorage;

  AuthRepositoryImpl(this._remoteDataSource, this._secureStorage);

  @override
  Future<Either<Failure, UserEntity>> login(String email, String password) async {
    try {
      final response = await _remoteDataSource.login(
        LoginRequestModel(email: email, password: password),
      );
      
      // Save token
      await _secureStorage.saveToken(response.token);
      await _secureStorage.saveTenantId(response.user.tenantId.toString());
      
      return Right(response.user.toEntity());
    } on DioException catch (e) {
      return Left(_mapDioErrorToFailure(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _remoteDataSource.logout();
      await _secureStorage.deleteToken();
      await _secureStorage.deleteTenantId();
      return const Right(null);
    } catch (e) {
      // Even if API call fails, clear local data
      await _secureStorage.deleteToken();
      await _secureStorage.deleteTenantId();
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final token = await _secureStorage.getToken();
      if (token == null) {
        return const Left(AuthFailure('No token found'));
      }
      
      final userModel = await _remoteDataSource.getCurrentUser();
      return Right(userModel.toEntity());
    } on DioException catch (e) {
      return Left(_mapDioErrorToFailure(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  NetworkFailure _mapDioErrorToFailure(DioException error) {
    // Same mapping as in ErrorInterceptor
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return const NetworkFailure('Connection timeout');
      case DioExceptionType.connectionError:
        return const NetworkFailure('No internet connection');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data?['message'] ?? 'Server error';
        return NetworkFailure(message, statusCode);
      default:
        return const NetworkFailure('Something went wrong');
    }
  }
}
```

## 🚀 Router Setup with Authentication

```dart
// app/router.dart
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authNotifierProvider);
  
  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final isAuthenticated = authState.maybeWhen(
        authenticated: (_) => true,
        orElse: () => false,
      );
      
      final isAuthenticating = authState.maybeWhen(
        loading: () => true,
        initial: () => true,
        orElse: () => false,
      );
      
      // Public routes
      final publicRoutes = ['/login', '/splash'];
      final isPublicRoute = publicRoutes.contains(state.location);
      
      // If still checking auth status, stay on current route
      if (isAuthenticating && state.location == '/splash') {
        return null;
      }
      
      // If not authenticated, redirect to login (except for public routes)
      if (!isAuthenticated && !isPublicRoute) {
        return '/login';
      }
      
      // If authenticated and on public route, redirect to dashboard
      if (isAuthenticated && isPublicRoute) {
        return '/dashboard';
      }
      
      return null; // No redirect needed
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: '/products',
        builder: (context, state) => const ProductsPage(),
      ),
    ],
  );
});
```

## 📋 Complete Dependencies

```yaml
# pubspec.yaml
name: pos_flutter
description: Multi-tenant POS Flutter client

version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'
  flutter: ">=3.10.0"

dependencies:
  flutter:
    sdk: flutter
  
  # State Management & DI
  flutter_riverpod: ^2.4.9
  
  # Navigation
  go_router: ^12.1.3
  
  # HTTP & Networking  
  dio: ^5.3.2
  
  # Local Storage
  flutter_secure_storage: ^9.0.0
  
  # Code Generation
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1
  
  # UI
  flutter_localizations:
    sdk: flutter
  intl: any

dev_dependencies:
  flutter_test:
    sdk: flutter
  
  # Code Generation
  build_runner: ^2.4.7
  freezed: ^2.4.6
  json_serializable: ^6.7.1
  
  # Testing
  mockito: ^5.4.2
  
  # Linting
  flutter_lints: ^3.0.0

flutter:
  uses-material-design: true
  generate: true
```

## 🧪 Testing Strategy

### Unit Test Example

```dart
// test/features/auth/domain/usecases/login_usecase_test.dart
void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = LoginUseCase(mockRepository);
  });

  group('LoginUseCase', () {
    const tEmail = 'test@example.com';
    const tPassword = 'password123';
    final tUser = UserEntity(
      id: 1,
      email: tEmail,
      name: 'Test User',
      role: UserRole.cashier,
      permissions: ['sales.create'],
      tenantId: 1,
    );

    test('should return UserEntity when login is successful', () async {
      // arrange
      when(mockRepository.login(tEmail, tPassword))
          .thenAnswer((_) async => Right(tUser));

      // act
      final result = await useCase(LoginParams(email: tEmail, password: tPassword));

      // assert
      expect(result, Right(tUser));
      verify(mockRepository.login(tEmail, tPassword));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return AuthFailure when login fails', () async {
      // arrange
      const tFailure = AuthFailure('Invalid credentials');
      when(mockRepository.login(tEmail, tPassword))
          .thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(LoginParams(email: tEmail, password: tPassword));

      // assert
      expect(result, const Left(tFailure));
      verify(mockRepository.login(tEmail, tPassword));
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
```

## ⚡ Development Commands

```bash
# Code generation
flutter packages pub run build_runner build --delete-conflicting-outputs

# Running tests
flutter test

# Running specific test
flutter test test/features/auth/domain/usecases/login_usecase_test.dart

# Running with coverage
flutter test --coverage

# Format code
dart format .

# Analyze code
flutter analyze
```

## 🎯 MVP Implementation Order

1. **Setup Project Structure** - Buat folder sesuai simplified structure
2. **Implement Auth Feature** - Login/logout dengan complete error handling
3. **Setup HTTP Client** - Dengan interceptors lengkap
4. **Implement Products Feature** - CRUD products dengan pagination
5. **Add Access Control** - Implement AccessGuard untuk authorization
6. **Add Tests** - Unit tests untuk use cases dan repositories

## 🚨 Anti-Hallucination Rules

1. **Stick to the structure** - Jangan buat folder/file di luar yang didefinisikan
2. **Follow naming exactly** - snake_case untuk file, PascalCase untuk class
3. **Use decision trees** - Gunakan matrix untuk pilih provider type
4. **Complete implementations** - Jangan buat skeleton code
5. **Test everything** - Setiap use case harus ada unit test