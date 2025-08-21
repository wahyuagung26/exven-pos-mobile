# PHASE 1 - Development Architecture (Offline-First MVP)

> **Goal:** Implementasi MVP offline-first dengan fitur core POS tanpa sync cloud. Target: 2-3 bulan development.

---

## 1) Scope Phase 1

### ✅ Features yang Diimplementasi
- **Authentication offline** (PIN/password lokal)
- **Product management** (CRUD, kategorisasi, stock tracking)
- **Transaction processing** (penjualan, multiple payment)
- **Cash shift management** (buka/tutup kasir)
- **Basic reporting** (harian, mingguan, bulanan)
- **Expense tracking** sederhana
- **Receipt printing** (Bluetooth thermal printer)
- **Data export** (PDF, Excel)

### ❌ Features yang Ditunda ke Phase 2
- Cloud sync & backup
- Multi-device support
- WhatsApp integration
- QRIS integration
- Customer loyalty program
- Advanced analytics

---

## 2) Tech Stack & Dependencies

### 2.1 Core Framework
```yaml
# pubspec.yaml - Core dependencies
dependencies:
  flutter: ^3.19.0
  
  # State Management
  flutter_riverpod: ^2.4.10
  riverpod_annotation: ^2.3.4
  
  # Local Database
  sqflite: ^2.3.2
  sqlite3_flutter_libs: ^0.5.20
  
  # Navigation
  go_router: ^13.2.0
  
  # Data Models & Serialization
  freezed: ^2.4.7
  json_annotation: ^4.8.1
  
  # Local Storage
  shared_preferences: ^2.2.2
  flutter_secure_storage: ^9.0.0
  
  # UI/UX
  flutter_localizations: ^any
  intl: ^0.19.0
  material_design_icons_flutter: ^7.0.7296
  
  # Utils
  uuid: ^4.3.3
  path: ^1.8.3
  file_picker: ^6.1.1
  
  # Printing
  bluetooth_thermal_printer: ^0.0.6
  
  # PDF Generation
  pdf: ^3.10.7
  printing: ^5.12.0
  
  # Excel Export
  excel: ^4.0.3

dev_dependencies:
  # Code Generation
  build_runner: ^2.4.8
  freezed: ^2.4.7
  json_serializable: ^6.7.1
  riverpod_generator: ^2.3.9
  
  # Testing
  flutter_test: ^any
  mockito: ^5.4.4
  fake_async: ^1.3.1
```

### 2.2 Architecture Pattern
- **Clean Architecture** dengan feature-based modules
- **Repository Pattern** untuk data access abstraction
- **Riverpod** untuk dependency injection & state management
- **Freezed** untuk immutable data classes
- **Code Generation** untuk boilerplate reduction

---

## 3) Project Structure

