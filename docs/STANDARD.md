# Flutter POS Client: Clean Architecture + Multi-Tenant Structure

A Flutter client application for the multi-tenant POS system following Clean Architecture principles with Domain-Driven Design approach.

## Technical Stack Requirements

1. **State Management**: flutter_riverpod for dependency injection and state management
2. **Networking**: dio for HTTP client with interceptors
3. **Routing**: go_router for declarative routing
4. **Security**: flutter_secure_storage for token storage
5. **Code Generation**: json_annotation, freezed for immutable models
6. **Testing**: mockito for mocking

## Architecture Approach

**Clean Architecture with Feature-Based Modules:**
- Separation of concerns with clear layer boundaries
- Domain-driven module organization
- Dependency injection using Riverpod providers
- Online-first approach with future offline support
- Multi-tenant isolation at client level

## Project Structure

```
pos_flutter/
├── lib/
│   ├── main.dart                    # App entry point with provider setup
│   ├── app/
│   │   ├── app.dart                 # Main app widget with routing
│   │   ├── providers/               # Global app providers
│   │   │   ├── app_providers.dart   # Core providers (HTTP, storage, etc)
│   │   │   └── router_provider.dart # GoRouter configuration
│   │   └── constants/
│   │       ├── app_constants.dart   # API URLs, timeouts, etc
│   │       └── app_colors.dart      # Theme colors
│   ├── features/                    # Business feature modules
│   │   ├── auth/                    # Authentication feature
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   │   ├── auth_local_datasource.dart
│   │   │   │   │   └── auth_remote_datasource.dart
│   │   │   │   ├── models/
│   │   │   │   │   ├── login_request_model.dart
│   │   │   │   │   ├── login_response_model.dart
│   │   │   │   │   └── user_model.dart
│   │   │   │   └── repositories/
│   │   │   │       └── auth_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   └── user_entity.dart
│   │   │   │   ├── repositories/
│   │   │   │   │   └── auth_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       ├── login_usecase.dart
│   │   │   │       ├── logout_usecase.dart
│   │   │   │       └── get_current_user_usecase.dart
│   │   │   ├── presentation/
│   │   │   │   ├── providers/
│   │   │   │   │   ├── auth_providers.dart
│   │   │   │   │   └── login_state_provider.dart
│   │   │   │   ├── pages/
│   │   │   │   │   ├── login_page.dart
│   │   │   │   │   └── splash_page.dart
│   │   │   │   └── widgets/
│   │   │   │       ├── login_form.dart
│   │   │   │       └── tenant_selector.dart
│   │   │   └── auth_providers.dart   # Feature provider exports
│   │   ├── products/                # Product management feature
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   │   ├── products_local_datasource.dart
│   │   │   │   │   └── products_remote_datasource.dart
│   │   │   │   ├── models/
│   │   │   │   │   ├── product_model.dart
│   │   │   │   │   ├── category_model.dart
│   │   │   │   │   └── stock_model.dart
│   │   │   │   └── repositories/
│   │   │   │       └── products_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   ├── product_entity.dart
│   │   │   │   │   └── category_entity.dart
│   │   │   │   ├── repositories/
│   │   │   │   │   └── products_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       ├── get_products_usecase.dart
│   │   │   │       ├── search_products_usecase.dart
│   │   │   │       └── get_product_detail_usecase.dart
│   │   │   ├── presentation/
│   │   │   │   ├── providers/
│   │   │   │   │   ├── products_providers.dart
│   │   │   │   │   └── product_list_state_provider.dart
│   │   │   │   ├── pages/
│   │   │   │   │   ├── products_page.dart
│   │   │   │   │   └── product_detail_page.dart
│   │   │   │   └── widgets/
│   │   │   │       ├── product_card.dart
│   │   │   │       ├── product_search_bar.dart
│   │   │   │       └── category_filter.dart
│   │   │   └── products_providers.dart
│   │   ├── transactions/            # Sales transactions (future)
│   │   ├── customers/              # Customer management (future)
│   │   ├── reports/                # Reports and analytics (future)
│   │   └── dashboard/              # Main dashboard (future)
│   ├── shared/                     # Cross-cutting concerns
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── base_remote_datasource.dart
│   │   │   └── models/
│   │   │       ├── api_response_model.dart
│   │   │       ├── pagination_model.dart
│   │   │       └── error_model.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── base_entity.dart
│   │   │   │   └── pagination_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── base_repository.dart
│   │   │   └── usecases/
│   │   │       └── base_usecase.dart
│   │   ├── infrastructure/
│   │   │   ├── network/
│   │   │   │   ├── dio_client.dart       # Dio configuration
│   │   │   │   ├── interceptors/
│   │   │   │   │   ├── auth_interceptor.dart
│   │   │   │   │   ├── tenant_interceptor.dart
│   │   │   │   │   ├── permission_interceptor.dart
│   │   │   │   │   ├── logging_interceptor.dart
│   │   │   │   │   └── error_interceptor.dart
│   │   │   │   └── network_info.dart     # Connectivity checking
│   │   │   ├── storage/
│   │   │   │   ├── secure_storage.dart   # Token storage
│   │   │   │   └── cache_manager.dart    # General caching (Phase 2)
│   │   │   └── services/
│   │   │       └── notification_service.dart
│   │   ├── presentation/
│   │   │   ├── widgets/
│   │   │   │   ├── guards/               # Authentication & authorization guards
│   │   │   │   │   ├── auth_guard_widget.dart
│   │   │   │   │   ├── role_guard_widget.dart
│   │   │   │   │   ├── permission_guard_widget.dart
│   │   │   │   │   ├── tenant_guard_widget.dart
│   │   │   │   │   └── unauthorized_widget.dart
│   │   │   │   ├── common/
│   │   │   │   │   ├── loading_widget.dart
│   │   │   │   │   ├── error_widget.dart
│   │   │   │   │   ├── empty_state_widget.dart
│   │   │   │   │   └── refresh_indicator_widget.dart
│   │   │   │   ├── forms/
│   │   │   │   │   ├── custom_text_field.dart
│   │   │   │   │   ├── custom_dropdown.dart
│   │   │   │   │   └── form_validators.dart
│   │   │   │   └── layout/
│   │   │   │       ├── app_scaffold.dart
│   │   │   │       ├── authenticated_layout.dart
│   │   │   │       ├── bottom_navigation.dart
│   │   │   │       └── app_drawer.dart
│   │   │   ├── hooks/                   # Custom hooks for common logic
│   │   │   │   ├── use_auth_guard.dart
│   │   │   │   ├── use_permission.dart
│   │   │   │   └── use_current_user.dart
│   │   │   ├── theme/
│   │   │   │   ├── app_theme.dart
│   │   │   │   ├── text_styles.dart
│   │   │   │   └── button_styles.dart
│   │   │   └── providers/
│   │   │       ├── auth_guard_providers.dart
│   │   │       ├── permission_providers.dart
│   │   │       ├── theme_provider.dart
│   │   │       └── connectivity_provider.dart
│   │   ├── utils/
│   │   │   ├── constants/
│   │   │   │   ├── api_constants.dart
│   │   │   │   ├── storage_constants.dart
│   │   │   │   └── route_constants.dart
│   │   │   ├── extensions/
│   │   │   │   ├── context_extensions.dart
│   │   │   │   ├── string_extensions.dart
│   │   │   │   └── datetime_extensions.dart
│   │   │   ├── helpers/
│   │   │   │   ├── date_helper.dart
│   │   │   │   ├── currency_helper.dart
│   │   │   │   └── validation_helper.dart
│   │   │   └── exceptions/
│   │   │       ├── app_exceptions.dart
│   │   │       ├── network_exceptions.dart
│   │   │       └── cache_exceptions.dart
│   │   └── providers/
│   │       ├── shared_providers.dart     # Export all shared providers
│   │       └── infrastructure_providers.dart
│   └── l10n/                        # Internationalization
│       ├── app_localizations.dart
│       ├── app_en.arb
│       └── app_id.arb
├── test/                           # Unit and widget tests
│   ├── features/
│   │   ├── auth/
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   └── products/
│   ├── shared/
│   └── helpers/
│       ├── test_helpers.dart
│       └── mock_data.dart
├── assets/                        # Static assets
│   ├── images/
│   ├── icons/
│   └── fonts/
├── android/                       # Android configuration
├── ios/                          # iOS configuration
└── web/                          # Web configuration
```

