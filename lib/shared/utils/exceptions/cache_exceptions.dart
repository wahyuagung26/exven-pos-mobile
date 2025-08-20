/// Cache-specific exceptions and failures
/// 
/// This file contains exception classes specifically for cache operations,
/// storage issues, and offline data management problems.

import 'app_exceptions.dart';

/// Base cache exception
class CacheException extends AppException {
  const CacheException(
    super.message, {
    super.code,
    super.details,
    super.timestamp,
  });
  
  @override
  String toString() => 'CacheException: $message';
}

class CacheFailure extends Failure {
  const CacheFailure(
    super.message, {
    super.code,
    super.timestamp,
  });
}

/// Storage related exceptions
class StorageException extends CacheException {
  final String? storagePath;
  
  const StorageException(
    super.message, {
    this.storagePath,
    super.code,
    super.details,
    super.timestamp,
  });
  
  @override
  String toString() => 'StorageException: $message ${storagePath != null ? '(Path: $storagePath)' : ''}';
}

class StorageFailure extends CacheFailure {
  final String? storagePath;
  
  const StorageFailure(
    super.message, {
    this.storagePath,
    super.code,
    super.timestamp,
  });
}

/// Database related exceptions
class DatabaseException extends CacheException {
  final String? tableName;
  final String? operation;
  
  const DatabaseException(
    super.message, {
    this.tableName,
    this.operation,
    super.code,
    super.details,
    super.timestamp,
  });
  
  @override
  String toString() => 'DatabaseException: $message ${tableName != null ? '(Table: $tableName)' : ''}';
}

class DatabaseFailure extends CacheFailure {
  final String? tableName;
  final String? operation;
  
  const DatabaseFailure(
    super.message, {
    this.tableName,
    this.operation,
    super.code,
    super.timestamp,
  });
}

/// Cache key related exceptions
class CacheKeyException extends CacheException {
  final String cacheKey;
  
  const CacheKeyException(
    super.message, {
    required this.cacheKey,
    super.code,
    super.details,
    super.timestamp,
  });
  
  @override
  String toString() => 'CacheKeyException: $message (Key: $cacheKey)';
}

class CacheKeyFailure extends CacheFailure {
  final String cacheKey;
  
  const CacheKeyFailure(
    super.message, {
    required this.cacheKey,
    super.code,
    super.timestamp,
  });
}

/// Cache expiry related exceptions
class CacheExpiryException extends CacheException {
  final String cacheKey;
  final DateTime expiredAt;
  
  const CacheExpiryException(
    super.message, {
    required this.cacheKey,
    required this.expiredAt,
    super.code,
    super.details,
    super.timestamp,
  });
  
  @override
  String toString() => 'CacheExpiryException: $message (Key: $cacheKey, Expired: $expiredAt)';
}

class CacheExpiryFailure extends CacheFailure {
  final String cacheKey;
  final DateTime expiredAt;
  
  const CacheExpiryFailure(
    super.message, {
    required this.cacheKey,
    required this.expiredAt,
    super.code,
    super.timestamp,
  });
}

/// Sync related exceptions
class SyncException extends CacheException {
  final String? syncOperation;
  final int? pendingCount;
  
  const SyncException(
    super.message, {
    this.syncOperation,
    this.pendingCount,
    super.code,
    super.details,
    super.timestamp,
  });
  
  @override
  String toString() => 'SyncException: $message ${syncOperation != null ? '(Operation: $syncOperation)' : ''}';
}

class SyncFailure extends CacheFailure {
  final String? syncOperation;
  final int? pendingCount;
  
  const SyncFailure(
    super.message, {
    this.syncOperation,
    this.pendingCount,
    super.code,
    super.timestamp,
  });
}

/// Offline data exceptions
class OfflineDataException extends CacheException {
  final String? dataType;
  final String? lastSyncAt;
  
  const OfflineDataException(
    super.message, {
    this.dataType,
    this.lastSyncAt,
    super.code,
    super.details,
    super.timestamp,
  });
  
  @override
  String toString() => 'OfflineDataException: $message ${dataType != null ? '(Type: $dataType)' : ''}';
}

class OfflineDataFailure extends CacheFailure {
  final String? dataType;
  final String? lastSyncAt;
  
  const OfflineDataFailure(
    super.message, {
    this.dataType,
    this.lastSyncAt,
    super.code,
    super.timestamp,
  });
}

/// Storage quota exceptions
class StorageQuotaException extends StorageException {
  final int currentSize;
  final int maxSize;
  
  const StorageQuotaException(
    super.message, {
    required this.currentSize,
    required this.maxSize,
    super.storagePath,
    super.code,
    super.details,
    super.timestamp,
  });
  
  @override
  String toString() => 'StorageQuotaException: $message (${currentSize}/${maxSize} bytes)';
}

