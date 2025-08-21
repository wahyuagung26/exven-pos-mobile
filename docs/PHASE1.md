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

### 2.1 Core Framework - EXACT VERSIONS
```yaml
# pubspec.yaml - Core dependencies (EXACT VERSIONS FOR REPRODUCIBILITY)
name: jagokasir
description: Offline-first POS for Indonesian UMKM
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'
  flutter: ">=3.19.0"

dependencies:
  flutter:
    sdk: flutter
  
  # State Management (EXACT VERSIONS)
  flutter_riverpod: 2.4.10
  riverpod_annotation: 2.3.4
  
  # Local Database
  sqflite: 2.3.2
  sqlite3_flutter_libs: 0.5.20
  path: 1.8.3
  
  # Navigation
  go_router: 13.2.0
  
  # Data Models & Serialization
  freezed_annotation: 2.4.1
  json_annotation: 4.8.1
  
  # Local Storage
  shared_preferences: 2.2.2
  flutter_secure_storage: 9.0.0
  
  # UI/UX
  flutter_localizations:
    sdk: flutter
  intl: 0.19.0
  material_design_icons_flutter: 7.0.7296
  
  # Utils
  uuid: 4.3.3
  
  # Barcode
  mobile_scanner: 3.5.7
  
  # File Operations
  file_picker: 6.1.1
  path_provider: 2.1.2
  
  # Printing (Phase 1 - Mock Implementation)
  # bluetooth_thermal_printer: 0.0.6  # Enable in Phase 2
  
  # PDF & Excel Export
  pdf: 3.10.7
  printing: 5.12.0
  syncfusion_flutter_xlsio: 24.2.9

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: 3.0.1
  
  # Code Generation (EXACT VERSIONS)
  build_runner: 2.4.8
  freezed: 2.4.7
  json_serializable: 6.7.1
  riverpod_generator: 2.3.9
  riverpod_lint: 2.3.7
  
  # Testing
  mockito: 5.4.4
  fake_async: 1.3.1
  integration_test:
    sdk: flutter
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

### 4.1 Database Schema (CONCRETE IMPLEMENTATION)
```dart
// shared/data/database/database_helper.dart
class DatabaseHelper {
  static const String _databaseName = 'jagokasir.db';
  static const int _databaseVersion = 1;
  static Database? _database;
  