## Key Architecture Principles

### 1. Clean Architecture Layers

#### Data Layer
- **Datasources**: Handle raw data from APIs
- **Models**: JSON serializable models with conversion methods
- **Repository Implementations**: Concrete implementations of domain repositories

#### Domain Layer
- **Entities**: Pure business objects without external dependencies
- **Repositories**: Abstract interfaces for data operations
- **Use Cases**: Single responsibility business logic operations

#### Presentation Layer
- **Providers**: Riverpod providers for state management and DI
- **Pages**: Screen widgets that consume providers
- **Widgets**: Reusable UI components

### 2. Feature Module Structure

Each feature follows this standardized structure:

```
feature_name/
├── data/                          # Data layer
│   ├── datasources/               # Remote data sources
│   ├── models/                    # Data transfer objects
│   └── repositories/              # Repository implementations
├── domain/                        # Business logic layer
│   ├── entities/                  # Business objects
│   ├── repositories/              # Repository interfaces
│   └── usecases/                  # Business use cases
├── presentation/                  # UI layer
│   ├── providers/                 # Riverpod providers
│   ├── pages/                     # Screen widgets
│   └── widgets/                   # Feature-specific widgets
└── [feature]_providers.dart       # Provider exports
```

### 3. Provider Organization

#### Global Providers (app/providers/)
```dart
// app/providers/app_providers.dart
final dioProvider = Provider<Dio>((ref) => DioClient.getInstance());
final secureStorageProvider = Provider<SecureStorage>((ref) => SecureStorage());
```

