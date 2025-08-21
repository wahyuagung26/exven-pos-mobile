library table_definitions;

/// Central export file for all table definitions
/// 
/// Provides a single import point for all database table definitions
/// and common database utilities.

export 'outlets_table.dart';
export 'products_table.dart';
export 'transactions_table.dart';

/// Database table names constants
class TableNames {
  static const String outlets = 'outlets';
  static const String users = 'users';
  static const String productCategories = 'product_categories';
  static const String products = 'products';
  static const String customers = 'customers';
  static const String transactions = 'transactions';
  static const String transactionItems = 'transaction_items';
  static const String transactionPayments = 'transaction_payments';
  static const String cashShifts = 'cash_shifts';
  static const String expenses = 'expenses';
  static const String syncQueue = 'sync_queue';
  static const String syncHistory = 'sync_history';
  static const String appSettings = 'app_settings';
  static const String schemaVersion = 'schema_version';

  /// Get all table names
  static List<String> get all => [
    outlets,
    users,
    productCategories,
    products,
    customers,
    transactions,
    transactionItems,
    transactionPayments,
    cashShifts,
    expenses,
    syncQueue,
    syncHistory,
    appSettings,
    schemaVersion,
  ];
}

/// Common column names used across tables
class CommonColumns {
  static const String id = 'id';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
  static const String deletedAt = 'deleted_at';
  
  /// Base audit columns for all entities
  static List<String> get auditColumns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
  ];
}

/// Database utilities for common operations
class DatabaseUtils {
  /// Generate a WHERE clause for active (non-deleted) records
  static String activeWhereClause(String tableName) {
    return '$tableName.${CommonColumns.deletedAt} IS NULL';
  }

  /// Generate ORDER BY clause for chronological ordering (newest first)
  static String chronologicalOrderBy(String tableName) {
    return '$tableName.${CommonColumns.createdAt} DESC';
  }

  /// Generate ORDER BY clause for last updated (newest first)  
  static String lastUpdatedOrderBy(String tableName) {
    return '$tableName.${CommonColumns.updatedAt} DESC';
  }

  /// Generate a standard SELECT query for active records
  static String selectActiveQuery(String tableName, {String? orderBy}) {
    final order = orderBy ?? chronologicalOrderBy(tableName);
    return '''
      SELECT * FROM $tableName 
      WHERE ${activeWhereClause(tableName)} 
      ORDER BY $order
    ''';
  }

  /// Generate a standard SELECT by ID query for active records
  static String selectByIdQuery(String tableName) {
    return '''
      SELECT * FROM $tableName 
      WHERE ${CommonColumns.id} = ? AND ${activeWhereClause(tableName)}
    ''';
  }

  /// Generate a standard soft delete query
  static String softDeleteQuery(String tableName) {
    return '''
      UPDATE $tableName SET 
        ${CommonColumns.deletedAt} = ?, 
        ${CommonColumns.updatedAt} = ? 
      WHERE ${CommonColumns.id} = ?
    ''';
  }

  /// Generate a standard count query for active records
  static String countActiveQuery(String tableName) {
    return '''
      SELECT COUNT(*) as count 
      FROM $tableName 
      WHERE ${activeWhereClause(tableName)}
    ''';
  }

  /// Generate a search query with LIKE clause
  static String searchQuery(String tableName, String searchColumn) {
    return '''
      SELECT * FROM $tableName 
      WHERE $searchColumn LIKE ? AND ${activeWhereClause(tableName)}
      ORDER BY $searchColumn ASC
    ''';
  }
}

/// Query builders for complex operations
class QueryBuilder {
  final String _tableName;
  final List<String> _selectColumns = ['*'];
  final List<String> _whereConditions = [];
  final List<String> _orderByColumns = [];
  String? _limit;

  QueryBuilder(this._tableName);

  /// Add columns to SELECT
  QueryBuilder select(List<String> columns) {
    _selectColumns.clear();
    _selectColumns.addAll(columns);
    return this;
  }

  /// Add WHERE condition
  QueryBuilder where(String condition) {
    _whereConditions.add(condition);
    return this;
  }

  /// Add WHERE condition for active records only
  QueryBuilder whereActive() {
    return where(DatabaseUtils.activeWhereClause(_tableName));
  }

  /// Add ORDER BY column
  QueryBuilder orderBy(String column, {bool ascending = false}) {
    final direction = ascending ? 'ASC' : 'DESC';
    _orderByColumns.add('$column $direction');
    return this;
  }

  /// Add chronological ordering (newest first)
  QueryBuilder orderByNewest() {
    return orderBy(CommonColumns.createdAt, ascending: false);
  }

  /// Add LIMIT clause
  QueryBuilder limit(int count) {
    _limit = count.toString();
    return this;
  }

  /// Build the final SQL query
  String build() {
    final query = StringBuffer();
    
    // SELECT clause
    query.write('SELECT ${_selectColumns.join(', ')} FROM $_tableName');
    
    // WHERE clause
    if (_whereConditions.isNotEmpty) {
      query.write(' WHERE ${_whereConditions.join(' AND ')}');
    }
    
    // ORDER BY clause
    if (_orderByColumns.isNotEmpty) {
      query.write(' ORDER BY ${_orderByColumns.join(', ')}');
    }
    
    // LIMIT clause
    if (_limit != null) {
      query.write(' LIMIT $_limit');
    }
    
    return query.toString();
  }
}

/// Transaction status enum values
class TransactionStatus {
  static const String completed = 'completed';
  static const String cancelled = 'cancelled';
  static const String pending = 'pending';
  
  static List<String> get all => [completed, cancelled, pending];
}

/// Payment method enum values  
class PaymentMethod {
  static const String cash = 'cash';
  static const String card = 'card';
  static const String transfer = 'transfer';
  static const String ewallet = 'ewallet';
  
  static List<String> get all => [cash, card, transfer, ewallet];
}

/// User role enum values
class UserRole {
  static const String owner = 'owner';
  static const String manager = 'manager';
  static const String cashier = 'cashier';
  
  static List<String> get all => [owner, manager, cashier];
}

/// Expense category enum values
class ExpenseCategory {
  static const String operational = 'operasional';
  static const String rawMaterials = 'bahan_baku';
  static const String transport = 'transport';
  static const String marketing = 'marketing';
  static const String utilities = 'utilitas';
  static const String maintenance = 'maintenance';
  static const String other = 'lainnya';
  
  static List<String> get all => [
    operational,
    rawMaterials,
    transport,
    marketing,
    utilities,
    maintenance,
    other,
  ];
}

/// Cash shift status enum values
class CashShiftStatus {
  static const String open = 'open';
  static const String closed = 'closed';
  
  static List<String> get all => [open, closed];
}