  static Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }
  
  static Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }
  
  static Future<void> _onCreate(Database db, int version) async {
    // Create outlets table
    await db.execute('''
      CREATE TABLE outlets (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        code TEXT NOT NULL UNIQUE,
        description TEXT,
        address TEXT,
        phone TEXT,
        settings TEXT, -- JSON string
        created_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
        updated_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
        deleted_at INTEGER DEFAULT NULL
      )
    ''');
    
    // Create users table (cashiers)
    await db.execute('''
      CREATE TABLE users (
        id TEXT PRIMARY KEY,
        outlet_id TEXT NOT NULL,
        role TEXT NOT NULL DEFAULT 'cashier',
        full_name TEXT NOT NULL,
        pin_hash TEXT,
        is_active INTEGER DEFAULT 1,
        created_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
        updated_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
        deleted_at INTEGER DEFAULT NULL,
        FOREIGN KEY (outlet_id) REFERENCES outlets(id)
      )
    ''');
    
    // Create product_categories table
    await db.execute('''
      CREATE TABLE product_categories (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT,
        sort_order INTEGER DEFAULT 0,
        created_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
        updated_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
        deleted_at INTEGER DEFAULT NULL
      )
    ''');
    
    // Create products table
    await db.execute('''
      CREATE TABLE products (
        id TEXT PRIMARY KEY,
        category_id TEXT,
        sku TEXT NOT NULL UNIQUE,
        barcode TEXT,
        name TEXT NOT NULL,
        description TEXT,
        unit TEXT DEFAULT 'pcs',
        cost_price REAL DEFAULT 0.00,
        selling_price REAL NOT NULL,
        current_stock INTEGER DEFAULT 0,
        min_stock INTEGER DEFAULT 0,
        track_stock INTEGER DEFAULT 1,
        created_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
        updated_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
        deleted_at INTEGER DEFAULT NULL,
        FOREIGN KEY (category_id) REFERENCES product_categories(id)
      )
    ''');
    
    // Create transactions table
    await db.execute('''
      CREATE TABLE transactions (
        id TEXT PRIMARY KEY,
        outlet_id TEXT NOT NULL,
        cashier_id TEXT NOT NULL,
        cashier_name_snapshot TEXT NOT NULL,
        outlet_name_snapshot TEXT NOT NULL,
        transaction_number TEXT NOT NULL UNIQUE,
        transaction_date INTEGER DEFAULT (strftime('%s', 'now') * 1000),
        subtotal REAL NOT NULL,
        discount_amount REAL DEFAULT 0.00,
        tax_amount REAL DEFAULT 0.00,
        total_amount REAL NOT NULL,
        paid_amount REAL NOT NULL,
        change_amount REAL DEFAULT 0.00,
        payment_method TEXT NOT NULL,
        status TEXT DEFAULT 'completed',
        notes TEXT,
        created_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
        updated_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
        deleted_at INTEGER DEFAULT NULL,
        FOREIGN KEY (outlet_id) REFERENCES outlets(id),
        FOREIGN KEY (cashier_id) REFERENCES users(id)
      )
    ''');
    
    // Create transaction_items table
    await db.execute('''
      CREATE TABLE transaction_items (
        id TEXT PRIMARY KEY,
        transaction_id TEXT NOT NULL,
        product_id TEXT NOT NULL,
        product_name_snapshot TEXT NOT NULL,
        product_sku_snapshot TEXT NOT NULL,
        quantity INTEGER NOT NULL,
        unit_price REAL NOT NULL,
        cost_price_snapshot REAL DEFAULT 0.00,
        discount_amount REAL DEFAULT 0.00,
        total_price REAL NOT NULL,
        created_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
        updated_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
        deleted_at INTEGER DEFAULT NULL,
        FOREIGN KEY (transaction_id) REFERENCES transactions(id) ON DELETE CASCADE,
        FOREIGN KEY (product_id) REFERENCES products(id)
      )
    ''');
    
    // Create transaction_payments table
    await db.execute('''
      CREATE TABLE transaction_payments (
        id TEXT PRIMARY KEY,
        transaction_id TEXT NOT NULL,
        payment_method TEXT NOT NULL,
        amount REAL NOT NULL,
        reference_number TEXT,
        notes TEXT,
        created_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
        updated_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
        deleted_at INTEGER DEFAULT NULL,
        FOREIGN KEY (transaction_id) REFERENCES transactions(id) ON DELETE CASCADE
      )
    ''');
    
    // Create cash_shifts table
    await db.execute('''
      CREATE TABLE cash_shifts (
        id TEXT PRIMARY KEY,
        outlet_id TEXT NOT NULL,
        cashier_id TEXT NOT NULL,
        cashier_name_snapshot TEXT NOT NULL,
        shift_start INTEGER DEFAULT (strftime('%s', 'now') * 1000),
        shift_end INTEGER DEFAULT NULL,
        opening_balance REAL DEFAULT 0.00,
        closing_balance REAL DEFAULT NULL,
        cash_sales REAL DEFAULT 0.00,
        non_cash_sales REAL DEFAULT 0.00,
        total_transactions INTEGER DEFAULT 0,
        status TEXT DEFAULT 'open',
        notes TEXT,
        created_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
        updated_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
        deleted_at INTEGER DEFAULT NULL,
        FOREIGN KEY (outlet_id) REFERENCES outlets(id),
        FOREIGN KEY (cashier_id) REFERENCES users(id)
      )
    ''');
    
    // Create expenses table
    await db.execute('''
      CREATE TABLE expenses (
        id TEXT PRIMARY KEY,
        outlet_id TEXT NOT NULL,
        cashier_id TEXT NOT NULL,
        cashier_name_snapshot TEXT NOT NULL,
        category TEXT NOT NULL,
        description TEXT NOT NULL,
        amount REAL NOT NULL,
        expense_date INTEGER DEFAULT (strftime('%s', 'now') * 1000),
        notes TEXT,
        created_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
        updated_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
        deleted_at INTEGER DEFAULT NULL,
        FOREIGN KEY (outlet_id) REFERENCES outlets(id),
        FOREIGN KEY (cashier_id) REFERENCES users(id)
      )
    ''');
    
    // Create app_settings table
    await db.execute('''
      CREATE TABLE app_settings (
        key TEXT PRIMARY KEY,
        value TEXT,
        description TEXT,
        updated_at INTEGER DEFAULT (strftime('%s', 'now') * 1000)
      )
    ''');
    
    // Insert default settings
    await db.execute('''
      INSERT INTO app_settings (key, value, description) VALUES 
      ('app_version', '1.0.0', 'Current app version'),
      ('currency_symbol', 'Rp', 'Currency symbol'),
      ('tax_enabled', '0', 'Enable tax calculation'),
      ('default_tax_rate', '11.0', 'Default tax rate percentage'),
      ('receipt_footer_text', 'Terima kasih!', 'Receipt footer text')
    ''');
    
    // Create indexes
    await db.execute('CREATE INDEX idx_products_sku ON products(sku) WHERE deleted_at IS NULL');
    await db.execute('CREATE INDEX idx_products_barcode ON products(barcode) WHERE deleted_at IS NULL');
    await db.execute('CREATE INDEX idx_transactions_date ON transactions(transaction_date) WHERE deleted_at IS NULL');
    await db.execute('CREATE INDEX idx_transaction_items_transaction ON transaction_items(transaction_id) WHERE deleted_at IS NULL');
  }
}
```

### 4.2 Data Models (COMPLETE SPECIFICATIONS)
```dart
// features/products/data/models/product_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductModel with _$ProductModel {
  const factory ProductModel({
    required String id,
    String? categoryId,
    required String sku,
    String? barcode,
    required String name,
    String? description,
    @Default('pcs') String unit,
    @Default(0.0) double costPrice,
    required double sellingPrice,
    @Default(0) int currentStock,
    @Default(0) int minStock,
    @Default(true) bool trackStock,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
  
  // Database conversion methods
  factory ProductModel.fromDatabase(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      categoryId: map['category_id'] as String?,
      sku: map['sku'] as String,
      barcode: map['barcode'] as String?,
      name: map['name'] as String,
      description: map['description'] as String?,
      unit: map['unit'] as String? ?? 'pcs',
      costPrice: (map['cost_price'] as num?)?.toDouble() ?? 0.0,
      sellingPrice: (map['selling_price'] as num).toDouble(),
      currentStock: map['current_stock'] as int? ?? 0,
      minStock: map['min_stock'] as int? ?? 0,
      trackStock: (map['track_stock'] as int? ?? 1) == 1,
      createdAt: map['created_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int)
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int)
          : null,
      deletedAt: map['deleted_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['deleted_at'] as int)
          : null,
    );
  }

  Map<String, dynamic> toDatabase() {
    return {
      'id': id,
      'category_id': categoryId,
      'sku': sku,
      'barcode': barcode,
      'name': name,
      'description': description,
      'unit': unit,
      'cost_price': costPrice,
      'selling_price': sellingPrice,
      'current_stock': currentStock,
      'min_stock': minStock,
      'track_stock': trackStock ? 1 : 0,
      'created_at': createdAt?.millisecondsSinceEpoch,
      'updated_at': updatedAt?.millisecondsSinceEpoch,
      'deleted_at': deletedAt?.millisecondsSinceEpoch,
    };
  }
}

// features/sales/data/models/transaction_model.dart
@freezed
class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required String id,
    required String outletId,
    required String cashierId,
    required String cashierNameSnapshot,
    required String outletNameSnapshot,
    required String transactionNumber,
    required DateTime transactionDate,
    required double subtotal,
    @Default(0.0) double discountAmount,
    @Default(0.0) double taxAmount,
    required double totalAmount,
    required double paidAmount,
    @Default(0.0) double changeAmount,
    required String paymentMethod,
    @Default('completed') String status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
      
  factory TransactionModel.fromDatabase(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as String,
      outletId: map['outlet_id'] as String,
      cashierId: map['cashier_id'] as String,
      cashierNameSnapshot: map['cashier_name_snapshot'] as String,
      outletNameSnapshot: map['outlet_name_snapshot'] as String,
      transactionNumber: map['transaction_number'] as String,
      transactionDate: DateTime.fromMillisecondsSinceEpoch(map['transaction_date'] as int),
      subtotal: (map['subtotal'] as num).toDouble(),
      discountAmount: (map['discount_amount'] as num?)?.toDouble() ?? 0.0,
      taxAmount: (map['tax_amount'] as num?)?.toDouble() ?? 0.0,
      totalAmount: (map['total_amount'] as num).toDouble(),
      paidAmount: (map['paid_amount'] as num).toDouble(),
      changeAmount: (map['change_amount'] as num?)?.toDouble() ?? 0.0,
      paymentMethod: map['payment_method'] as String,
      status: map['status'] as String? ?? 'completed',
      notes: map['notes'] as String?,
      createdAt: map['created_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int)
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int)
          : null,
      deletedAt: map['deleted_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['deleted_at'] as int)
          : null,
    );
  }

  Map<String, dynamic> toDatabase() {
    return {
      'id': id,
      'outlet_id': outletId,
      'cashier_id': cashierId,
      'cashier_name_snapshot': cashierNameSnapshot,
      'outlet_name_snapshot': outletNameSnapshot,
      'transaction_number': transactionNumber,
      'transaction_date': transactionDate.millisecondsSinceEpoch,
      'subtotal': subtotal,
      'discount_amount': discountAmount,
      'tax_amount': taxAmount,
      'total_amount': totalAmount,
      'paid_amount': paidAmount,
      'change_amount': changeAmount,
      'payment_method': paymentMethod,
      'status': status,
      'notes': notes,
      'created_at': createdAt?.millisecondsSinceEpoch,
      'updated_at': updatedAt?.millisecondsSinceEpoch,
      'deleted_at': deletedAt?.millisecondsSinceEpoch,
    };
  }
}
```

### 4.3 UUID Generation Utility (CONCRETE IMPLEMENTATION)
```dart
// shared/utils/uuid_generator.dart
import 'dart:math';
import 'dart:typed_data';