#### Feature Providers
```dart
// features/auth/presentation/providers/auth_providers.dart
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.read(authRemoteDataSourceProvider),
    localDataSource: ref.read(authLocalDataSourceProvider),
  );
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.read(authRepositoryProvider));
});

final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.read(loginUseCaseProvider));
});
```

### 4. State Management Patterns

#### Use Case Pattern
```dart
// domain/usecases/login_usecase.dart
class LoginUseCase {
  final AuthRepository repository;
  
  LoginUseCase(this.repository);
  
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await repository.login(params.email, params.password);
  }
}
```

#### State Notifier Pattern
```dart
// presentation/providers/login_state_provider.dart
class LoginNotifier extends StateNotifier<LoginState> {
  final LoginUseCase loginUseCase;
  
  LoginNotifier(this.loginUseCase) : super(const LoginState.initial());
  
  Future<void> login(String email, String password) async {
    state = const LoginState.loading();
    
    final result = await loginUseCase(LoginParams(email, password));
    
    result.fold(
      (failure) => state = LoginState.error(failure.message),
      (user) => state = LoginState.success(user),
    );
  }
}
```

## API Response Handling

### Standard Response Model
```dart
// shared/data/models/api_response_model.dart
@freezed
class ApiResponseModel<T> with _$ApiResponseModel<T> {
  const factory ApiResponseModel({
    required String message,
    required T? data,
    PaginationModel? meta,
    Map<String, List<String>>? errors,
  }) = _ApiResponseModel<T>;
  
  factory ApiResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$ApiResponseModelFromJson(json, fromJsonT);
}
```

### HTTP Client Setup
```dart
// shared/infrastructure/network/dio_client.dart
class DioClient {
  static Dio? _instance;
  
  static Dio getInstance() {
    _instance ??= Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ))..interceptors.addAll([
      AuthInterceptor(),
      TenantInterceptor(),
      LoggingInterceptor(),
      ErrorInterceptor(),
    ]);
    
    return _instance!;
  }
}
```

