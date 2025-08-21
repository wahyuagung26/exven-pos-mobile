# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is JagoKasir - an offline-first Flutter POS (Point of Sale) system designed for Indonesian UMKM (micro, small & medium enterprises). The app follows a clean architecture pattern with feature-based organization and emphasizes offline-first functionality with future cloud sync capabilities.

## Architecture

### Flutter Clean Architecture
- **Pattern**: Clean Architecture with feature-based vertical slicing
- **State Management**: Riverpod with code generation for reactive state management  
- **Navigation**: GoRouter for declarative routing
- **Database**: SQLite with sqflite for local storage (offline-first)
- **HTTP**: Dio with custom interceptors for API communication
- **Storage**: Secure storage for tokens, SharedPreferences for settings
- **Code Generation**: Freezed for data classes, Riverpod generators, JSON serialization

### Feature Structure
Each feature follows clean architecture layers:
```
features/[feature_name]/
├── data/             # Data sources, models, repository implementations
├── domain/           # Entities, repositories contracts, use cases
└── presentation/     # Pages, widgets, providers (UI layer)
```

## Common Development Commands

### Setup and Dependencies
```bash
# Install dependencies
flutter pub get

# Clean and rebuild
flutter clean && flutter pub get

# Code generation (after model/provider changes)
flutter pub run build_runner build --delete-conflicting-outputs
```

### Development Workflow
```bash
# Run the app
flutter run

# Run with specific flavor (if configured)
flutter run --flavor dev

# Hot reload (automatic during flutter run)
# Hot restart: Press 'R' in terminal during flutter run
```

### Testing
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/shared/data/database/database_helper_test.dart

# Run widget tests
flutter test test/widget/

# Run integration tests (if available)
flutter drive --target=test_driver/app.dart
```

### Code Quality
```bash
# Analyze code (lint)
flutter analyze

# Format code
flutter format .

# Check formatting
flutter format --dry-run .
```

## Key Components

### Database Layer
- **DatabaseHelper** (`lib/shared/data/database/database_helper.dart`) - Singleton SQLite manager with schema versioning
- **Tables**: Products, transactions, customers, outlets, users, cash shifts, expenses
- **Migration Support**: Built-in schema versioning system
- **Views**: Pre-built views for daily sales summary, top products, low stock alerts

### State Management
- **Providers** (`lib/app/providers.dart`) - Global app-level providers for infrastructure
- **Feature Providers** - Each feature has its own providers.dart for local state
- **Riverpod Annotations** - Use `@riverpod` generators instead of manual Provider definitions

### API Layer
- **ApiClient** (`lib/shared/data/api/api_client.dart`) - Dio singleton with interceptors
- **Interceptors**: Auth (Bearer token), Tenant (multi-tenancy), Logging, Error handling
- **Base URL**: Configurable in `lib/shared/utils/constants.dart`

### Utilities
- **UuidGenerator** (`lib/shared/utils/uuid_generator.dart`) - Time-ordered UUID v7 generation
- **DateHelpers** (`lib/shared/utils/date_helpers.dart`) - Timestamp utilities for database
- **Constants** (`lib/shared/utils/constants.dart`) - App-wide constants

## Development Workflow

### Adding New Features
1. Create feature directory in `lib/features/[feature_name]/`
2. Implement domain layer (entities, repositories, use cases)
3. Create data layer (models, sources, repository implementations)  
4. Build presentation layer (pages, widgets, providers)
5. Register providers in feature's `providers.dart`
6. Add navigation routes in `lib/app/router.dart`

### Database Operations
1. All database changes go through DatabaseHelper
2. Use transaction blocks for multi-table operations
3. Follow soft-delete pattern (deleted_at column)
4. Snapshots for referential data (transaction_items store product name/sku snapshots)

### Code Generation Workflow
1. Modify models with `@freezed` or `@riverpod` annotations
2. Run `flutter pub run build_runner build --delete-conflicting-outputs`
3. Import generated files (`.g.dart`, `.freezed.dart`)

## Testing Strategy

### Unit Tests
- Repository implementations with mock data sources
- Use cases with mock repositories
- Utility functions and business logic

### Widget Tests  
- Page widgets with mock providers
- Custom widgets in isolation
- Provider state changes

### Database Tests
- DatabaseHelper with in-memory SQLite (`sqflite_common_ffi`)
- Migration testing
- CRUD operations

## Configuration

### Environment Setup
- API base URL in `ApiConstants.baseUrl`
- Database name in `DatabaseHelper._databaseName`
- App settings stored in `app_settings` table

### Build Configuration
- Target SDK: Flutter >=3.8.1
- Minimum Android API: 21 (Android 5.0)
- Indonesian locale as primary (`id_ID`)

## Key Design Principles

### Offline-First
- All data operations work without internet
- SQLite as single source of truth
- Sync queue table for future cloud sync
- Optimistic UI updates

### Multi-tenancy Ready
- Outlet-based data isolation
- User roles (owner, manager, cashier)
- Tenant interceptor for API calls

### Performance Optimized
- Database indexes on frequently queried columns
- Efficient views for reporting queries
- Lazy loading with providers
- UUID v7 for time-ordered identifiers

## Common Patterns

### Error Handling
- DatabaseFailure for database operations
- Either<Failure, Success> pattern in repositories
- Riverpod AsyncValue for async state management

### Navigation
- Named routes with GoRouter
- Route parameters for entity IDs
- Error page for undefined routes

### State Management
- AsyncNotifier for complex async state
- StateProvider for simple values
- Family providers for parameterized state

## Localization
- Primary locale: Indonesian (`id_ID`)
- Fallback: English (`en_US`)
- Currency: Indonesian Rupiah (Rp)
- Date format: DD/MM/YYYY HH:mm

## Important Files to Check
- `lib/shared/data/database/database_helper.dart` - Database schema and operations
- `lib/app/providers.dart` - Global dependency injection
- `lib/app/router.dart` - Navigation configuration
- `pubspec.yaml` - Dependencies and versions
- `lib/shared/utils/constants.dart` - Configuration constants