class StorageQuotaFailure extends StorageFailure {
  final int currentSize;
  final int maxSize;
  
  const StorageQuotaFailure(
    super.message, {
    required this.currentSize,
    required this.maxSize,
    super.storagePath,
    super.code,
    super.timestamp,
  });
}

/// Cache corruption exceptions
class CacheCorruptionException extends CacheException {
  final String corruptedData;
  final String? expectedFormat;
  
  const CacheCorruptionException(
    super.message, {
    required this.corruptedData,
    this.expectedFormat,
    super.code,
    super.details,
    super.timestamp,
  });
  
  @override
  String toString() => 'CacheCorruptionException: $message';
}

class CacheCorruptionFailure extends CacheFailure {
  final String corruptedData;
  final String? expectedFormat;
  
  const CacheCorruptionFailure(
    super.message, {
    required this.corruptedData,
    this.expectedFormat,
    super.code,
    super.timestamp,
  });
}

/// Migration exceptions
class MigrationException extends DatabaseException {
  final int fromVersion;
  final int toVersion;
  
  const MigrationException(
    super.message, {
    required this.fromVersion,
    required this.toVersion,
    super.tableName,
    super.operation,
    super.code,
    super.details,
    super.timestamp,
  });
  
  @override
  String toString() => 'MigrationException: $message (v$fromVersion -> v$toVersion)';
}

class MigrationFailure extends DatabaseFailure {
  final int fromVersion;
  final int toVersion;
  
  const MigrationFailure(
    super.message, {
    required this.fromVersion,
    required this.toVersion,
    super.tableName,
    super.operation,
    super.code,
    super.timestamp,
  });
}

/// Predefined cache exceptions with Indonesian messages
class CommonCacheExceptions {
  // Storage errors
  static const storageNotAvailable = StorageException(
    'Penyimpanan tidak tersedia',
    code: 'STORAGE_NOT_AVAILABLE',
  );
  
  static const storagePermissionDenied = StorageException(
    'Izin akses penyimpanan ditolak',
    code: 'STORAGE_PERMISSION_DENIED',
  );
  
  static const storageFull = StorageQuotaException(
    'Penyimpanan penuh. Silakan hapus beberapa data',
    currentSize: 0,
    maxSize: 0,
    code: 'STORAGE_FULL',
  );
  
  // Database errors
  static const databaseCorrupted = DatabaseException(
    'Database rusak. Aplikasi akan melakukan reset data',
    code: 'DATABASE_CORRUPTED',
  );
  
  static const databaseLocked = DatabaseException(
    'Database sedang digunakan oleh proses lain',
    code: 'DATABASE_LOCKED',
  );
  
  static const databaseMigrationFailed = MigrationException(
    'Gagal melakukan migrasi database',
    fromVersion: 0,
    toVersion: 1,
    code: 'MIGRATION_FAILED',
  );
  
  // Cache errors
  static const cacheExpired = CacheExpiryException(
    'Data cache sudah kadaluarsa',
    cacheKey: '',
    expiredAt: DateTime(2020),
    code: 'CACHE_EXPIRED',
  );
  
  static CacheKeyException cacheKeyNotFound(String key) => CacheKeyException(
    'Data tidak ditemukan di cache',
    cacheKey: key,
    code: 'CACHE_KEY_NOT_FOUND',
  );
  
  static CacheCorruptionException cacheCorrupted(String data) => CacheCorruptionException(
    'Data cache rusak dan tidak dapat dibaca',
    corruptedData: data,
    code: 'CACHE_CORRUPTED',
  );
  
  // Sync errors
  static const syncInProgress = SyncException(
    'Sinkronisasi sedang berlangsung',
    code: 'SYNC_IN_PROGRESS',
  );
  
  static const syncConflict = SyncException(
    'Terjadi konflik saat sinkronisasi data',
    code: 'SYNC_CONFLICT',
  );
  
  static const syncTimeout = SyncException(
    'Sinkronisasi timeout',
    code: 'SYNC_TIMEOUT',
  );
  
  static SyncException syncFailed(String operation) => SyncException(
    'Gagal melakukan sinkronisasi',
    syncOperation: operation,
    code: 'SYNC_FAILED',
  );
  
  // Offline data errors
  static const offlineDataNotAvailable = OfflineDataException(
    'Data offline tidak tersedia. Periksa koneksi internet Anda',
    code: 'OFFLINE_DATA_NOT_AVAILABLE',
  );
  
  static const offlineDataStale = OfflineDataException(
    'Data offline sudah usang. Perlu sinkronisasi',
    code: 'OFFLINE_DATA_STALE',
  );
  