### Error Handling
```dart
// shared/utils/exceptions/app_exceptions.dart
abstract class AppException implements Exception {
  final String message;
  final int? statusCode;
  
  const AppException(this.message, [this.statusCode]);
}

class NetworkException extends AppException {
  const NetworkException(super.message, [super.statusCode]);
}

class CacheException extends AppException {
  const CacheException(super.message);
}
```

## Routing Configuration

### GoRouter Setup
```dart
// app/providers/router_provider.dart
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  
  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final isLoggedIn = authState.maybeWhen(
        authenticated: (_) => true,
        orElse: () => false,
      );
      
      final isLoginPage = state.location == '/login';
      final isSplashPage = state.location == '/splash';
      
      // Authentication guard logic
      if (!isLoggedIn) {
        if (isSplashPage || isLoginPage) return null;
        return '/login'; // Redirect unauthorized users
      } else {
        if (isLoginPage || isSplashPage) return '/dashboard';
        return null; // Allow authenticated access
      }
    },
    routes: [
      // Public routes
      GoRoute(
        path: '/splash',
        name: RouteConstants.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/login',
        name: RouteConstants.login,
        builder: (context, state) => const LoginPage(),
      ),
      
      // Protected routes with authenticated layout
      ShellRoute(
        builder: (context, state, child) => AuthenticatedLayout(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            name: RouteConstants.dashboard,
            builder: (context, state) => const DashboardPage(),
          ),
          GoRoute(
            path: '/products',
            name: RouteConstants.products,
            builder: (context, state) => const ProductsPage(),
            routes: [
              GoRoute(
                path: '/:id',
                name: RouteConstants.productDetail,
                builder: (context, state) => ProductDetailPage(
                  productId: state.pathParameters['id']!,
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
```

## Authentication & Authorization Guards

### Router Level Guard (Primary Guard)

The main authentication guard is implemented at the router level using GoRouter's redirect functionality. This ensures global route protection:

```dart
// app/providers/router_provider.dart - Already shown above
```

### Widget Level Guards

Fine-grained access control using guard widgets:

```dart
// shared/presentation/widgets/guards/auth_guard_widget.dart
class AuthGuardWidget extends ConsumerWidget {
  final Widget child;
  final Widget? fallback;
  final List<String>? requiredPermissions;
  
  const AuthGuardWidget({
    super.key,
    required this.child,
    this.fallback,
    this.requiredPermissions,
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    
    return authState.when(
      initial: () => fallback ?? const LoadingWidget(),
      loading: () => const LoadingWidget(),
      authenticated: (user) {
        if (requiredPermissions != null) {
          final hasPermissions = requiredPermissions!.every(
            (permission) => user.permissions.contains(permission),
          );
          
          if (!hasPermissions) {
            return fallback ?? const UnauthorizedWidget();
          }
        }
        
        return child;
      },
      unauthenticated: () => fallback ?? const LoginPromptWidget(),
      error: (message) => ErrorWidget(message: message),
    );
  }
}

// shared/presentation/widgets/guards/role_guard_widget.dart
class RoleGuardWidget extends ConsumerWidget {
  final Widget child;
  final List<UserRole> allowedRoles;
  final Widget? fallback;
  
  const RoleGuardWidget({
    super.key,
    required this.child,
    required this.allowedRoles,
    this.fallback,
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    
    return authState.maybeWhen(
      authenticated: (user) {
        if (allowedRoles.contains(user.role)) {
          return child;
        }
        return fallback ?? const UnauthorizedWidget();
      },
      orElse: () => fallback ?? const LoginPromptWidget(),
    );
  }
}

// Usage examples
class ProductsManagementPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AuthGuardWidget(
      requiredPermissions: ['products.manage'],
      child: RoleGuardWidget(
        allowedRoles: [UserRole.admin, UserRole.manager],
        child: Scaffold(
          appBar: AppBar(title: const Text('Manage Products')),
          body: const ProductsManagementView(),
        ),
      ),
    );
  }
}
```

