/// Transactions table definition and operations
/// 
/// Manages transaction information with snapshot data for offline reliability.
class TransactionsTable {
  static const String tableName = 'transactions';

  // Column names
  static const String columnId = 'id';
  static const String columnOutletId = 'outlet_id';
  static const String columnCashierId = 'cashier_id';
  static const String columnCustomerId = 'customer_id';
  static const String columnCustomerNameSnapshot = 'customer_name_snapshot';
  static const String columnCustomerPhoneSnapshot = 'customer_phone_snapshot';
  static const String columnCashierNameSnapshot = 'cashier_name_snapshot';
  static const String columnOutletNameSnapshot = 'outlet_name_snapshot';
  static const String columnOutletCodeSnapshot = 'outlet_code_snapshot';
  static const String columnTransactionNumber = 'transaction_number';
  static const String columnTransactionDate = 'transaction_date';
  static const String columnSubtotal = 'subtotal';
  static const String columnDiscountAmount = 'discount_amount';
  static const String columnTaxAmount = 'tax_amount';
  static const String columnTotalAmount = 'total_amount';
  static const String columnPaidAmount = 'paid_amount';
  static const String columnChangeAmount = 'change_amount';
  static const String columnPaymentMethod = 'payment_method';
  static const String columnStatus = 'status';
  static const String columnNotes = 'notes';
  static const String columnSyncedToCloud = 'synced_to_cloud';
  static const String columnCloudTransactionId = 'cloud_transaction_id';
  static const String columnCreatedAt = 'created_at';
  static const String columnUpdatedAt = 'updated_at';
  static const String columnDeletedAt = 'deleted_at';

  // SQL queries
  static const String createTable = '''
    CREATE TABLE $tableName (
      $columnId TEXT PRIMARY KEY,
      $columnOutletId TEXT NOT NULL,
      $columnCashierId TEXT NOT NULL,
      $columnCustomerId TEXT DEFAULT NULL,
      $columnCustomerNameSnapshot TEXT,
      $columnCustomerPhoneSnapshot TEXT,
      $columnCashierNameSnapshot TEXT NOT NULL,
      $columnOutletNameSnapshot TEXT NOT NULL,
      $columnOutletCodeSnapshot TEXT NOT NULL,
      $columnTransactionNumber TEXT NOT NULL UNIQUE,
      $columnTransactionDate INTEGER DEFAULT (strftime('%s', 'now') * 1000),
      $columnSubtotal REAL NOT NULL,
      $columnDiscountAmount REAL DEFAULT 0.00,
      $columnTaxAmount REAL DEFAULT 0.00,
      $columnTotalAmount REAL NOT NULL,
      $columnPaidAmount REAL NOT NULL,
      $columnChangeAmount REAL DEFAULT 0.00,
      $columnPaymentMethod TEXT NOT NULL,
      $columnStatus TEXT DEFAULT 'completed',
      $columnNotes TEXT,
      $columnSyncedToCloud INTEGER DEFAULT 0,
      $columnCloudTransactionId TEXT DEFAULT NULL,
      $columnCreatedAt INTEGER DEFAULT (strftime('%s', 'now') * 1000),
      $columnUpdatedAt INTEGER DEFAULT (strftime('%s', 'now') * 1000),
      $columnDeletedAt INTEGER DEFAULT NULL,
      
      FOREIGN KEY ($columnOutletId) REFERENCES outlets(id),
      FOREIGN KEY ($columnCashierId) REFERENCES users(id),
      FOREIGN KEY ($columnCustomerId) REFERENCES customers(id)
    )
  ''';

  static const String selectAll = '''
    SELECT * FROM $tableName WHERE $columnDeletedAt IS NULL ORDER BY $columnTransactionDate DESC
  ''';

  static const String selectById = '''
    SELECT * FROM $tableName WHERE $columnId = ? AND $columnDeletedAt IS NULL
  ''';

  static const String selectByNumber = '''
    SELECT * FROM $tableName WHERE $columnTransactionNumber = ? AND $columnDeletedAt IS NULL
  ''';

  static const String selectByCashier = '''
    SELECT * FROM $tableName 
    WHERE $columnCashierId = ? AND $columnDeletedAt IS NULL 
    ORDER BY $columnTransactionDate DESC
  ''';

  static const String selectByDate = '''
    SELECT * FROM $tableName 
    WHERE $columnTransactionDate >= ? AND $columnTransactionDate <= ? 
      AND $columnDeletedAt IS NULL
    ORDER BY $columnTransactionDate DESC
  ''';

  static const String selectToday = '''
    SELECT * FROM $tableName 
    WHERE DATE($columnTransactionDate / 1000, 'unixepoch', 'localtime') = DATE('now', 'localtime')
      AND $columnDeletedAt IS NULL
    ORDER BY $columnTransactionDate DESC
  ''';

