import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:jagokasir/shared/data/database/database_helper.dart';
import 'package:jagokasir/shared/utils/uuid_generator.dart';
import 'package:jagokasir/shared/utils/date_helpers.dart';
import 'package:jagokasir/shared/data/database/tables/table_definitions.dart';

void main() {
  late DatabaseHelper databaseHelper;

  setUpAll(() {
    // Initialize the ffi implementation for testing
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    databaseHelper = DatabaseHelper();
    // Use in-memory database for testing
    await databaseHelper.deleteDatabase();
  });

  tearDown(() async {
    await databaseHelper.close();
  });

  group('DatabaseHelper', () {
    test('should initialize database with correct schema', () async {
      final db = await databaseHelper.database;
      expect(db, isNotNull);
      
      // Check if tables exist
      final result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' ORDER BY name"
      );
      
      final tableNames = result.map((row) => row['name'] as String).toList();
      
      // Verify core tables exist
      expect(tableNames, contains(TableNames.outlets));
      expect(tableNames, contains(TableNames.products));
      expect(tableNames, contains(TableNames.transactions));
      expect(tableNames, contains(TableNames.users));
      expect(tableNames, contains(TableNames.appSettings));
    });

    test('should have correct schema version', () async {
      final version = await databaseHelper.getSchemaVersion();
      expect(version, equals(1));
    });

    test('should initialize default settings', () async {
      final db = await databaseHelper.database;
      
      final settings = await db.query(TableNames.appSettings);
      expect(settings.isNotEmpty, true);
      
      // Check for specific default settings
      final appVersion = settings.firstWhere(
        (setting) => setting['key'] == 'app_version'
      );
      expect(appVersion['value'], equals('1.0.0'));
      
      final currencySymbol = settings.firstWhere(
        (setting) => setting['key'] == 'currency_symbol'
      );
      expect(currencySymbol['value'], equals('Rp'));
    });

    test('should initialize default data correctly', () async {
      const outletName = 'Test Outlet';
      const outletCode = 'TEST001';
      const ownerName = 'Test Owner';
      const ownerEmail = 'owner@test.com';

      await databaseHelper.initializeDefaultData(
        outletName: outletName,
        outletCode: outletCode,
        ownerName: ownerName,
        ownerEmail: ownerEmail,
      );

      final db = await databaseHelper.database;

      // Check outlet creation
      final outlets = await db.query(TableNames.outlets);
      expect(outlets.length, equals(1));
      expect(outlets.first['name'], equals(outletName));
      expect(outlets.first['code'], equals(outletCode));

      // Check owner creation
      final users = await db.query(TableNames.users);
      expect(users.length, equals(1));
      expect(users.first['full_name'], equals(ownerName));
      expect(users.first['email'], equals(ownerEmail));
      expect(users.first['role'], equals('owner'));

      // Check categories creation
      final categories = await db.query(TableNames.productCategories);
      expect(categories.length, equals(4)); // Default categories
    });

    test('should perform CRUD operations on outlets', () async {
      const outletName = 'CRUD Test Outlet';
      const outletCode = 'CRUD001';
      
      await databaseHelper.initializeDefaultData(
        outletName: outletName,
        outletCode: outletCode,
        ownerName: 'Test Owner',
      );

      final db = await databaseHelper.database;

      // READ
      var outlets = await db.query(TableNames.outlets);
      expect(outlets.length, equals(1));
      final outletId = outlets.first['id'] as String;

      // UPDATE
      await db.update(
        TableNames.outlets,
        {
          'name': 'Updated Outlet Name',
          'description': 'Updated description',
          'updated_at': DateHelpers.now(),
        },
        where: 'id = ?',
        whereArgs: [outletId],
      );

      outlets = await db.query(
        TableNames.outlets,
        where: 'id = ?',
        whereArgs: [outletId],
      );
      expect(outlets.first['name'], equals('Updated Outlet Name'));
      expect(outlets.first['description'], equals('Updated description'));

      // SOFT DELETE
      await db.update(
        TableNames.outlets,
        {
          'deleted_at': DateHelpers.now(),
          'updated_at': DateHelpers.now(),
        },
        where: 'id = ?',
        whereArgs: [outletId],
      );

      // Verify soft delete (should not appear in active queries)
      final activeOutlets = await db.query(
        TableNames.outlets,
        where: 'deleted_at IS NULL',
      );
      expect(activeOutlets.length, equals(0));

      // Verify record still exists (soft delete)
      final allOutlets = await db.query(TableNames.outlets);
      expect(allOutlets.length, equals(1));
      expect(allOutlets.first['deleted_at'], isNotNull);
    });

    test('should perform CRUD operations on products', () async {
      // First initialize default data
      await databaseHelper.initializeDefaultData(
        outletName: 'Test Outlet',
        outletCode: 'TEST001',
        ownerName: 'Test Owner',
      );

      final db = await databaseHelper.database;
      
      // Get a category ID for foreign key
      final categories = await db.query(TableNames.productCategories, limit: 1);
      final categoryId = categories.first['id'] as String;

      // CREATE product
      final productId = UuidV7Generator.generate();
      final now = DateHelpers.now();

      await db.insert(TableNames.products, {
        'id': productId,
        'category_id': categoryId,
        'sku': 'TEST-001',
        'name': 'Test Product',
        'description': 'Test product description',
        'unit': 'pcs',
        'cost_price': 5000.0,
        'selling_price': 7500.0,
        'current_stock': 100,
        'min_stock': 10,
        'track_stock': 1,
        'created_at': now,
        'updated_at': now,
      });

      // READ
      var products = await db.query(
        TableNames.products,
        where: 'id = ?',
        whereArgs: [productId],
      );
      expect(products.length, equals(1));
      expect(products.first['name'], equals('Test Product'));
      expect(products.first['sku'], equals('TEST-001'));

      // UPDATE
      await db.update(
        TableNames.products,
        {
          'name': 'Updated Product',
          'selling_price': 8000.0,
          'current_stock': 80,
          'updated_at': DateHelpers.now(),
        },
        where: 'id = ?',
        whereArgs: [productId],
      );

      products = await db.query(
        TableNames.products,
        where: 'id = ?',
        whereArgs: [productId],
      );
      expect(products.first['name'], equals('Updated Product'));
      expect(products.first['selling_price'], equals(8000.0));
      expect(products.first['current_stock'], equals(80));

      // Test stock adjustment
      await db.rawUpdate(
        'UPDATE ${TableNames.products} SET current_stock = current_stock + ?, updated_at = ? WHERE id = ?',
        [-5, DateHelpers.now(), productId],
      );

      products = await db.query(
        TableNames.products,
        where: 'id = ?',
        whereArgs: [productId],
      );
      expect(products.first['current_stock'], equals(75)); // 80 - 5

      // SOFT DELETE
      await db.update(
        TableNames.products,
        {
          'deleted_at': DateHelpers.now(),
          'updated_at': DateHelpers.now(),
        },
        where: 'id = ?',
        whereArgs: [productId],
      );

      // Verify soft delete
      final activeProducts = await db.query(
        TableNames.products,
        where: 'deleted_at IS NULL',
      );
      expect(activeProducts.any((p) => p['id'] == productId), false);
    });

    test('should create and manage transactions with items', () async {
      // Initialize default data
      await databaseHelper.initializeDefaultData(
        outletName: 'Test Outlet',
        outletCode: 'TEST001',
        ownerName: 'Test Owner',
      );

      final db = await databaseHelper.database;

      // Get required IDs
      final outlets = await db.query(TableNames.outlets, limit: 1);
      final outletId = outlets.first['id'] as String;
      
      final users = await db.query(TableNames.users, limit: 1);
      final cashierId = users.first['id'] as String;

      final categories = await db.query(TableNames.productCategories, limit: 1);
      final categoryId = categories.first['id'] as String;

      // Create test product
      final productId = UuidV7Generator.generate();
      await db.insert(TableNames.products, {
        'id': productId,
        'category_id': categoryId,
        'sku': 'TRANS-001',
        'name': 'Transaction Test Product',
        'selling_price': 10000.0,
        'current_stock': 50,
        'created_at': DateHelpers.now(),
        'updated_at': DateHelpers.now(),
      });

      // Create transaction
      await databaseHelper.transaction((txn) async {
        final transactionId = UuidV7Generator.generate();
        final now = DateHelpers.now();

        // Insert transaction
        await txn.insert(TableNames.transactions, {
          'id': transactionId,
          'outlet_id': outletId,
          'cashier_id': cashierId,
          'cashier_name_snapshot': 'Test Owner',
          'outlet_name_snapshot': 'Test Outlet',
          'outlet_code_snapshot': 'TEST001',
          'transaction_number': 'TXN-001',
          'transaction_date': now,
          'subtotal': 30000.0,
          'discount_amount': 0.0,
          'tax_amount': 3300.0,
          'total_amount': 33300.0,
          'paid_amount': 35000.0,
          'change_amount': 1700.0,
          'payment_method': PaymentMethod.cash,
          'status': TransactionStatus.completed,
          'created_at': now,
          'updated_at': now,
        });

        // Insert transaction items
        final itemId = UuidV7Generator.generate();
        await txn.insert(TableNames.transactionItems, {
          'id': itemId,
          'transaction_id': transactionId,
          'product_id': productId,
          'product_name_snapshot': 'Transaction Test Product',
          'product_sku_snapshot': 'TRANS-001',
          'product_unit_snapshot': 'pcs',
          'quantity': 3,
          'unit_price': 10000.0,
          'total_price': 30000.0,
          'created_at': now,
          'updated_at': now,
        });

        // Update product stock
        await txn.rawUpdate(
          'UPDATE ${TableNames.products} SET current_stock = current_stock - ?, updated_at = ? WHERE id = ?',
          [3, now, productId],
        );
      });

      // Verify transaction creation
      final transactions = await db.query(
        TableNames.transactions,
        where: 'transaction_number = ?',
        whereArgs: ['TXN-001'],
      );
      expect(transactions.length, equals(1));
      expect(transactions.first['total_amount'], equals(33300.0));

      // Verify transaction items
      final items = await db.query(
        TableNames.transactionItems,
        where: 'transaction_id = ?',
        whereArgs: [transactions.first['id']],
      );
      expect(items.length, equals(1));
      expect(items.first['quantity'], equals(3));

      // Verify stock update
      final products = await db.query(
        TableNames.products,
        where: 'id = ?',
        whereArgs: [productId],
      );
      expect(products.first['current_stock'], equals(47)); // 50 - 3
    });

    test('should handle database views correctly', () async {
      await databaseHelper.initializeDefaultData(
        outletName: 'Test Outlet',
        outletCode: 'TEST001',
        ownerName: 'Test Owner',
      );

      final db = await databaseHelper.database;

      // Test if views exist
      final result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='view' ORDER BY name"
      );
      
      final viewNames = result.map((row) => row['name'] as String).toList();
      expect(viewNames, contains('daily_sales_summary'));
      expect(viewNames, contains('top_selling_products'));
      expect(viewNames, contains('low_stock_products'));

      // Test view queries (should not error even with no data)
      final dailySales = await db.rawQuery('SELECT * FROM daily_sales_summary LIMIT 1');
      final topProducts = await db.rawQuery('SELECT * FROM top_selling_products LIMIT 1');
      final lowStock = await db.rawQuery('SELECT * FROM low_stock_products LIMIT 1');

      // Should execute without error (may be empty)
      expect(dailySales, isA<List<Map<String, dynamic>>>());
      expect(topProducts, isA<List<Map<String, dynamic>>>());
      expect(lowStock, isA<List<Map<String, dynamic>>>());
    });

    test('should handle foreign key constraints', () async {
      await databaseHelper.initializeDefaultData(
        outletName: 'Test Outlet',
        outletCode: 'TEST001',
        ownerName: 'Test Owner',
      );

      final db = await databaseHelper.database;

      // Try to insert product with invalid category_id
      expect(
        () async => await db.insert(TableNames.products, {
          'id': UuidV7Generator.generate(),
          'category_id': 'invalid-category-id',
          'sku': 'INVALID-001',
          'name': 'Invalid Product',
          'selling_price': 5000.0,
          'created_at': DateHelpers.now(),
          'updated_at': DateHelpers.now(),
        }),
        throwsA(isA<Exception>()),
      );
    });
  });
}