### HTTP Interceptor Guards

Authentication and authorization at the network level:

```dart
// shared/infrastructure/network/interceptors/auth_interceptor.dart
class AuthInterceptor extends Interceptor {
  final SecureStorage secureStorage;
  final Ref ref;
  
  AuthInterceptor(this.secureStorage, this.ref);
  
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await secureStorage.getToken();
    
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    
    handler.next(options);
  }
  
  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      await secureStorage.deleteToken();
      ref.read(authStateProvider.notifier).logout();
    }
    
    handler.next(err);
  }
}

// shared/infrastructure/network/interceptors/tenant_interceptor.dart
class TenantInterceptor extends Interceptor {
  final SecureStorage secureStorage;
  
  TenantInterceptor(this.secureStorage);
  
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final tenantId = await secureStorage.getCurrentTenantId();
    
    if (tenantId != null) {
      options.headers['X-Tenant-ID'] = tenantId;
    }
    
    handler.next(options);
  }
}
```

### Permission & Role Providers

State management for authorization:

```dart
// shared/presentation/providers/auth_guard_providers.dart
final currentUserProvider = Provider<UserEntity?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.maybeWhen(
    authenticated: (user) => user,
    orElse: () => null,
  );
});

final isAuthenticatedProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  return user != null;
});

final hasPermissionProvider = Provider.family<bool, String>((ref, permission) {
  final user = ref.watch(currentUserProvider);
  return user?.permissions.contains(permission) ?? false;
});

final hasRoleProvider = Provider.family<bool, UserRole>((ref, role) {
  final user = ref.watch(currentUserProvider);
  return user?.role == role;
});

// shared/presentation/providers/permission_providers.dart
final canManageProductsProvider = Provider<bool>((ref) {
  return ref.watch(hasPermissionProvider('products.manage'));
});

final canViewReportsProvider = Provider<bool>((ref) {
  return ref.watch(hasPermissionProvider('reports.view'));
});

final isManagerOrAboveProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  return user != null && [UserRole.admin, UserRole.manager].contains(user.role);
});
```

### Custom Hooks for Guards

Reusable authentication logic:

```dart
// shared/presentation/hooks/use_auth_guard.dart
bool useAuthGuard({
  List<String>? requiredPermissions,
  List<UserRole>? requiredRoles,
}) {
  final ref = useRef();
  final authState = ref.watch(authStateProvider);
  
  return authState.maybeWhen(
    authenticated: (user) {
      if (requiredPermissions != null) {
        final hasPermissions = requiredPermissions.every(
          (permission) => user.permissions.contains(permission),
        );
        if (!hasPermissions) return false;
      }
      
      if (requiredRoles != null) {
        if (!requiredRoles.contains(user.role)) return false;
      }
      
      return true;
    },
    orElse: () => false,
  );
}

// shared/presentation/hooks/use_permission.dart
bool usePermission(String permission) {
  final ref = useRef();
  return ref.watch(hasPermissionProvider(permission));
}

// shared/presentation/hooks/use_current_user.dart
UserEntity? useCurrentUser() {
  final ref = useRef();
  return ref.watch(currentUserProvider);
}
```

## Phase-Based Development Strategy

### Phase 1: MVP (Online-First) 
**Current Focus - Production Ready**

The initial release focuses on online functionality with robust architecture that supports future offline capabilities:

**Core Features:**
- Complete authentication and authorization system
- Real-time product catalog management
- Customer management with live data
- Online transaction processing
- Basic reporting and analytics
- Multi-tenant support with role-based access

**Architecture Benefits:**
- Repository pattern ready for offline implementation
- Local datasource interfaces defined as placeholders
- Network connectivity awareness built-in
- Error handling prepared for offline scenarios
- State management supports both online/offline states

**Implementation Approach:**
```dart
// Repository implementation - Phase 1 (Online only)
class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  
  ProductsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  
  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    if (await networkInfo.isConnected) {
      final products = await remoteDataSource.getProducts();
      return Right(products.map((m) => m.toEntity()).toList());
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }
}
```