  static const String selectByStatus = '''
    SELECT * FROM $tableName 
    WHERE $columnStatus = ? AND $columnDeletedAt IS NULL
    ORDER BY $columnTransactionDate DESC
  ''';

  static const String selectUnsynced = '''
    SELECT * FROM $tableName 
    WHERE $columnSyncedToCloud = 0 AND $columnDeletedAt IS NULL
    ORDER BY $columnTransactionDate ASC
  ''';

  static const String insert = '''
    INSERT INTO $tableName (
      $columnId, $columnOutletId, $columnCashierId, $columnCustomerId,
      $columnCustomerNameSnapshot, $columnCustomerPhoneSnapshot, 
      $columnCashierNameSnapshot, $columnOutletNameSnapshot, $columnOutletCodeSnapshot,
      $columnTransactionNumber, $columnTransactionDate, $columnSubtotal,
      $columnDiscountAmount, $columnTaxAmount, $columnTotalAmount,
      $columnPaidAmount, $columnChangeAmount, $columnPaymentMethod,
      $columnStatus, $columnNotes, $columnCreatedAt, $columnUpdatedAt
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
  ''';

  static const String update = '''
    UPDATE $tableName SET
      $columnCustomerId = ?, $columnCustomerNameSnapshot = ?, 
      $columnCustomerPhoneSnapshot = ?, $columnSubtotal = ?,
      $columnDiscountAmount = ?, $columnTaxAmount = ?, $columnTotalAmount = ?,
      $columnPaidAmount = ?, $columnChangeAmount = ?, $columnPaymentMethod = ?,
      $columnStatus = ?, $columnNotes = ?, $columnUpdatedAt = ?
    WHERE $columnId = ? AND $columnDeletedAt IS NULL
  ''';

  static const String markSynced = '''
    UPDATE $tableName SET 
      $columnSyncedToCloud = 1, $columnCloudTransactionId = ?, $columnUpdatedAt = ?
    WHERE $columnId = ? AND $columnDeletedAt IS NULL
  ''';

  static const String softDelete = '''
    UPDATE $tableName SET 
      $columnDeletedAt = ?, $columnUpdatedAt = ? 
    WHERE $columnId = ?
  ''';

  // Aggregation queries
  static const String sumTodayByPaymentMethod = '''
    SELECT 
      $columnPaymentMethod,
      SUM($columnTotalAmount) as total_amount,
      COUNT(*) as transaction_count
    FROM $tableName 
    WHERE DATE($columnTransactionDate / 1000, 'unixepoch', 'localtime') = DATE('now', 'localtime')
      AND $columnStatus = 'completed'
      AND $columnDeletedAt IS NULL
    GROUP BY $columnPaymentMethod
  ''';

  static const String sumByDateRange = '''
    SELECT 
      SUM($columnTotalAmount) as total_amount,
      COUNT(*) as transaction_count,
      AVG($columnTotalAmount) as average_amount
    FROM $tableName 
    WHERE $columnTransactionDate >= ? AND $columnTransactionDate <= ?
      AND $columnStatus = 'completed'
      AND $columnDeletedAt IS NULL
  ''';

  /// Indexes for performance optimization
  static const List<String> indexes = [
    'CREATE INDEX idx_transactions_date ON $tableName($columnTransactionDate) WHERE $columnDeletedAt IS NULL',
    'CREATE INDEX idx_transactions_cashier ON $tableName($columnCashierId) WHERE $columnDeletedAt IS NULL',
    'CREATE INDEX idx_transactions_status ON $tableName($columnStatus) WHERE $columnDeletedAt IS NULL',
    'CREATE INDEX idx_transactions_sync ON $tableName($columnSyncedToCloud) WHERE $columnDeletedAt IS NULL',
  ];

  /// Get all column names as a list
  static List<String> get allColumns => [
    columnId,
    columnOutletId,
    columnCashierId,
    columnCustomerId,
    columnCustomerNameSnapshot,
    columnCustomerPhoneSnapshot,
    columnCashierNameSnapshot,
    columnOutletNameSnapshot,
    columnOutletCodeSnapshot,
    columnTransactionNumber,
    columnTransactionDate,
    columnSubtotal,
    columnDiscountAmount,
    columnTaxAmount,
    columnTotalAmount,
    columnPaidAmount,
    columnChangeAmount,
    columnPaymentMethod,
    columnStatus,
    columnNotes,
    columnSyncedToCloud,
    columnCloudTransactionId,
    columnCreatedAt,
    columnUpdatedAt,
    columnDeletedAt,
  ];
}