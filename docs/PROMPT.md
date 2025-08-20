# Claude Code Workflow: Flutter POS Foundation Setup

A step-by-step prompt workflow for Claude Code to setup the foundation layers of the Flutter POS application.

## Prerequisites

Before starting, ensure you have:
- Flutter SDK installed (latest stable version)
- VS Code or Android Studio with Flutter extensions
- Basic understanding of Clean Architecture and Riverpod

## Step 1: Project Initialization

**Prompt for Claude Code:**

```
Create a new Flutter project called "pos_flutter" using clean architecture with the following requirements:

1. Initialize flutter project with these dependencies:
   - flutter_riverpod: latest
   - go_router: latest  
   - dio: latest
   - flutter_secure_storage: latest
   - json_annotation: latest
   - freezed: latest
   - connectivity_plus: latest

2. Add dev dependencies:
   - build_runner: latest
   - json_serializable: latest
   - freezed: latest
   - mockito: latest
   - flutter_test: sdk

3. Setup basic folder structure for MVP (online-first):
   ```
   lib/
   ├── main.dart
   ├── app/
   ├── shared/
   └── l10n/
   ```

4. Create pubspec.yaml with proper configuration for:
   - Flutter intl support
   - Asset management
   - Font configuration

5. Setup basic analysis_options.yaml for linting

Note: This is Phase 1 MVP focusing on online-first architecture. Offline support (SQLite, local caching) will be added in Phase 2.
```

## Step 2: App Layer Foundation

**Prompt for Claude Code:**

```
Setup the app foundation layer with the following structure and requirements:

lib/app/
├── app.dart                     # Main app widget
├── constants/
│   ├── app_constants.dart       # API URLs, timeouts, app config
│   └── app_colors.dart         # Theme colors and design tokens
└── providers/
    ├── app_providers.dart       # Global app providers (HTTP, storage, etc)
    └── router_provider.dart     # GoRouter configuration

Requirements:

1. app/app.dart:
   - Main MaterialApp widget using GoRouter
   - Theme configuration with light/dark mode support
   - Localization support setup
   - Error boundary handling
   - ProviderScope wrapper

2. app/constants/app_constants.dart:
   - API base URLs (dev, staging, production)
   - Timeout configurations
   - App version and build info
   - Default pagination limits
   - Network retry policies

3. app/constants/app_colors.dart:
   - Primary, secondary, accent colors
   - Success, error, warning colors
   - Background and surface colors
   - Text color variations
   - Follow Material Design 3 guidelines

4. app/providers/app_providers.dart:
   - Dio HTTP client provider
   - Secure storage provider
   - Connectivity provider
   - Logger provider
   - Network info provider

5. app/providers/router_provider.dart:
   - GoRouter configuration with authentication guards
   - Public routes (splash, login)
   - Protected routes structure
   - Error handling and not found pages
   - Deep linking support

Create placeholder pages for:
- SplashPage
- LoginPage  
- DashboardPage
- NotFoundPage
- NoInternetPage (for offline scenarios)

Include proper error handling, loading states, and network connectivity awareness for all components.
```

## Step 3: Shared Infrastructure Layer

**Prompt for Claude Code:**