class UuidGenerator {
  static final Random _random = Random.secure();
  
  /// Generates UUID v7 (time-ordered UUID)
  /// Format: xxxxxxxx-xxxx-7xxx-xxxx-xxxxxxxxxxxx
  /// First 48 bits: Unix timestamp in milliseconds
  /// Next 12 bits: Random
  /// 4 bits: Version (7)
  /// 2 bits: Variant (10)
  /// Last 62 bits: Random
  static String generateV7() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final bytes = Uint8List(16);
    
    // Set timestamp (first 6 bytes)
    bytes[0] = (timestamp >> 40) & 0xFF;
    bytes[1] = (timestamp >> 32) & 0xFF;
    bytes[2] = (timestamp >> 24) & 0xFF;
    bytes[3] = (timestamp >> 16) & 0xFF;
    bytes[4] = (timestamp >> 8) & 0xFF;
    bytes[5] = timestamp & 0xFF;
    
    // Fill remaining bytes with random data
    for (int i = 6; i < 16; i++) {
      bytes[i] = _random.nextInt(256);
    }
    
    // Set version (7) and variant bits
    bytes[6] = (bytes[6] & 0x0F) | 0x70; // Version 7
    bytes[8] = (bytes[8] & 0x3F) | 0x80; // Variant 10
    