  static OfflineDataException offlineDataOutdated(String dataType, String lastSync) =>
      OfflineDataException(
        'Data $dataType sudah tidak up-to-date',
        dataType: dataType,
        lastSyncAt: lastSync,
        code: 'OFFLINE_DATA_OUTDATED',
      );
}

/// Predefined cache failures
class CommonCacheFailures {
  static const storageFailure = StorageFailure(
    'Gagal mengakses penyimpanan',
    code: 'STORAGE_FAILED',
  );
  
  static const databaseFailure = DatabaseFailure(
    'Gagal mengakses database',
    code: 'DATABASE_FAILED',
  );
  
  static const cacheFailure = CacheFailure(
    'Gagal mengakses cache',
    code: 'CACHE_FAILED',
  );
  
  static const syncFailure = SyncFailure(
    'Sinkronisasi gagal',
    code: 'SYNC_FAILED',
  );
  
  static const offlineDataFailure = OfflineDataFailure(
    'Gagal mengakses data offline',
    code: 'OFFLINE_DATA_FAILED',
  );
  
  static const migrationFailure = MigrationFailure(
    'Migrasi database gagal',
    fromVersion: 0,
    toVersion: 1,
    code: 'MIGRATION_FAILED',
  );
  
  static const corruptionFailure = CacheCorruptionFailure(
    'Data cache rusak',
    corruptedData: '',
    code: 'CORRUPTION_FAILED',
  );
  
  static const quotaFailure = StorageQuotaFailure(
    'Kuota penyimpanan penuh',
    currentSize: 0,
    maxSize: 0,
    code: 'QUOTA_EXCEEDED',
  );
}

/// Cache exception utility class
class CacheExceptionHandler {
  /// Handle generic cache operation errors
  static CacheException handleCacheError(dynamic error, String operation) {
    if (error is CacheException) {
      return error;
    }
    
    String message = 'Terjadi kesalahan saat $operation';
    
    if (error is StateError) {
      return CacheException(
        'Cache dalam keadaan tidak valid: ${error.message}',
        code: 'INVALID_CACHE_STATE',
      );
    }
    
    if (error is FormatException) {
      return CacheCorruptionException(
        'Format data cache tidak valid',
        corruptedData: error.source?.toString() ?? '',
        code: 'INVALID_CACHE_FORMAT',
      );
    }
    
    if (error.toString().contains('disk') || error.toString().contains('storage')) {
      return StorageException(
        message,
        code: 'STORAGE_ERROR',
        details: error.toString(),
      );
    }
    
    if (error.toString().contains('database') || error.toString().contains('sql')) {
      return DatabaseException(
        message,
        code: 'DATABASE_ERROR',
        details: error.toString(),
      );
    }
    
    return CacheException(
      message,
      code: 'UNKNOWN_CACHE_ERROR',
      details: error.toString(),
    );
  }
  
  /// Convert cache exception to failure
  static CacheFailure toFailure(CacheException exception) {
    if (exception is StorageException) {
      if (exception is StorageQuotaException) {
        return StorageQuotaFailure(
          exception.message,
          currentSize: exception.currentSize,
          maxSize: exception.maxSize,
          storagePath: exception.storagePath,
          code: exception.code,
        );
      } else {
        return StorageFailure(
          exception.message,
          storagePath: exception.storagePath,
          code: exception.code,
        );
      }
    } else if (exception is DatabaseException) {
      if (exception is MigrationException) {
        return MigrationFailure(
          exception.message,
          fromVersion: exception.fromVersion,
          toVersion: exception.toVersion,
          tableName: exception.tableName,
          operation: exception.operation,
          code: exception.code,
        );
      } else {
        return DatabaseFailure(
          exception.message,
          tableName: exception.tableName,
          operation: exception.operation,
          code: exception.code,
        );
      }
    } else if (exception is CacheKeyException) {
      return CacheKeyFailure(
        exception.message,
        cacheKey: exception.cacheKey,
        code: exception.code,
      );
    } else if (exception is CacheExpiryException) {
      return CacheExpiryFailure(
        exception.message,
        cacheKey: exception.cacheKey,
        expiredAt: exception.expiredAt,
        code: exception.code,
      );
    } else if (exception is SyncException) {
      return SyncFailure(
        exception.message,
        syncOperation: exception.syncOperation,
        pendingCount: exception.pendingCount,
        code: exception.code,
      );
    } else if (exception is OfflineDataException) {
      return OfflineDataFailure(
        exception.message,
        dataType: exception.dataType,
        lastSyncAt: exception.lastSyncAt,
        code: exception.code,
      );
    } else if (exception is CacheCorruptionException) {
      return CacheCorruptionFailure(
        exception.message,
        corruptedData: exception.corruptedData,
        expectedFormat: exception.expectedFormat,
        code: exception.code,
      );
    } else {
      return CacheFailure(
        exception.message,
        code: exception.code,
      );
    }
  }
}