```
Create the shared infrastructure layer for MVP (online-first) with the following structure:

shared/
├── data/
│   ├── datasources/
│   │   └── base_remote_datasource.dart
│   └── models/
│       ├── api_response_model.dart
│       ├── pagination_model.dart
│       └── error_model.dart
├── domain/
│   ├── entities/
│   │   ├── base_entity.dart
│   │   └── pagination_entity.dart
│   ├── repositories/
│   │   └── base_repository.dart
│   └── usecases/
│       └── base_usecase.dart
└── infrastructure/
    ├── network/
    │   ├── dio_client.dart
    │   ├── interceptors/
    │   │   ├── auth_interceptor.dart
    │   │   ├── tenant_interceptor.dart
    │   │   ├── logging_interceptor.dart
    │   │   └── error_interceptor.dart
    │   └── network_info.dart
    ├── storage/
    │   └── secure_storage.dart
    └── services/
        └── notification_service.dart

Requirements:

1. Base Datasources:
   - Abstract base class for remote data access
   - Common error handling patterns
   - Standardized response parsing
   - Pagination support
   - Network connectivity handling

2. Shared Models:
   - Freezed-based immutable models
   - JSON serialization support
   - Standard API response wrapper
   - Error response models
   - Pagination metadata models

3. Base Domain:
   - Abstract entities with common properties
   - Base repository interfaces
   - Base use case pattern with Either error handling
   - Common failure types (NetworkFailure, ServerFailure, etc.)

4. Network Infrastructure:
   - Dio client configuration with base URL
   - Authentication interceptor for JWT tokens
   - Tenant isolation interceptor
   - Request/response logging
   - Error mapping and handling
   - Connectivity checking with user feedback

5. Storage Infrastructure:
   - Secure storage for tokens and sensitive data
   - Multi-tenant data isolation at storage level

6. Services:
   - Notification service for user feedback
   - Network status monitoring

All classes should include:
- Proper documentation
- Error handling with custom exceptions
- Support for multi-tenant architecture
- Network connectivity awareness
- Type safety with generics where applicable
- Future-ready architecture for Phase 2 offline support

Use freezed for immutable models and include proper fromJson/toJson methods.

Note: This is MVP Phase 1 - focus on robust online functionality. Local datasources, SQLite database, and sync services will be added in Phase 2.
```

## Step 4: Shared Presentation Layer

**Prompt for Claude Code:**

```
Create the shared presentation layer with reusable UI components and guards:

shared/presentation/
├── widgets/
│   ├── guards/
│   │   ├── auth_guard_widget.dart
│   │   ├── role_guard_widget.dart
│   │   ├── permission_guard_widget.dart
│   │   ├── tenant_guard_widget.dart
│   │   └── unauthorized_widget.dart
│   ├── common/
│   │   ├── loading_widget.dart
│   │   ├── error_widget.dart
│   │   ├── empty_state_widget.dart
│   │   └── refresh_indicator_widget.dart
│   ├── forms/
│   │   ├── custom_text_field.dart
│   │   ├── custom_dropdown.dart
│   │   └── form_validators.dart
│   └── layout/
│       ├── app_scaffold.dart
│       ├── authenticated_layout.dart
│       ├── bottom_navigation.dart
│       └── app_drawer.dart
├── hooks/
│   ├── use_auth_guard.dart
│   ├── use_permission.dart
│   └── use_current_user.dart
├── theme/
│   ├── app_theme.dart
│   ├── text_styles.dart
│   └── button_styles.dart
└── providers/
    ├── auth_guard_providers.dart
    ├── permission_providers.dart
    ├── theme_provider.dart
    └── connectivity_provider.dart

Requirements:

1. Guard Widgets:
   - Authentication guard with fallback support
   - Role-based access control widget
   - Permission checking widget
   - Tenant isolation widget
   - Unauthorized access display

2. Common Widgets:
   - Consistent loading indicators
   - Error display with retry functionality
   - Empty state illustrations
   - Pull-to-refresh wrapper
   - All widgets should follow Material Design 3

3. Form Components:
   - Custom text field with validation
   - Dropdown with search capability
   - Form validation utilities
   - Input formatters and masks

4. Layout Components:
   - Base scaffold with common structure
   - Authenticated layout with navigation
   - Bottom navigation bar
   - Drawer with user profile and menu

5. Custom Hooks:
   - Authentication status checking
   - Permission validation
   - Current user access
   - Optimized rebuilds

6. Theme System:
   - Light and dark theme support
   - Typography scale
   - Button variants and styles
   - Color scheme management

7. Providers:
   - Guard-related state management
   - Theme switching
   - Connectivity monitoring
   - Permission caching

All components should:
- Be highly reusable across features
- Include proper documentation
- Support accessibility features
- Handle loading and error states
- Use Riverpod for state management
- Follow consistent naming conventions
- Include network connectivity awareness
- Show appropriate messaging for offline scenarios

Note: Focus on online-first UX with graceful handling of network issues. Full offline UI support will be added in Phase 2.
```