```
jagokasir/
├── lib/
│   ├── main.dart                    # App entry point
│   ├── app/
│   │   ├── app.dart                 # MaterialApp setup
│   │   ├── router.dart              # GoRouter configuration
│   │   └── providers.dart           # Global providers (DB, etc)
│   │
│   ├── features/
│   │   ├── auth/
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   │   ├── user_model.dart
│   │   │   │   │   └── auth_session_model.dart
│   │   │   │   ├── sources/
│   │   │   │   │   ├── auth_local_source.dart
│   │   │   │   │   └── secure_storage_source.dart
│   │   │   │   └── auth_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   ├── user.dart
│   │   │   │   │   └── auth_session.dart
│   │   │   │   ├── auth_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       ├── login_usecase.dart
│   │   │   │       ├── logout_usecase.dart
│   │   │   │       └── check_auth_usecase.dart
│   │   │   ├── ui/
│   │   │   │   ├── pages/
│   │   │   │   │   ├── login_page.dart
│   │   │   │   │   └── setup_page.dart
│   │   │   │   └── widgets/
│   │   │   │       ├── pin_input_widget.dart
│   │   │   │       └── auth_form_widget.dart
│   │   │   └── providers.dart
│   │   │
│   │   ├── products/
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   │   ├── product_model.dart
│   │   │   │   │   └── category_model.dart
│   │   │   │   ├── sources/
│   │   │   │   │   └── products_local_source.dart
│   │   │   │   └── products_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   ├── product.dart
│   │   │   │   │   └── product_category.dart
│   │   │   │   ├── products_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       ├── get_products_usecase.dart
│   │   │   │       ├── save_product_usecase.dart
│   │   │   │       └── update_stock_usecase.dart
│   │   │   ├── ui/
│   │   │   │   ├── pages/
│   │   │   │   │   ├── products_page.dart
│   │   │   │   │   ├── product_form_page.dart
│   │   │   │   │   └── categories_page.dart
│   │   │   │   └── widgets/
│   │   │   │       ├── product_card.dart
│   │   │   │       ├── product_search.dart
│   │   │   │       └── stock_indicator.dart
│   │   │   └── providers.dart
│   │   │
│   │   ├── sales/
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   │   ├── transaction_model.dart
│   │   │   │   │   ├── transaction_item_model.dart
│   │   │   │   │   └── cash_shift_model.dart
│   │   │   │   ├── sources/
│   │   │   │   │   └── sales_local_source.dart
│   │   │   │   └── sales_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   ├── transaction.dart
│   │   │   │   │   ├── transaction_item.dart
│   │   │   │   │   ├── cash_shift.dart
│   │   │   │   │   └── cart.dart
│   │   │   │   ├── sales_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       ├── create_transaction_usecase.dart
│   │   │   │       ├── manage_cart_usecase.dart
│   │   │   │       ├── open_shift_usecase.dart
│   │   │   │       └── close_shift_usecase.dart
│   │   │   ├── ui/
│   │   │   │   ├── pages/
│   │   │   │   │   ├── pos_page.dart
│   │   │   │   │   ├── payment_page.dart
│   │   │   │   │   └── shift_management_page.dart
│   │   │   │   └── widgets/
│   │   │   │       ├── product_grid.dart
│   │   │   │       ├── cart_widget.dart
│   │   │   │       ├── payment_methods.dart
│   │   │   │       └── receipt_preview.dart
│   │   │   └── providers.dart
│   │   │
│   │   ├── reports/
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   │   ├── sales_summary_model.dart
│   │   │   │   │   └── report_filter_model.dart
│   │   │   │   ├── sources/
│   │   │   │   │   └── reports_local_source.dart
│   │   │   │   └── reports_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   ├── sales_summary.dart
│   │   │   │   │   ├── product_performance.dart
│   │   │   │   │   └── report_filter.dart
│   │   │   │   ├── reports_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       ├── generate_sales_report_usecase.dart
│   │   │   │       ├── export_pdf_usecase.dart
│   │   │   │       └── export_excel_usecase.dart
│   │   │   ├── ui/
│   │   │   │   ├── pages/
│   │   │   │   │   ├── reports_page.dart
│   │   │   │   │   └── report_detail_page.dart
│   │   │   │   └── widgets/
│   │   │   │       ├── sales_chart.dart
│   │   │   │       ├── report_filter.dart
│   │   │   │       └── export_buttons.dart
│   │   │   └── providers.dart
│   │   │
│   │   ├── expenses/
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   │   └── expense_model.dart
│   │   │   │   ├── sources/
│   │   │   │   │   └── expenses_local_source.dart
│   │   │   │   └── expenses_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   └── expense.dart
│   │   │   │   ├── expenses_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       ├── add_expense_usecase.dart
│   │   │   │       └── get_expenses_usecase.dart
│   │   │   ├── ui/
│   │   │   │   ├── pages/
│   │   │   │   │   ├── expenses_page.dart
│   │   │   │   │   └── expense_form_page.dart
│   │   │   │   └── widgets/
│   │   │   │       ├── expense_card.dart
│   │   │   │       └── expense_categories.dart
│   │   │   └── providers.dart
│   │   │
│   │   └── settings/
│   │       ├── data/
│   │       │   ├── models/
│   │       │   │   ├── outlet_model.dart
│   │       │   │   └── app_settings_model.dart
│   │       │   ├── sources/
│   │       │   │   └── settings_local_source.dart
│   │       │   └── settings_repository_impl.dart
│   │       ├── domain/
│   │       │   ├── entities/
│   │       │   │   ├── outlet.dart
│   │       │   │   └── app_settings.dart
│   │       │   ├── settings_repository.dart
│   │       │   └── usecases/
│   │       │       ├── update_outlet_usecase.dart
│   │       │       └── manage_settings_usecase.dart
│   │       ├── ui/
│   │       │   ├── pages/
│   │       │   │   ├── settings_page.dart
│   │       │   │   ├── outlet_settings_page.dart
│   │       │   │   └── printer_settings_page.dart
│   │       │   └── widgets/
│   │       │       ├── settings_tile.dart
│   │       │       └── printer_test_widget.dart
│   │       └── providers.dart
│   │
│   ├── shared/
│   │   ├── data/
│   │   │   ├── database/
│   │   │   │   ├── database_helper.dart
│   │   │   │   ├── migrations/
│   │   │   │   │   └── migration_v1.dart
│   │   │   │   └── tables/
│   │   │   │       ├── base_table.dart
│   │   │   │       ├── products_table.dart
│   │   │   │       ├── transactions_table.dart
│   │   │   │       └── outlets_table.dart
│   │   │   ├── storage/
│   │   │   │   ├── secure_storage.dart
│   │   │   │   └── shared_preferences_helper.dart
│   │   │   └── printing/
│   │   │       ├── thermal_printer.dart
│   │   │       └── receipt_generator.dart
│   │   │
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── base_entity.dart
│   │   │   │   └── api_response.dart
│   │   │   └── failures/
│   │   │       ├── database_failure.dart
│   │   │       ├── validation_failure.dart
│   │   │       └── printer_failure.dart
│   │   │
│   │   ├── ui/
│   │   │   ├── theme/
│   │   │   │   ├── app_theme.dart
│   │   │   │   ├── app_colors.dart
│   │   │   │   └── app_text_styles.dart
│   │   │   └── widgets/
│   │   │       ├── loading_widget.dart
│   │   │       ├── error_widget.dart
│   │   │       ├── empty_state_widget.dart
│   │   │       ├── currency_input.dart
│   │   │       ├── barcode_scanner.dart
│   │   │       └── confirmation_dialog.dart
│   │   │
│   │   └── utils/
│   │       ├── constants.dart
│   │       ├── extensions.dart
│   │       ├── validators.dart
│   │       ├── formatters.dart
│   │       ├── uuid_generator.dart
│   │       └── date_helpers.dart
│   │
│   └── l10n/
│       ├── app_localizations.dart
│       ├── app_id.arb
│       └── app_en.arb
│
├── test/
│   ├── unit/
│   │   ├── features/
│   │   │   ├── auth/
│   │   │   ├── products/
│   │   │   └── sales/
│   │   └── shared/
│   ├── integration/
│   │   └── database_test.dart
│   └── widget/
│       └── pos_page_test.dart
│
├── assets/
│   ├── images/
│   │   ├── logo.png
│   │   └── icons/
│   ├── fonts/
│   └── config/
│       └── database_schema.sql
│
├── android/
├── ios/
├── pubspec.yaml
└── README.md
```

