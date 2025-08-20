# POS System - Flutter Application

A clean, modular Flutter Point of Sales (POS) system built with Clean Architecture principles.

## 🏗 Architecture Overview

This project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/                 # Core business logic and shared utilities
│   ├── constants/       # App-wide constants
│   ├── entities/        # Core business entities
│   ├── errors/          # Error handling (Failures & Exceptions)
│   ├── usecases/        # Base use case abstractions
│   └── utils/           # Utility classes and DI setup
│
├── data/                # Data layer
│   ├── datasources/     # Remote and local data sources
│   │   ├── local/      # Local storage implementations
│   │   └── remote/     # API clients and remote sources
│   ├── models/         # Data models with serialization
│   └── repositories/   # Repository implementations
│
├── features/           # Feature modules (vertical slicing)
│   └── products/       # Product feature example
│       ├── domain/     # Business logic layer
│       │   ├── entities/     # Product entity
│       │   ├── repositories/ # Repository contracts
│       │   └── usecases/     # Product-specific use cases
│       ├── data/       # Data layer implementation
│       │   ├── datasources/  # Product API/local sources
│       │   ├── models/       # Product data models
│       │   └── repositories/ # Product repository impl
│       └── presentation/     # UI layer
│           ├── providers/    # Riverpod state management
│           ├── screens/      # Product screens
│           └── widgets/      # Reusable widgets
│
├── presentation/       # Global presentation layer
│   ├── providers/      # Global state providers
│   ├── routes/         # App routing configuration
│   ├── screens/        # Global screens
│   └── widgets/        # Shared widgets
│
└── shared/             # Shared resources
    ├── theme/          # App theming
    ├── utils/          # Shared utilities
    └── widgets/        # Common widgets
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)

### Installation

1. Clone the repository
2. Install dependencies:
```bash
cd pos_system
flutter pub get
```

3. Generate code (for JSON serialization):
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. Run the app:
```bash
flutter run
```

## 📦 Dependencies

### State Management
- **flutter_riverpod**: Modern reactive state management

### Networking
- **dio**: HTTP client for API calls
- **json_annotation**: JSON serialization annotations

### Navigation
- **go_router**: Declarative routing

### Architecture
- **dartz**: Functional programming (Either type for error handling)
- **equatable**: Value equality for entities
- **get_it**: Service locator for dependency injection

### Storage
- **shared_preferences**: Local key-value storage

## 🎯 Features

### Current Features
- ✅ Product listing with search
- ✅ Mock API integration
- ✅ Clean Architecture setup
- ✅ Dependency injection
- ✅ Error handling with Either type
- ✅ Responsive grid layout

### Planned Features
- [ ] User authentication
- [ ] Shopping cart
- [ ] Order management
- [ ] Payment processing
- [ ] Inventory management
- [ ] Reports and analytics

## 🔧 Configuration

### API Configuration
The API base URL can be configured in `lib/core/constants/api_constants.dart`:

```dart
class ApiConstants {
  static const String baseUrl = 'https://api.example.com';      // Production
  static const String mockBaseUrl = 'https://mock.api.example.com'; // Mock
}
```

### Switching Between Mock and Real API
In `lib/data/datasources/remote/api_client.dart`, change:
```dart
_dio.options.baseUrl = ApiConstants.mockBaseUrl; // Switch to baseUrl for production
```

## 🧪 Testing

Run tests:
```bash
flutter test
```

## 📝 Adding New Features

### Step 1: Create Feature Structure
```
lib/features/[feature_name]/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── data/
│   ├── models/
│   ├── datasources/
│   └── repositories/
└── presentation/
    ├── providers/
    ├── screens/
    └── widgets/
```

### Step 2: Define Domain Layer
1. Create entity in `domain/entities/`
2. Define repository contract in `domain/repositories/`
3. Implement use cases in `domain/usecases/`

### Step 3: Implement Data Layer
1. Create data model in `data/models/`
2. Implement data source in `data/datasources/`
3. Implement repository in `data/repositories/`

### Step 4: Build Presentation Layer
1. Create Riverpod providers in `presentation/providers/`
2. Build screens in `presentation/screens/`
3. Create reusable widgets in `presentation/widgets/`

### Step 5: Register Dependencies
Add to `lib/core/utils/dependency_injection.dart`:
```dart
// Data Sources
getIt.registerLazySingleton<YourDataSource>(
  () => YourDataSourceImpl(apiClient: getIt()),
);

// Repositories
getIt.registerLazySingleton<YourRepository>(
  () => YourRepositoryImpl(dataSource: getIt()),
);

// Use Cases
getIt.registerLazySingleton(() => YourUseCase(getIt()));
```

## 🎨 Theming

Themes are defined in `lib/shared/theme/app_theme.dart`. The app supports both light and dark modes.

## 📱 Responsive Design

The app uses responsive layouts:
- Grid view for product listing
- Adaptive spacing and sizing
- Support for various screen sizes

## 🔐 Error Handling

The app uses functional error handling with the Either type:
```dart
Future<Either<Failure, Success>> operation() async {
  try {
    // Operation logic
    return Right(success);
  } catch (e) {
    return Left(Failure(message: e.toString()));
  }
}
```

## 📄 License

This project is open source and available under the MIT License.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.