## Step 5: Shared Utils Layer

**Prompt for Claude Code:**

```
Create the shared utilities layer with common helpers and extensions:

shared/utils/
├── constants/
│   ├── api_constants.dart
│   ├── storage_constants.dart
│   └── route_constants.dart
├── extensions/
│   ├── context_extensions.dart
│   ├── string_extensions.dart
│   ├── datetime_extensions.dart
│   └── num_extensions.dart
├── helpers/
│   ├── date_helper.dart
│   ├── currency_helper.dart
│   ├── validation_helper.dart
│   └── logger_helper.dart
└── exceptions/
    ├── app_exceptions.dart
    ├── network_exceptions.dart
    └── cache_exceptions.dart

Requirements:

1. Constants:
   - API endpoint paths and headers
   - Storage keys for secure storage and SQLite
   - Route names and paths
   - Configuration values

2. Extensions:
   - BuildContext extensions for theme, navigation, snackbars
   - String utilities (validation, formatting, case conversion)
   - DateTime formatting and manipulation
   - Number formatting (currency, percentage)

3. Helpers:
   - Date parsing and formatting utilities
   - Currency formatting for Indonesian Rupiah
   - Input validation (email, phone, etc.)
   - Logging utilities with different levels

4. Exceptions:
   - Custom exception hierarchy
   - Network-specific exceptions
   - Authentication and authorization exceptions  
   - User-friendly error messages
   - Error codes for different scenarios

All utilities should:
- Be pure functions where possible
- Include comprehensive documentation
- Support internationalization
- Handle edge cases gracefully
- Follow Dart best practices
- Include unit tests where applicable
- Handle network connectivity issues appropriately

Focus on Indonesian locale support for currency and date formatting.

Note: This is MVP Phase 1 utilities. Additional offline-specific utilities will be added in Phase 2.
```

## Step 6: Localization (l10n) Setup

**Prompt for Claude Code:**

```
Setup complete internationalization support for Indonesian and English:

l10n/
├── app_localizations.dart       # Generated localizations class
├── app_en.arb                  # English translations
└── app_id.arb                  # Indonesian translations

Requirements:

1. Create comprehensive translation files with the following categories:

   Common/General:
   - app_name, app_version
   - loading, error, success messages
   - yes, no, cancel, confirm, save, delete
   - next, previous, done, retry

   Authentication:
   - login, logout, register
   - email, password, confirm_password
   - remember_me, forgot_password
   - invalid_email, invalid_password
   - login_success, login_failed

   Navigation:
   - dashboard, products, customers, transactions
   - reports, settings, profile
   - home, back, menu

   Forms:
   - required_field, invalid_format
   - field_too_short, field_too_long
   - password_requirements
   - form_saved, form_error

   Products:
   - product_name, product_code, price
   - category, stock, description
   - add_product, edit_product, delete_product
   - product_saved, product_deleted

   Common Business Terms:
   - customer, transaction, payment
   - discount, tax, total, subtotal
   - cash, card, transfer

   Error Messages:
   - network_error, server_error
   - unauthorized_access, forbidden
   - not_found, validation_error

2. Setup Flutter intl configuration:
   - Configure pubspec.yaml for intl
   - Create l10n.yaml configuration
   - Setup build process for generating localizations

3. Create localization helper:
   - Easy access to translations
   - Plural forms support
   - Parameter substitution
   - Fallback language handling

4. Integration with app:
   - Add to MaterialApp
   - Locale detection and switching
   - Persistent locale preferences

Ensure all translations are:
- Contextually appropriate for POS system
- Professional and user-friendly
- Consistent in terminology
- Properly formatted for Indonesian locale (currency, dates)

Include placeholder translations for future features like reports and analytics.
```