    return _formatUuid(bytes);
  }
  
  static String _formatUuid(Uint8List bytes) {
    final buffer = StringBuffer();
    
    // Format: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
    for (int i = 0; i < 16; i++) {
      if (i == 4 || i == 6 || i == 8 || i == 10) {
        buffer.write('-');
      }
      buffer.write(bytes[i].toRadixString(16).padLeft(2, '0'));
    }
    
    return buffer.toString();
  }
}

// shared/utils/date_helpers.dart
class DateHelpers {
  /// Converts DateTime to Unix timestamp in milliseconds
  static int toUnixMilliseconds(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch;
  }
  
  /// Converts Unix timestamp in milliseconds to DateTime
  static DateTime fromUnixMilliseconds(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }
  
  /// Gets current Unix timestamp in milliseconds
  static int nowUnixMilliseconds() {
    return DateTime.now().millisecondsSinceEpoch;
  }
  
  /// Formats DateTime for display
  static String formatForDisplay(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}/'
           '${dateTime.month.toString().padLeft(2, '0')}/'
           '${dateTime.year} '
           '${dateTime.hour.toString().padLeft(2, '0')}:'
           '${dateTime.minute.toString().padLeft(2, '0')}';
  }
  
  /// Formats DateTime for transaction number
  static String formatForTransactionNumber(DateTime dateTime) {
    return '${dateTime.year}${dateTime.month.toString().padLeft(2, '0')}'
           '${dateTime.day.toString().padLeft(2, '0')}'
           '${dateTime.hour.toString().padLeft(2, '0')}'
           '${dateTime.minute.toString().padLeft(2, '0')}'
           '${dateTime.second.toString().padLeft(2, '0')}';
  }
}
```

---

## 9) Concrete Implementation Examples

### 9.1 Product Repository Implementation
```dart
// features/products/data/sources/products_local_source.dart
class ProductsLocalSource {
  final Database _database;
  
