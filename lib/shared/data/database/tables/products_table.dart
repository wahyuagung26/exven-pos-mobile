/// Products table definition and operations
/// 
/// Manages product information for the POS system.
class ProductsTable {
  static const String tableName = 'products';

  // Column names
  static const String columnId = 'id';
  static const String columnCategoryId = 'category_id';
  static const String columnSku = 'sku';
  static const String columnBarcode = 'barcode';
  static const String columnName = 'name';
  static const String columnDescription = 'description';
  static const String columnUnit = 'unit';
  static const String columnCostPrice = 'cost_price';
  static const String columnSellingPrice = 'selling_price';
  static const String columnCurrentStock = 'current_stock';
  static const String columnMinStock = 'min_stock';
  static const String columnTrackStock = 'track_stock';
  static const String columnCreatedAt = 'created_at';
  static const String columnUpdatedAt = 'updated_at';
  static const String columnDeletedAt = 'deleted_at';

  // SQL queries
  static const String createTable = '''
    CREATE TABLE $tableName (
      $columnId TEXT PRIMARY KEY,
      $columnCategoryId TEXT,
      $columnSku TEXT NOT NULL UNIQUE,
      $columnBarcode TEXT,
      $columnName TEXT NOT NULL,
      $columnDescription TEXT,
      $columnUnit TEXT DEFAULT 'pcs',
      $columnCostPrice REAL DEFAULT 0.00,
      $columnSellingPrice REAL NOT NULL,
      $columnCurrentStock INTEGER DEFAULT 0,
      $columnMinStock INTEGER DEFAULT 0,
      $columnTrackStock INTEGER DEFAULT 1,
      $columnCreatedAt INTEGER DEFAULT (strftime('%s', 'now') * 1000),
      $columnUpdatedAt INTEGER DEFAULT (strftime('%s', 'now') * 1000),
      $columnDeletedAt INTEGER DEFAULT NULL,
      
      FOREIGN KEY ($columnCategoryId) REFERENCES product_categories(id)
    )
  ''';

  static const String selectAll = '''
    SELECT * FROM $tableName WHERE $columnDeletedAt IS NULL ORDER BY $columnName ASC
  ''';

  static const String selectById = '''
    SELECT * FROM $tableName WHERE $columnId = ? AND $columnDeletedAt IS NULL
  ''';

  static const String selectBySku = '''
    SELECT * FROM $tableName WHERE $columnSku = ? AND $columnDeletedAt IS NULL
  ''';

  static const String selectByBarcode = '''
    SELECT * FROM $tableName WHERE $columnBarcode = ? AND $columnDeletedAt IS NULL
  ''';

  static const String selectByCategory = '''
    SELECT * FROM $tableName WHERE $columnCategoryId = ? AND $columnDeletedAt IS NULL ORDER BY $columnName ASC
  ''';

  static const String searchByName = '''
    SELECT * FROM $tableName 
    WHERE $columnName LIKE ? AND $columnDeletedAt IS NULL 
    ORDER BY $columnName ASC
  ''';

  static const String selectLowStock = '''
    SELECT * FROM $tableName 
    WHERE $columnTrackStock = 1 
      AND $columnCurrentStock <= $columnMinStock 
      AND $columnDeletedAt IS NULL
    ORDER BY ($columnMinStock - $columnCurrentStock) DESC
  ''';

  static const String insert = '''
    INSERT INTO $tableName (
      $columnId, $columnCategoryId, $columnSku, $columnBarcode,
      $columnName, $columnDescription, $columnUnit, $columnCostPrice,
      $columnSellingPrice, $columnCurrentStock, $columnMinStock, $columnTrackStock,
      $columnCreatedAt, $columnUpdatedAt
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
  ''';

  static const String update = '''
    UPDATE $tableName SET
      $columnCategoryId = ?, $columnSku = ?, $columnBarcode = ?,
      $columnName = ?, $columnDescription = ?, $columnUnit = ?,
      $columnCostPrice = ?, $columnSellingPrice = ?, $columnMinStock = ?,
      $columnTrackStock = ?, $columnUpdatedAt = ?
    WHERE $columnId = ? AND $columnDeletedAt IS NULL
  ''';

  static const String updateStock = '''
    UPDATE $tableName SET 
      $columnCurrentStock = ?, $columnUpdatedAt = ?
    WHERE $columnId = ? AND $columnDeletedAt IS NULL
  ''';

  static const String adjustStock = '''
    UPDATE $tableName SET 
      $columnCurrentStock = $columnCurrentStock + ?, $columnUpdatedAt = ?
    WHERE $columnId = ? AND $columnDeletedAt IS NULL
  ''';

  static const String softDelete = '''
    UPDATE $tableName SET 
      $columnDeletedAt = ?, $columnUpdatedAt = ? 
    WHERE $columnId = ?
  ''';

  static const String countActive = '''
    SELECT COUNT(*) as count FROM $tableName WHERE $columnDeletedAt IS NULL
  ''';

  static const String countLowStock = '''
    SELECT COUNT(*) as count FROM $tableName 
    WHERE $columnTrackStock = 1 
      AND $columnCurrentStock <= $columnMinStock 
      AND $columnDeletedAt IS NULL
  ''';

  /// Indexes for performance optimization
  static const List<String> indexes = [
    'CREATE INDEX idx_products_sku ON $tableName($columnSku) WHERE $columnDeletedAt IS NULL',
    'CREATE INDEX idx_products_barcode ON $tableName($columnBarcode) WHERE $columnDeletedAt IS NULL',
    'CREATE INDEX idx_products_name ON $tableName($columnName) WHERE $columnDeletedAt IS NULL',
    'CREATE INDEX idx_products_category ON $tableName($columnCategoryId) WHERE $columnDeletedAt IS NULL',
  ];

  /// Get all column names as a list
  static List<String> get allColumns => [
    columnId,
    columnCategoryId,
    columnSku,
    columnBarcode,
    columnName,
    columnDescription,
    columnUnit,
    columnCostPrice,
    columnSellingPrice,
    columnCurrentStock,
    columnMinStock,
    columnTrackStock,
    columnCreatedAt,
    columnUpdatedAt,
    columnDeletedAt,
  ];
}