### Phase 2: Offline Support (Post-MVP)
**Future Enhancement - Advanced Capabilities**

After MVP validation and user feedback, offline capabilities will be added:

**Enhanced Features:**
- Local data caching with SQLite
- Offline product catalog browsing
- Offline transaction queue management
- Background synchronization service
- Conflict resolution algorithms
- Advanced stock management across outlets

**Architecture Extension:**
```dart
// Repository implementation - Phase 2 (With offline support)
class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource remoteDataSource;
  final ProductsLocalDataSource localDataSource;  // Added in Phase 2
  final NetworkInfo networkInfo;
  final SyncService syncService;  // Added in Phase 2
  
  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    if (await networkInfo.isConnected) {
      // Online: fetch from API + cache locally
      final products = await remoteDataSource.getProducts();
      await localDataSource.cacheProducts(products);
      return Right(products.map((m) => m.toEntity()).toList());
    } else {
      // Offline: fallback to local cache
      final cachedProducts = await localDataSource.getCachedProducts();
      return Right(cachedProducts.map((m) => m.toEntity()).toList());
    }
  }
}
```

**Benefits of Phased Approach:**
- Faster time-to-market with MVP
- Real user feedback before complex offline features
- Reduced initial development complexity
- Foundation architecture supports seamless offline addition
- Resource optimization for core business features

### Local Database Schema
```dart
// shared/infrastructure/storage/local_database.dart
class LocalDatabase {
  static Database? _database;
  
  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }
  
  Future<Database> _initDatabase() async {
    return await openDatabase(
      'pos_local.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE products (
            id INTEGER PRIMARY KEY,
            tenant_id INTEGER NOT NULL,
            sku TEXT NOT NULL,
            name TEXT NOT NULL,
            price REAL NOT NULL,
            stock INTEGER NOT NULL,
            is_synced INTEGER DEFAULT 0,
            created_at TEXT NOT NULL,
            updated_at TEXT NOT NULL
          )
        ''');
      },
    );
  }
}
```

### Sync Service
```dart
// shared/infrastructure/services/sync_service.dart
class SyncService {
  Future<void> syncPendingData() async {
    final connectivity = await Connectivity().checkConnectivity();
    
    if (connectivity != ConnectivityResult.none) {
      await _syncProducts();
      await _syncTransactions();
      // ... other sync operations
    }
  }
}
```

## Testing Strategy

### Unit Tests
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
    test('should return User when login is successful', () async {
      // Arrange
      const email = 'test@example.com';
      const password = 'password123';
      final user = User(id: 1, email: email, name: 'Test User');
      
      when(mockRepository.login(email, password))
          .thenAnswer((_) async => Right(user));
      
      // Act
      final result = await useCase(LoginParams(email, password));
      
      // Assert
      expect(result, Right(user));
      verify(mockRepository.login(email, password));
    });
  });
}
```

### Widget Tests
```dart
// test/features/auth/presentation/pages/login_page_test.dart
void main() {
  testWidgets('should show login form', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: LoginPage(),
        ),
      ),
    );
    
    expect(find.byType(LoginForm), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
  });
}
```

## Development Guidelines

### 1. Code Generation
- Use freezed for immutable models
- Use json_annotation for serialization
- Use build_runner for code generation

### 2. Dependency Management
- Each layer depends only on inner layers
- Use dependency injection for all external dependencies
- Mock all external dependencies in tests

### 3. Error Handling
- Use Either pattern for use case returns
- Standardized error types across the app
- User-friendly error messages
- Network connectivity awareness

### 4. Performance
- Lazy loading for lists
- Image optimization and caching
- Efficient state updates
- Memory management best practices

### 5. Testing
- Unit tests for all use cases
- Widget tests for UI components
- Integration tests for critical flows
- Mock all external dependencies

Start with a working authentication flow and basic product listing as MVP foundation, then expand with offline capabilities and additional features in Phase 2 following the same architectural patterns.