  ProductsLocalSource(this._database);
  
  Future<List<ProductModel>> getAllProducts() async {
    final maps = await _database.query(
      'products',
      where: 'deleted_at IS NULL',
      orderBy: 'name ASC',
    );
    return maps.map((map) => ProductModel.fromDatabase(map)).toList();
  }
  
  Future<ProductModel?> getProductById(String id) async {
    final maps = await _database.query(
      'products',
      where: 'id = ? AND deleted_at IS NULL',
      whereArgs: [id],
    );
    
    if (maps.isEmpty) return null;
    return ProductModel.fromDatabase(maps.first);
  }
  
  Future<String> insertProduct(ProductModel product) async {
    final id = UuidGenerator.generateV7();
    final now = DateHelpers.nowUnixMilliseconds();
    
    final productWithTimestamp = product.copyWith(
      id: id,
      createdAt: DateHelpers.fromUnixMilliseconds(now),
      updatedAt: DateHelpers.fromUnixMilliseconds(now),
    );
    
    await _database.insert(
      'products',
      productWithTimestamp.toDatabase(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    
    return id;
  }
  
  Future<void> updateProduct(ProductModel product) async {
    final now = DateHelpers.nowUnixMilliseconds();
    
    final updatedProduct = product.copyWith(
      updatedAt: DateHelpers.fromUnixMilliseconds(now),
    );
    
    await _database.update(
      'products',
      updatedProduct.toDatabase(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }
  
  Future<void> deleteProduct(String id) async {
    final now = DateHelpers.nowUnixMilliseconds();
    
    await _database.update(
      'products',
      {'deleted_at': now, 'updated_at': now},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
  Future<void> updateStock(String productId, int newStock) async {
    final now = DateHelpers.nowUnixMilliseconds();
    
    await _database.update(
      'products',
      {'current_stock': newStock, 'updated_at': now},
      where: 'id = ?',
      whereArgs: [productId],
    );
  }
}

// features/products/data/products_repository_impl.dart
class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsLocalSource _localSource;
  
  ProductsRepositoryImpl(this._localSource);
  
  @override
  Future<Either<DatabaseFailure, List<Product>>> getAllProducts() async {
    try {
      final productModels = await _localSource.getAllProducts();
      final products = productModels.map((model) => model.toDomain()).toList();
      return Right(products);
    } catch (e) {
      return Left(DatabaseFailure('Failed to get products: $e'));
    }
  }
  
  @override
  Future<Either<DatabaseFailure, String>> saveProduct(Product product) async {
    try {
      final productModel = ProductModel.fromDomain(product);
      final id = await _localSource.insertProduct(productModel);
      return Right(id);
    } catch (e) {
      return Left(DatabaseFailure('Failed to save product: $e'));
    }
  }
  
  @override
  Future<Either<DatabaseFailure, void>> updateStock(String productId, int newStock) async {
    try {
      await _localSource.updateStock(productId, newStock);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Failed to update stock: $e'));
    }
  }
}
```

---

### 9.2 State Management Implementation
```dart
// features/sales/providers.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
class CartNotifier extends _$CartNotifier {
  @override
  Cart build() => const Cart(
    items: [],
    subtotal: 0.0,
    discountAmount: 0.0,
    taxAmount: 0.0,
    totalAmount: 0.0,
  );
  
  void addItem(Product product, int quantity) {
    final existingItemIndex = state.items.indexWhere(
      (item) => item.product.id == product.id,
    );
    
    List<CartItem> updatedItems;
    
    if (existingItemIndex >= 0) {
      // Update existing item
      updatedItems = state.items.map((item) {
        if (item.product.id == product.id) {
          return item.copyWith(quantity: item.quantity + quantity);
        }
        return item;
      }).toList();
    } else {
      // Add new item
      final newItem = CartItem(
        id: UuidGenerator.generateV7(),
        product: product,
        quantity: quantity,
        unitPrice: product.sellingPrice,
        totalPrice: product.sellingPrice * quantity,
      );
      updatedItems = [...state.items, newItem];
    }
    
    _updateCartTotals(updatedItems);
  }
  
  void removeItem(String productId) {
    final updatedItems = state.items
        .where((item) => item.product.id != productId)
        .toList();
    _updateCartTotals(updatedItems);
  }
  
  void updateItemQuantity(String productId, int newQuantity) {
    if (newQuantity <= 0) {
      removeItem(productId);
      return;
    }
    
    final updatedItems = state.items.map((item) {
      if (item.product.id == productId) {
        return item.copyWith(
          quantity: newQuantity,
          totalPrice: item.unitPrice * newQuantity,
        );
      }
      return item;
    }).toList();
    
    _updateCartTotals(updatedItems);
  }
  
  void applyDiscount(double discountAmount) {
    final taxAmount = _calculateTax(state.subtotal - discountAmount);
    final totalAmount = state.subtotal - discountAmount + taxAmount;
    
    state = state.copyWith(
      discountAmount: discountAmount,
      taxAmount: taxAmount,
      totalAmount: totalAmount,
    );
  }
  
  void clear() {
    state = const Cart(
      items: [],
      subtotal: 0.0,
      discountAmount: 0.0,
      taxAmount: 0.0,
      totalAmount: 0.0,
    );
  }
  
  void _updateCartTotals(List<CartItem> items) {
    final subtotal = items.fold(0.0, (sum, item) => sum + item.totalPrice);
    final taxAmount = _calculateTax(subtotal - state.discountAmount);
    final totalAmount = subtotal - state.discountAmount + taxAmount;
    
    state = state.copyWith(
      items: items,
      subtotal: subtotal,
      taxAmount: taxAmount,
      totalAmount: totalAmount,
    );
  }
  
  double _calculateTax(double taxableAmount) {
    // Get tax rate from app settings (default 11%)
    const taxRate = 0.11;
    return taxableAmount * taxRate;
  }
}

@riverpod
Future<List<Transaction>> salesHistory(SalesHistoryRef ref) async {
  final repository = ref.watch(salesRepositoryProvider);
  final result = await repository.getTransactions();
  
  return result.fold(
    (failure) => throw Exception(failure.message),
    (transactions) => transactions,
  );
}

@riverpod
Future<SalesSummary> dailySalesSummary(DailySalesSummaryRef ref) async {
  final repository = ref.watch(salesRepositoryProvider);
  final today = DateTime.now();
  final result = await repository.getSalesSummary(today, today);
  
  return result.fold(
    (failure) => throw Exception(failure.message),
    (summary) => summary,
  );
}

// Domain entities
@freezed
class Cart with _$Cart {
  const factory Cart({
    required List<CartItem> items,
    required double subtotal,
    required double discountAmount,
    required double taxAmount,
    required double totalAmount,
  }) = _Cart;
}

@freezed
class CartItem with _$CartItem {
  const factory CartItem({
    required String id,
    required Product product,
    required int quantity,
    required double unitPrice,
    required double totalPrice,
    @Default(0.0) double discountAmount,
  }) = _CartItem;
}
```

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