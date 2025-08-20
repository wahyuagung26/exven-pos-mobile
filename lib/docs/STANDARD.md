# ExVen POS Lite - Flutter Development Standards

This document outlines the coding standards, architecture patterns, and development guidelines for the ExVen POS Lite Flutter application.

## Table of Contents

1. [Architecture Overview](#architecture-overview)
2. [Project Structure](#project-structure)
3. [Naming Conventions](#naming-conventions)
4. [Code Organization](#code-organization)
5. [State Management](#state-management)
6. [Error Handling](#error-handling)
7. [Data Layer](#data-layer)
8. [UI/UX Guidelines](#uiux-guidelines)
9. [Testing Standards](#testing-standards)
10. [Dependencies](#dependencies)
11. [Development Workflow](#development-workflow)

---

## Architecture Overview

The project follows **Clean Architecture** principles with **Riverpod** for state management:

```
┌─────────────────────────────────────┐
│           Presentation Layer        │
│     (Screens, Widgets, Providers)   │
├─────────────────────────────────────┤
│            Domain Layer             │
│    (Entities, Use Cases, Repos)     │
├─────────────────────────────────────┤
│             Data Layer              │
│   (Models, Data Sources, Repos)     │
└─────────────────────────────────────┘
```

### Core Principles

- **Separation of Concerns**: Each layer has distinct responsibilities
- **Dependency Inversion**: Higher layers depend on abstractions, not implementations
- **Single Responsibility**: Each class/function has one reason to change
- **Functional Error Handling**: Use `Either<Failure, Success>` pattern with Dartz

---

## Project Structure

```
lib/
├── core/                           # Core framework code
│   ├── constants/                  # App-wide constants
│   ├── entities/                   # Base entities
│   ├── errors/                     # Error classes and failures
│   ├── usecases/                   # Base use case classes
│   └── utils/                      # Core utilities and DI
├── data/                           # Data layer implementations
│   ├── datasources/               # Remote/Local data sources
│   ├── models/                    # Data models (JSON serializable)
│   └── repositories/              # Repository implementations
├── features/                       # Feature-based modules
│   └── [feature_name]/
│       ├── data/                  # Feature-specific data layer
│       ├── domain/                # Feature-specific business logic
│       └── presentation/          # Feature-specific UI
├── presentation/                   # Global presentation layer
│   ├── providers/                 # Global providers
│   ├── routes/                    # Navigation and routing
│   ├── screens/                   # Global screens
│   └── widgets/                   # Global widgets
├── shared/                         # Shared components
│   ├── theme/                     # App theming
│   ├── utils/                     # Utility classes
│   └── widgets/                   # Reusable UI components
├── docs/                          # Documentation
└── main.dart                      # App entry point
```

### Feature Structure Pattern

Each feature follows this consistent structure:

```
features/[feature_name]/
├── data/
│   ├── datasources/              # API calls, local storage
│   ├── models/                   # JSON serializable models
│   └── repositories/             # Repository implementations
├── domain/
│   ├── entities/                 # Business objects
│   ├── repositories/             # Repository contracts
│   └── usecases/                 # Business logic operations
└── presentation/
    ├── providers/                # Riverpod providers
    ├── screens/                  # Feature screens
    └── widgets/                  # Feature-specific widgets
```

---

## Naming Conventions

### Files and Directories

- **Files**: `snake_case.dart`
- **Directories**: `snake_case`
- **Classes**: `PascalCase`
- **Variables/Functions**: `camelCase`
- **Constants**: `camelCase` (with descriptive prefixes)

### Specific Patterns

| Type | Pattern | Example |
|------|---------|---------|
| Entities | `[Name]` | `User`, `Product` |
| Models | `[Name]Model` | `UserModel`, `ProductModel` |
| Repositories | `[Name]Repository` | `ProductRepository` |
| Repository Impls | `[Name]RepositoryImpl` | `ProductRepositoryImpl` |
| Use Cases | `[Verb][Object]` | `GetProducts`, `CreateUser` |
| Providers | `[name]Provider` | `authProvider`, `productsProvider` |
| Screens | `[Name]Screen` | `LoginScreen`, `ProductListScreen` |
| Widgets | `[Name]Widget` | `ProductCard`, `SearchBarWidget` |
| Data Sources | `[Name][Type]DataSource` | `ProductRemoteDataSource` |

### Provider Naming

```dart
// State providers
final selectedProductProvider = StateProvider<Product?>((ref) => null);
final searchQueryProvider = StateProvider<String>((ref) => '');

// Future providers  
final productsProvider = FutureProvider<List<Product>>((ref) async { ... });

// Notifier providers
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) { ... });

// Regular providers
final getProductsProvider = Provider<GetProducts>((ref) { ... });

// Convenience providers
final currentUserProvider = Provider<User?>((ref) { ... });
final isAuthenticatedProvider = Provider<bool>((ref) { ... });
```

---

## Code Organization

### Import Organization

```dart
// 1. Flutter/Dart imports
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 2. Third-party package imports
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

// 3. Internal imports (relative paths)
import '../../core/errors/failures.dart';
import '../entities/user.dart';
```

### Class Structure

```dart
class ExampleClass {
  // 1. Static constants
  static const String defaultValue = 'default';
  
  // 2. Instance variables (private first)
  final String _privateField;
  final String publicField;
  
  // 3. Constructor
  const ExampleClass({
    required String privateField,
    required this.publicField,
  }) : _privateField = privateField;
  
  // 4. Public methods
  void publicMethod() { ... }
  
  // 5. Private methods
  void _privateMethod() { ... }
  
  // 6. Overrides
  @override
  String toString() => 'ExampleClass(publicField: $publicField)';
}
```

---

## State Management

The project uses **Riverpod** for state management following these patterns:

### Provider Types

```dart
// 1. StateProvider - Simple state
final counterProvider = StateProvider<int>((ref) => 0);

// 2. Provider - Computed values
final doubledCounterProvider = Provider<int>((ref) {
  final count = ref.watch(counterProvider);
  return count * 2;
});

// 3. FutureProvider - Async data
final usersProvider = FutureProvider<List<User>>((ref) async {
  return await fetchUsers();
});

// 4. StateNotifierProvider - Complex state
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
```

### State Classes

```dart
class AuthState {
  final User? user;
  final bool isAuthenticated;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.user,
    this.isAuthenticated = false,
    this.isLoading = false,
    this.error,
  });

  // Always include copyWith method
  AuthState copyWith({
    User? user,
    bool? isAuthenticated,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
```

### Consumer Widgets

```dart
// Use ConsumerWidget for widgets that need providers
class ProductList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsProvider);
    
    return productsAsync.when(
      data: (products) => ListView.builder(...),
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}

// Use Consumer for part of widget tree
class SomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Static content'),
        Consumer(
          builder: (context, ref, child) {
            final count = ref.watch(counterProvider);
            return Text('Count: $count');
          },
        ),
      ],
    );
  }
}
```

---

## Error Handling

### Failure Classes

All errors are represented as `Failure` objects:

```dart
abstract class Failure extends Equatable {
  final String message;
  final int? code;

  const Failure({required this.message, this.code});
}

// Specific failure types
class NetworkFailure extends Failure { ... }
class ServerFailure extends Failure { ... }
class ValidationFailure extends Failure { ... }
class AuthFailure extends Failure { ... }
class NotFoundFailure extends Failure { ... }
```

### Either Pattern

Use `Either<Failure, Success>` for operations that can fail:

```dart
// Repository methods
Future<Either<Failure, List<Product>>> getProducts();

// Use case implementations
@override
Future<Either<Failure, List<Product>>> call() async {
  return await repository.getProducts();
}

// In providers
final productsProvider = FutureProvider<List<Product>>((ref) async {
  final getProducts = ref.watch(getProductsProvider);
  final result = await getProducts();
  
  return result.fold(
    (failure) => throw Exception(failure.message),
    (products) => products,
  );
});
```

---

## Data Layer

### Models vs Entities

```dart
// Entity (Domain layer) - Business logic object
class Product {
  final String id;
  final String name;
  final double price;
  
  const Product({
    required this.id,
    required this.name,
    required this.price,
  });
}

// Model (Data layer) - JSON serializable
@JsonSerializable()
class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  // Conversion methods
  factory ProductModel.fromEntity(Product product) => ProductModel(...);
  Product toEntity() => Product(...);
}
```

### Repository Pattern

```dart
// Abstract repository (Domain layer)
abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, Product>> getProductById(String id);
}

// Implementation (Data layer)
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final productModels = await remoteDataSource.getProducts();
      final products = productModels.map((model) => model.toEntity()).toList();
      return Right(products);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
```

### Data Sources

```dart
abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiClient apiClient;

  ProductRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await apiClient.get('/products');
    
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw ServerException(message: 'Failed to fetch products');
    }
  }
}
```

---

## UI/UX Guidelines

### Theme Usage

Always use theme values instead of hardcoded colors:

```dart
// ✅ Correct
Container(
  color: Theme.of(context).colorScheme.primary,
  child: Text(
    'Hello',
    style: Theme.of(context).textTheme.headlineMedium,
  ),
)

// ❌ Incorrect
Container(
  color: Colors.blue,
  child: Text(
    'Hello',
    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  ),
)
```

### Responsive Design

```dart
// Use MediaQuery for responsive layouts
class ResponsiveWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    
    return isTablet 
      ? TabletLayout() 
      : MobileLayout();
  }
}
```

### Widget Composition

Prefer small, focused widgets:

```dart
// ✅ Good - Small, focused widgets
class ProductCard extends StatelessWidget {
  final Product product;
  
  const ProductCard({super.key, required this.product});
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ProductImage(imageUrl: product.imageUrl),
          ProductInfo(product: product),
          ProductActions(product: product),
        ],
      ),
    );
  }
}

// ❌ Avoid - Large, monolithic widgets
class MassiveProductWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          // 100+ lines of widget code...
        ],
      ),
    );
  }
}
```

---

## Testing Standards

### Test Structure

```dart
void main() {
  group('ProductRepository', () {
    late ProductRepository repository;
    late MockProductRemoteDataSource mockDataSource;

    setUp(() {
      mockDataSource = MockProductRemoteDataSource();
      repository = ProductRepositoryImpl(remoteDataSource: mockDataSource);
    });

    group('getProducts', () {
      test('should return products when call is successful', () async {
        // Arrange
        final productModels = [ProductModel(...)];
        when(mockDataSource.getProducts())
            .thenAnswer((_) async => productModels);

        // Act
        final result = await repository.getProducts();

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('Should not fail'),
          (products) => expect(products.length, 1),
        );
      });
    });
  });
}
```

### Widget Testing

```dart
void main() {
  group('ProductCard Widget', () {
    testWidgets('should display product information correctly', (tester) async {
      // Arrange
      const product = Product(id: '1', name: 'Test Product', price: 10.0);

      // Act
      await tester.pumpWidget(
        MaterialApp(home: ProductCard(product: product)),
      );

      // Assert
      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('\$10.0'), findsOneWidget);
    });
  });
}
```

---

## Dependencies

### Core Dependencies

```yaml
dependencies:
  flutter_riverpod: ^2.5.1     # State management
  dio: ^5.4.1                  # HTTP client
  dartz: ^0.10.1               # Functional programming
  json_annotation: ^4.9.0      # JSON serialization
  get_it: ^7.6.7               # Dependency injection
  go_router: ^14.0.2           # Navigation
  shared_preferences: ^2.2.2   # Local storage
  equatable: ^2.0.5            # Value equality
  intl: ^0.19.0                # Internationalization

dev_dependencies:
  build_runner: ^2.4.8         # Code generation
  json_serializable: ^6.7.1    # JSON serialization generator
  flutter_lints: ^5.0.0        # Linting rules
```

### Adding New Dependencies

1. Check if the functionality already exists in current dependencies
2. Add to `pubspec.yaml`
3. Run `flutter pub get`
4. Update this document with the new dependency
5. Consider impact on app size and performance

---

## Development Workflow

### Code Generation

After modifying models with `@JsonSerializable()`:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Pre-commit Checklist

1. **Format code**: `flutter format .`
2. **Analyze code**: `flutter analyze`
3. **Run tests**: `flutter test`
4. **Check for build issues**: `flutter build apk --debug`

### Code Review Standards

- [ ] Follows architectural patterns
- [ ] Uses proper error handling
- [ ] Includes appropriate tests
- [ ] Follows naming conventions
- [ ] No hardcoded values
- [ ] Proper documentation/comments
- [ ] Performance considerations addressed

### Git Workflow

```bash
# Feature development
git checkout -b feature/product-management
# ... make changes ...
git add .
git commit -m "feat: add product management functionality"
git push origin feature/product-management
# Create PR for review
```

### Commit Message Format

```
type(scope): description

feat: new feature
fix: bug fix
docs: documentation changes
style: formatting changes
refactor: code refactoring
test: adding tests
chore: maintenance tasks
```

---

## Utilities and Helpers

### Available Utilities

- **AuthUtil**: User authentication and token management
- **HttpUtil**: HTTP requests with automatic auth headers
- **Shared Widgets**: Reusable UI components in `lib/shared/widgets/`

### Using Utilities

```dart
// Authentication
final user = await AuthUtil.getLoggedUser();
final isLoggedIn = await AuthUtil.isLoggedIn();

// HTTP requests
final result = await HttpUtil.get('/api/products', requireAuth: true);
final postResult = await HttpUtil.post('/api/products', 
  data: productData, 
  requireAuth: true
);
```

---

## Performance Guidelines

### State Management Performance

```dart
// ✅ Use .select() for specific properties
final userName = ref.watch(authProvider.select((state) => state.user?.name));

// ✅ Use autoDispose for temporary data
final tempDataProvider = FutureProvider.autoDispose<Data>((ref) async {
  return await fetchTempData();
});

// ✅ Use family for parameterized providers
final userProvider = FutureProvider.family<User, String>((ref, userId) async {
  return await fetchUser(userId);
});
```

### Widget Performance

```dart
// ✅ Use const constructors when possible
const ProductCard({super.key, required this.product});

// ✅ Extract expensive widgets
class ExpensiveWidget extends StatelessWidget {
  const ExpensiveWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const SomeExpensiveWidget();
  }
}
```

---

This document should be updated as the project evolves and new patterns emerge. All team members should follow these standards to maintain consistency and code quality across the project.