---

## 4) Core Components Deep Dive

### 4.1 Database Layer
```dart
// shared/data/database/database_helper.dart
class DatabaseHelper {
  static Database? _database;
  
  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }
  
  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'jagokasir.db');
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }
  
  static Future<void> _createDB(Database db, int version) async {
    // Execute schema_sqlite.sql
    final schema = await rootBundle.loadString('assets/config/database_schema.sql');
    final statements = schema.split(';');
    for (final statement in statements) {
      if (statement.trim().isNotEmpty) {
        await db.execute(statement);
      }
    }
  }
}
```

### 4.2 State Management Pattern
```dart
// features/sales/providers.dart
@riverpod
class CartNotifier extends _$CartNotifier {
  @override
  Cart build() => Cart.empty();
  
  void addItem(Product product, int quantity) {
    final updatedCart = state.addItem(
      CartItem(
        product: product,
        quantity: quantity,
        unitPrice: product.sellingPrice,
      ),
    );
    state = updatedCart;
  }
  
  void removeItem(String productId) {
    state = state.removeItem(productId);
  }
  
  void clear() {
    state = Cart.empty();
  }
}

@riverpod
Future<List<Transaction>> salesHistory(SalesHistoryRef ref) async {
  final repository = ref.watch(salesRepositoryProvider);
  return await repository.getTransactions();
}
```

