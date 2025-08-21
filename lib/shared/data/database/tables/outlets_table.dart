/// Outlets table definition and operations
/// 
/// Manages outlet information for the POS system.
/// Each device/app installation represents a single outlet.
class OutletsTable {
  static const String tableName = 'outlets';

  // Column names
  static const String columnId = 'id';
  static const String columnName = 'name';
  static const String columnCode = 'code';
  static const String columnDescription = 'description';
  static const String columnAddress = 'address';
  static const String columnCity = 'city';
  static const String columnProvince = 'province';
  static const String columnPostalCode = 'postal_code';
  static const String columnPhone = 'phone';
  static const String columnEmail = 'email';
  static const String columnSettings = 'settings';
  static const String columnCreatedAt = 'created_at';
  static const String columnUpdatedAt = 'updated_at';
  static const String columnDeletedAt = 'deleted_at';

  // SQL queries
  static const String createTable = '''
    CREATE TABLE $tableName (
      $columnId TEXT PRIMARY KEY,
      $columnName TEXT NOT NULL,
      $columnCode TEXT NOT NULL UNIQUE,
      $columnDescription TEXT,
      $columnAddress TEXT,
      $columnCity TEXT,
      $columnProvince TEXT,
      $columnPostalCode TEXT,
      $columnPhone TEXT,
      $columnEmail TEXT,
      $columnSettings TEXT,
      $columnCreatedAt INTEGER DEFAULT (strftime('%s', 'now') * 1000),
      $columnUpdatedAt INTEGER DEFAULT (strftime('%s', 'now') * 1000),
      $columnDeletedAt INTEGER DEFAULT NULL
    )
  ''';

  static const String selectAll = '''
    SELECT * FROM $tableName WHERE $columnDeletedAt IS NULL ORDER BY $columnCreatedAt DESC
  ''';

  static const String selectById = '''
    SELECT * FROM $tableName WHERE $columnId = ? AND $columnDeletedAt IS NULL
  ''';

  static const String selectByCode = '''
    SELECT * FROM $tableName WHERE $columnCode = ? AND $columnDeletedAt IS NULL
  ''';

  static const String insert = '''
    INSERT INTO $tableName (
      $columnId, $columnName, $columnCode, $columnDescription,
      $columnAddress, $columnCity, $columnProvince, $columnPostalCode,
      $columnPhone, $columnEmail, $columnSettings,
      $columnCreatedAt, $columnUpdatedAt
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
  ''';

  static const String update = '''
    UPDATE $tableName SET
      $columnName = ?, $columnDescription = ?, $columnAddress = ?,
      $columnCity = ?, $columnProvince = ?, $columnPostalCode = ?,
      $columnPhone = ?, $columnEmail = ?, $columnSettings = ?,
      $columnUpdatedAt = ?
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

  /// Get all column names as a list
  static List<String> get allColumns => [
    columnId,
    columnName,
    columnCode,
    columnDescription,
    columnAddress,
    columnCity,
    columnProvince,
    columnPostalCode,
    columnPhone,
    columnEmail,
    columnSettings,
    columnCreatedAt,
    columnUpdatedAt,
    columnDeletedAt,
  ];
}