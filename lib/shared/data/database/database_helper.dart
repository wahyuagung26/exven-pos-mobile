import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../domain/failures/failures.dart';
import '../../utils/uuid_generator.dart';
import '../../utils/date_helpers.dart';

/// SQLite Database Helper for JagoKasir offline-first POS system
/// 
/// Manages database lifecycle, schema migrations, and provides
/// transactional operations following the offline-first pattern.
class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    _instance ??= DatabaseHelper._internal();
    return _instance!;
  }

  /// Get database instance (singleton)
  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  /// Initialize database with schema
  Future<Database> _initDatabase() async {
    try {
      final documentsDirectory = await getDatabasesPath();
      final path = join(documentsDirectory, 'jagokasir.db');

      return await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        onConfigure: _onConfigure,
      );
    } catch (e) {
      throw DatabaseFailure('Failed to initialize database', e.toString());
    }
  }

  /// Configure database settings
  Future<void> _onConfigure(Database db) async {
    // Enable foreign keys
    await db.execute('PRAGMA foreign_keys = ON');
    // Enable WAL mode for better concurrency
    await db.execute('PRAGMA journal_mode = WAL');
    // Set cache size (in KB)
    await db.execute('PRAGMA cache_size = -2000');
  }

  /// Create database schema (version 1)
  Future<void> _onCreate(Database db, int version) async {
    await db.transaction((txn) async {
      // Schema version tracking
      await txn.execute('''
        CREATE TABLE schema_version (
          version INTEGER PRIMARY KEY,
          applied_at INTEGER DEFAULT (strftime('%s', 'now') * 1000)
        )
      ''');

      // Insert initial version
      await txn.insert('schema_version', {'version': 1});

      // Outlets table
      await txn.execute('''
        CREATE TABLE outlets (
          id TEXT PRIMARY KEY,
          name TEXT NOT NULL,
          code TEXT NOT NULL UNIQUE,
          description TEXT,
          address TEXT,
          city TEXT,
          province TEXT,
          postal_code TEXT,
          phone TEXT,
          email TEXT,
          settings TEXT,
          created_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
          updated_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
          deleted_at INTEGER DEFAULT NULL
        )
      ''');

      // Users table
      await txn.execute('''
        CREATE TABLE users (
          id TEXT PRIMARY KEY,
          outlet_id TEXT NOT NULL,
          role TEXT NOT NULL DEFAULT 'cashier',
          email TEXT,
          full_name TEXT NOT NULL,
          phone TEXT,
          is_active INTEGER DEFAULT 1,
          last_login_at INTEGER DEFAULT NULL,
          created_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
          updated_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
          deleted_at INTEGER DEFAULT NULL,
          
          FOREIGN KEY (outlet_id) REFERENCES outlets(id)
        )
      ''');

      // Product categories table
      await txn.execute('''
        CREATE TABLE product_categories (
          id TEXT PRIMARY KEY,
          parent_id TEXT DEFAULT NULL,
          name TEXT NOT NULL,
          description TEXT,
          sort_order INTEGER DEFAULT 0,
          created_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
          updated_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
          deleted_at INTEGER DEFAULT NULL,
          
          FOREIGN KEY (parent_id) REFERENCES product_categories(id)
        )
      ''');

      // Products table
      await txn.execute('''
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

      // Customers table
      await txn.execute('''
        CREATE TABLE customers (
          id TEXT PRIMARY KEY,
          code TEXT UNIQUE,
          name TEXT NOT NULL,
          email TEXT,
          phone TEXT,
          address TEXT,
          total_spent REAL DEFAULT 0.00,
          visit_count INTEGER DEFAULT 0,
          last_visit_at INTEGER DEFAULT NULL,
          notes TEXT,
          created_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
          updated_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
          deleted_at INTEGER DEFAULT NULL
        )
      ''');

      // Transactions table
      await txn.execute('''
        CREATE TABLE transactions (
          id TEXT PRIMARY KEY,
          outlet_id TEXT NOT NULL,
          cashier_id TEXT NOT NULL,
          customer_id TEXT DEFAULT NULL,
          customer_name_snapshot TEXT,
          customer_phone_snapshot TEXT,
          cashier_name_snapshot TEXT NOT NULL,
          outlet_name_snapshot TEXT NOT NULL,
          outlet_code_snapshot TEXT NOT NULL,
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
          synced_to_cloud INTEGER DEFAULT 0,
          cloud_transaction_id TEXT DEFAULT NULL,
          created_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
          updated_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
          deleted_at INTEGER DEFAULT NULL,
          
          FOREIGN KEY (outlet_id) REFERENCES outlets(id),
          FOREIGN KEY (cashier_id) REFERENCES users(id),
          FOREIGN KEY (customer_id) REFERENCES customers(id)
        )
      ''');

      // Transaction items table
      await txn.execute('''
        CREATE TABLE transaction_items (
          id TEXT PRIMARY KEY,
          transaction_id TEXT NOT NULL,
          product_id TEXT NOT NULL,
          product_name_snapshot TEXT NOT NULL,
          product_sku_snapshot TEXT NOT NULL,
          product_category_snapshot TEXT,
          product_unit_snapshot TEXT DEFAULT 'pcs',
          quantity INTEGER NOT NULL,
          unit_price REAL NOT NULL,
          cost_price_snapshot REAL DEFAULT 0.00,
          discount_amount REAL DEFAULT 0.00,
          total_price REAL NOT NULL,
          notes TEXT,
          created_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
          updated_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
          deleted_at INTEGER DEFAULT NULL,
          
          FOREIGN KEY (transaction_id) REFERENCES transactions(id) ON DELETE CASCADE,
          FOREIGN KEY (product_id) REFERENCES products(id)
        )
      ''');

      // Transaction payments table
      await txn.execute('''
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

      // Cash shifts table
      await txn.execute('''
        CREATE TABLE cash_shifts (
          id TEXT PRIMARY KEY,
          outlet_id TEXT NOT NULL,
          cashier_id TEXT NOT NULL,
          cashier_name_snapshot TEXT NOT NULL,
          shift_start INTEGER DEFAULT (strftime('%s', 'now') * 1000),
          shift_end INTEGER DEFAULT NULL,
          opening_balance REAL DEFAULT 0.00,
          closing_balance REAL DEFAULT NULL,
          expected_cash REAL DEFAULT NULL,
          cash_sales REAL DEFAULT 0.00,
          non_cash_sales REAL DEFAULT 0.00,
          total_transactions INTEGER DEFAULT 0,
          notes TEXT,
          status TEXT DEFAULT 'open',
          created_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
          updated_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
          deleted_at INTEGER DEFAULT NULL,
          
          FOREIGN KEY (outlet_id) REFERENCES outlets(id),
          FOREIGN KEY (cashier_id) REFERENCES users(id)
        )
      ''');

      // Expenses table
      await txn.execute('''
        CREATE TABLE expenses (
          id TEXT PRIMARY KEY,
          outlet_id TEXT NOT NULL,
          cashier_id TEXT NOT NULL,
          cashier_name_snapshot TEXT NOT NULL,
          category TEXT NOT NULL,
          description TEXT NOT NULL,
          amount REAL NOT NULL,
          expense_date INTEGER DEFAULT (strftime('%s', 'now') * 1000),
          receipt_photo TEXT,
          notes TEXT,
          synced_to_cloud INTEGER DEFAULT 0,
          cloud_expense_id TEXT DEFAULT NULL,
          created_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
          updated_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
          deleted_at INTEGER DEFAULT NULL,
          
          FOREIGN KEY (outlet_id) REFERENCES outlets(id),
          FOREIGN KEY (cashier_id) REFERENCES users(id)
        )
      ''');

      // Sync queue table
      await txn.execute('''
        CREATE TABLE sync_queue (
          id TEXT PRIMARY KEY,
          table_name TEXT NOT NULL,
          record_id TEXT NOT NULL,
          operation TEXT NOT NULL,
          data TEXT,
          retry_count INTEGER DEFAULT 0,
          last_error TEXT DEFAULT NULL,
          created_at INTEGER DEFAULT (strftime('%s', 'now') * 1000),
          updated_at INTEGER DEFAULT (strftime('%s', 'now') * 1000)
        )
      ''');

      // Sync history table
      await txn.execute('''
        CREATE TABLE sync_history (
          id TEXT PRIMARY KEY,
          sync_type TEXT NOT NULL,
          records_synced INTEGER DEFAULT 0,
          records_failed INTEGER DEFAULT 0,
          sync_start INTEGER DEFAULT (strftime('%s', 'now') * 1000),
          sync_end INTEGER DEFAULT NULL,
          status TEXT DEFAULT 'running',
          error_message TEXT DEFAULT NULL,
          created_at INTEGER DEFAULT (strftime('%s', 'now') * 1000)
        )
      ''');

      // App settings table
      await txn.execute('''
        CREATE TABLE app_settings (
          key TEXT PRIMARY KEY,
          value TEXT,
          description TEXT,
          updated_at INTEGER DEFAULT (strftime('%s', 'now') * 1000)
        )
      ''');

      // Create indexes
      await _createIndexes(txn);

      // Create views
      await _createViews(txn);

      // Insert default settings
      await _insertDefaultSettings(txn);
    });
  }

  /// Create database indexes for performance
  Future<void> _createIndexes(Transaction txn) async {
    final indexes = [
      'CREATE INDEX idx_products_sku ON products(sku) WHERE deleted_at IS NULL',
      'CREATE INDEX idx_products_barcode ON products(barcode) WHERE deleted_at IS NULL',
      'CREATE INDEX idx_products_name ON products(name) WHERE deleted_at IS NULL',
      'CREATE INDEX idx_products_category ON products(category_id) WHERE deleted_at IS NULL',
      
      'CREATE INDEX idx_transactions_date ON transactions(transaction_date) WHERE deleted_at IS NULL',
      'CREATE INDEX idx_transactions_cashier ON transactions(cashier_id) WHERE deleted_at IS NULL',
      'CREATE INDEX idx_transactions_status ON transactions(status) WHERE deleted_at IS NULL',
      'CREATE INDEX idx_transactions_sync ON transactions(synced_to_cloud) WHERE deleted_at IS NULL',
      
      'CREATE INDEX idx_transaction_items_transaction ON transaction_items(transaction_id) WHERE deleted_at IS NULL',
      'CREATE INDEX idx_transaction_items_product ON transaction_items(product_id) WHERE deleted_at IS NULL',
      
      'CREATE INDEX idx_customers_phone ON customers(phone) WHERE deleted_at IS NULL',
      'CREATE INDEX idx_customers_code ON customers(code) WHERE deleted_at IS NULL',
      
      'CREATE INDEX idx_cash_shifts_cashier_date ON cash_shifts(cashier_id, shift_start) WHERE deleted_at IS NULL',
      'CREATE INDEX idx_cash_shifts_status ON cash_shifts(status) WHERE deleted_at IS NULL',
      
      'CREATE INDEX idx_expenses_date ON expenses(expense_date) WHERE deleted_at IS NULL',
      'CREATE INDEX idx_expenses_category ON expenses(category) WHERE deleted_at IS NULL',
      'CREATE INDEX idx_expenses_sync ON expenses(synced_to_cloud) WHERE deleted_at IS NULL',
      
      'CREATE INDEX idx_sync_queue_table_operation ON sync_queue(table_name, operation)',
      'CREATE INDEX idx_sync_queue_retry ON sync_queue(retry_count)',
    ];

    for (final index in indexes) {
      await txn.execute(index);
    }
  }

  /// Create database views for common queries
  Future<void> _createViews(Transaction txn) async {
    // Daily sales summary view
    await txn.execute('''
      CREATE VIEW daily_sales_summary AS
      SELECT 
        DATE(transaction_date / 1000, 'unixepoch', 'localtime') as sale_date,
        COUNT(*) as total_transactions,
        SUM(total_amount) as total_sales,
        SUM(CASE WHEN payment_method = 'cash' THEN total_amount ELSE 0 END) as cash_sales,
        SUM(CASE WHEN payment_method != 'cash' THEN total_amount ELSE 0 END) as non_cash_sales,
        AVG(total_amount) as average_transaction
      FROM transactions 
      WHERE deleted_at IS NULL AND status = 'completed'
      GROUP BY DATE(transaction_date / 1000, 'unixepoch', 'localtime')
      ORDER BY sale_date DESC
    ''');

    // Top selling products view
    await txn.execute('''
      CREATE VIEW top_selling_products AS
      SELECT 
        ti.product_id,
        ti.product_name_snapshot as product_name,
        ti.product_sku_snapshot as product_sku,
        SUM(ti.quantity) as total_quantity,
        SUM(ti.total_price) as total_revenue,
        COUNT(DISTINCT ti.transaction_id) as transaction_count
      FROM transaction_items ti
      JOIN transactions t ON ti.transaction_id = t.id
      WHERE ti.deleted_at IS NULL 
        AND t.deleted_at IS NULL 
        AND t.status = 'completed'
      GROUP BY ti.product_id, ti.product_name_snapshot, ti.product_sku_snapshot
      ORDER BY total_quantity DESC
    ''');

    // Low stock products view
    await txn.execute('''
      CREATE VIEW low_stock_products AS
      SELECT 
        id,
        sku,
        name,
        current_stock,
        min_stock,
        (min_stock - current_stock) as stock_deficit
      FROM products 
      WHERE deleted_at IS NULL 
        AND track_stock = 1 
        AND current_stock <= min_stock
      ORDER BY stock_deficit DESC
    ''');
  }

  /// Insert default application settings
  Future<void> _insertDefaultSettings(Transaction txn) async {
    final defaultSettings = [
      {'key': 'app_version', 'value': '1.0.0', 'description': 'Current app version'},
      {'key': 'last_backup', 'value': null, 'description': 'Last successful backup timestamp'},
      {'key': 'auto_backup_enabled', 'value': '1', 'description': 'Enable automatic cloud backup'},
      {'key': 'receipt_printer_enabled', 'value': '0', 'description': 'Enable receipt printer'},
      {'key': 'low_stock_alert', 'value': '1', 'description': 'Enable low stock alerts'},
      {'key': 'tax_enabled', 'value': '0', 'description': 'Enable tax calculation'},
      {'key': 'default_tax_rate', 'value': '11.0', 'description': 'Default tax rate percentage'},
      {'key': 'currency_symbol', 'value': 'Rp', 'description': 'Currency symbol for display'},
      {'key': 'receipt_footer_text', 'value': 'Terima kasih atas kunjungan Anda!', 'description': 'Footer text for receipts'},
    ];

    for (final setting in defaultSettings) {
      await txn.insert('app_settings', {
        ...setting,
        'updated_at': DateHelpers.now(),
      });
    }
  }

  /// Handle database upgrades
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Future migrations will be implemented here
    // For now, we only have version 1
  }

  /// Initialize default data (first run setup)
  Future<void> initializeDefaultData({
    required String outletName,
    required String outletCode,
    required String ownerName,
    String ownerEmail = '',
  }) async {
    try {
      final db = await database;
      
      await db.transaction((txn) async {
        final now = DateHelpers.now();
        final outletId = UuidV7Generator.generate();
        final ownerId = UuidV7Generator.generate();

        // Create default outlet
        await txn.insert('outlets', {
          'id': outletId,
          'name': outletName,
          'code': outletCode,
          'description': 'Default outlet',
          'settings': '{}',
          'created_at': now,
          'updated_at': now,
        });

        // Create default owner user
        await txn.insert('users', {
          'id': ownerId,
          'outlet_id': outletId,
          'role': 'owner',
          'email': ownerEmail,
          'full_name': ownerName,
          'is_active': 1,
          'created_at': now,
          'updated_at': now,
        });

        // Create default product categories
        final categories = [
          {'name': 'Makanan', 'description': 'Kategori makanan'},
          {'name': 'Minuman', 'description': 'Kategori minuman'},
          {'name': 'Aksesoris', 'description': 'Kategori aksesoris'},
          {'name': 'Lainnya', 'description': 'Kategori lainnya'},
        ];

        for (int i = 0; i < categories.length; i++) {
          await txn.insert('product_categories', {
            'id': UuidV7Generator.generate(),
            'name': categories[i]['name'],
            'description': categories[i]['description'],
            'sort_order': i,
            'created_at': now,
            'updated_at': now,
          });
        }
      });
    } catch (e) {
      throw DatabaseFailure('Failed to initialize default data', e.toString());
    }
  }

  /// Execute raw SQL query
  Future<List<Map<String, dynamic>>> rawQuery(String sql, [List<dynamic>? arguments]) async {
    try {
      final db = await database;
      return await db.rawQuery(sql, arguments);
    } catch (e) {
      throw DatabaseFailure('Raw query failed', e.toString());
    }
  }

  /// Execute raw SQL command
  Future<int> rawExecute(String sql, [List<dynamic>? arguments]) async {
    try {
      final db = await database;
      return await db.rawUpdate(sql, arguments);
    } catch (e) {
      throw DatabaseFailure('Raw execute failed', e.toString());
    }
  }

  /// Execute transaction with rollback on error
  Future<T> transaction<T>(Future<T> Function(Transaction txn) action) async {
    try {
      final db = await database;
      return await db.transaction(action);
    } catch (e) {
      throw DatabaseFailure('Transaction failed', e.toString());
    }
  }

  /// Get database file path
  Future<String> getDatabasePath() async {
    final documentsDirectory = await getDatabasesPath();
    return join(documentsDirectory, 'jagokasir.db');
  }

  /// Get database file size in bytes
  Future<int> getDatabaseSize() async {
    final path = await getDatabasePath();
    final file = File(path);
    if (await file.exists()) {
      return await file.length();
    }
    return 0;
  }

  /// Delete database (for testing or reset)
  Future<void> deleteDatabase() async {
    final path = await getDatabasePath();
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
    _database = null;
  }

  /// Close database connection
  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }

  /// Check if database exists
  Future<bool> exists() async {
    final path = await getDatabasePath();
    return await File(path).exists();
  }

  /// Get current schema version
  Future<int> getSchemaVersion() async {
    try {
      final db = await database;
      final result = await db.query(
        'schema_version',
        orderBy: 'version DESC',
        limit: 1,
      );
      
      if (result.isNotEmpty) {
        return result.first['version'] as int;
      }
      return 0;
    } catch (e) {
      throw DatabaseFailure('Failed to get schema version', e.toString());
    }
  }
}