### 4.3 Navigation Structure
```dart
// app/router.dart
final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const LoginPage(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainLayout(child: child),
        routes: [
          GoRoute(
            path: '/pos',
            builder: (context, state) => const PosPage(),
          ),
          GoRoute(
            path: '/products',
            builder: (context, state) => const ProductsPage(),
            routes: [
              GoRoute(
                path: '/add',
                builder: (context, state) => const ProductFormPage(),
              ),
            ],
          ),
          GoRoute(
            path: '/reports',
            builder: (context, state) => const ReportsPage(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsPage(),
          ),
        ],
      ),
    ],
  );
});
```

---

## 5) Development Roadmap

### Week 1-2: Foundation Setup
- [ ] Project initialization & dependencies
- [ ] Database schema implementation
- [ ] Shared utilities & theme
- [ ] Basic navigation structure

### Week 3-4: Authentication & Settings
- [ ] Offline authentication system
- [ ] Outlet setup & configuration
- [ ] Basic app settings
- [ ] Onboarding flow

### Week 5-7: Product Management
- [ ] Product CRUD operations
- [ ] Category management
- [ ] Stock tracking
- [ ] Barcode scanning integration

### Week 8-10: POS Core Features
- [ ] Transaction processing
- [ ] Cart management
- [ ] Payment methods
- [ ] Receipt generation & printing

### Week 11-12: Reports & Exports
- [ ] Sales reporting
- [ ] Basic analytics
- [ ] PDF/Excel export
- [ ] Cash shift management

### Week 13: Testing & Polish
- [ ] Unit tests coverage
- [ ] Integration testing
- [ ] UI/UX improvements
- [ ] Performance optimization

---

## 6) Testing Strategy

### 6.1 Unit Tests
- **Repository pattern testing** dengan mock data sources
- **Use case testing** untuk business logic validation
- **Provider testing** untuk state management

### 6.2 Integration Tests
- **Database operations** dengan real SQLite
- **Complete user flows** (create product → add to cart → checkout)

### 6.3 Widget Tests
- **POS page functionality**
- **Form validations**
- **Navigation flows**

---

## 7) Deployment & Distribution

### 7.1 Build Configuration
```yaml
# android/app/build.gradle
android {
    compileSdkVersion 34
    ndkVersion flutter.ndkVersion
    
    defaultConfig {
        applicationId "com.exvenlab.jagokasir"
        minSdkVersion 21  # Support Android 5.0+
        targetSdkVersion 34
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
    }
    
    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
}
```

### 7.2 Release Preparation
- **APK optimization** untuk low-end devices
- **Database migration strategy**
- **Crashlytics integration**
- **Play Store listing optimization**

---

## 8) Success Metrics Phase 1

### Technical Metrics
- [ ] **App size < 50MB** untuk distribusi mudah
- [ ] **Startup time < 3 detik** pada device low-end
- [ ] **Database operations < 100ms** untuk responsiveness
- [ ] **Memory usage < 200MB** saat peak usage

### User Experience Metrics
- [ ] **60-second product setup** dari install ke transaksi pertama
- [ ] **One-hand operation** untuk 80% fitur kasir
- [ ] **Offline reliability** 100% tanpa internet

### Business Metrics
- [ ] **100 active users** dalam 30 hari pertama
- [ ] **80% Day-1 retention** dari installers
- [ ] **5+ transactions per day per user** average

---

*Phase 1 Timeline: 12-13 minggu development + 2 minggu testing & deployment = **3.5 bulan total***