## Step 7: Main Entry Point Setup

**Prompt for Claude Code:**

```
Create the main entry point that ties everything together:

1. main.dart:
   - App initialization
   - Provider scope setup
   - Error boundary configuration
   - Platform-specific setup (Android/iOS)
   - Development vs production configuration

2. Integration requirements:
   - All shared providers registration
   - Router configuration
   - Theme setup
   - Localization initialization
   - Database initialization
   - Network client setup

3. Error handling:
   - Global error catching
   - Crash reporting setup (placeholder)
   - User-friendly error display

4. Performance:
   - Lazy loading setup
   - Memory management
   - Background task configuration

5. Security:
   - Certificate pinning (placeholder)
   - App-level security checks
   - Secure storage initialization

The main.dart should be production-ready with proper error handling, performance optimizations, and security considerations.

Make sure all the previously created components are properly imported and integrated.
```

## Step 8: Testing Foundation

**Prompt for Claude Code:**

```
Create testing foundation and utilities:

test/
├── helpers/
│   ├── test_helpers.dart        # Common test utilities
│   ├── mock_data.dart          # Sample data for testing
│   └── provider_overrides.dart # Provider overrides for testing
├── shared/
│   ├── data/
│   ├── infrastructure/
│   ├── presentation/
│   └── utils/
└── widget_test.dart            # Basic widget tests

Requirements:

1. Test Helpers:
   - ProviderContainer setup for testing
   - Common mock factories
   - Test data generators
   - Widget testing utilities

2. Mock Data:
   - Sample user data
   - Product catalog data
   - Transaction examples
   - Error scenarios
   - Network connectivity scenarios

3. Provider Overrides:
   - Mock providers for testing
   - Fake implementations
   - Test-specific configurations
   - Network simulation for testing

4. Foundation Tests:
   - App initialization tests
   - Router navigation tests
   - Theme switching tests
   - Localization tests
   - Network connectivity handling tests

5. Shared Component Tests:
   - Guard widget tests
   - Common widget tests
   - Extension tests
   - Helper function tests
   - Network error handling tests

All tests should:
- Use mockito for mocking
- Include both unit and widget tests
- Cover error scenarios
- Be maintainable and readable
- Follow testing best practices
- Include network connectivity testing

Setup test configuration that will be easy to extend for feature testing.

Note: This is MVP Phase 1 testing foundation. Offline testing scenarios will be added in Phase 2.
```

## Execution Order

Run these prompts in sequence with Claude Code:

1. **Step 1** → Initialize project and dependencies
2. **Step 2** → Setup app layer foundation  
3. **Step 3** → Create shared infrastructure
4. **Step 4** → Build shared presentation layer
5. **Step 5** → Add shared utilities
6. **Step 6** → Configure localization
7. **Step 7** → Setup main entry point
8. **Step 8** → Create testing foundation

## Validation Checklist

After completing all steps, verify:

- [ ] Project builds without errors
- [ ] Hot reload works properly
- [ ] Navigation between splash/login/dashboard works
- [ ] Theme switching functions correctly
- [ ] Localization switches between EN/ID
- [ ] All shared components render properly
- [ ] Guards prevent unauthorized access appropriately
- [ ] Tests run successfully
- [ ] Network interceptors are configured
- [ ] Connectivity monitoring works correctly
- [ ] Proper error handling for network issues
- [ ] Security storage initializes correctly

## Next Steps

Once foundation is complete, you can proceed with:

1. Authentication feature implementation
2. Products feature implementation  
3. Additional business features
4. Phase 2: Offline support implementation
5. Production deployment configuration

This foundation provides a solid, scalable base for the entire POS application following Clean Architecture principles with proper separation of concerns and future-ready architecture for offline capabilities.