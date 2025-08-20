import 'package:dartz/dartz.dart';

import '../entities/pagination_entity.dart';

/// Type definitions for common return types
typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureEitherVoid = Future<Either<Failure, void>>;

/// Base failure class for error handling
abstract class Failure {
  /// Error message
  final String message;
  
  /// Error code if available
  final String? code;
  
  /// Stack trace for debugging
  final StackTrace? stackTrace;
  
  /// Additional error details
  final Map<String, dynamic>? details;

  /// Creates a failure
  const Failure({
    required this.message,
    this.code,
    this.stackTrace,
    this.details,
  });

  @override
  String toString() => message;
}

/// Network-related failures
class NetworkFailure extends Failure {
  /// HTTP status code if available
  final int? statusCode;

  /// Creates a network failure
  const NetworkFailure(
    String message, {
    this.statusCode,
    String? code,
    StackTrace? stackTrace,
    Map<String, dynamic>? details,
  }) : super(
          message: message,
          code: code,
          stackTrace: stackTrace,
          details: details,
        );
}

/// Server-related failures
class ServerFailure extends Failure {
  /// HTTP status code
  final int statusCode;
  
  /// Server error response
  final Map<String, dynamic>? response;

  /// Creates a server failure
  const ServerFailure(
    String message, {
    required this.statusCode,
    this.response,
    String? code,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          code: code,
          stackTrace: stackTrace,
          details: response,
        );
}

/// Cache-related failures
class CacheFailure extends Failure {
  /// Creates a cache failure
  const CacheFailure(
    String message, {
    String? code,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          code: code,
          stackTrace: stackTrace,
        );
}

/// Validation failures
class ValidationFailure extends Failure {
  /// Field-specific validation errors
  final Map<String, List<String>>? fieldErrors;

  /// Creates a validation failure
  const ValidationFailure(
    String message, {
    this.fieldErrors,
    String? code,
  }) : super(
          message: message,
          code: code,
          details: fieldErrors,
        );
}

/// Authentication failures
class AuthenticationFailure extends Failure {
  /// Creates an authentication failure
  const AuthenticationFailure(
    String message, {
    String? code,
    Map<String, dynamic>? details,
  }) : super(
          message: message,
          code: code,
          details: details,
        );
}

/// Authorization failures
class AuthorizationFailure extends Failure {
  /// Required permissions that are missing
  final List<String>? requiredPermissions;

  /// Creates an authorization failure
  const AuthorizationFailure(
    String message, {
    this.requiredPermissions,
    String? code,
  }) : super(
          message: message,
          code: code,
          details: requiredPermissions != null
              ? {'required_permissions': requiredPermissions}
              : null,
        );
}

/// Unexpected failures
class UnexpectedFailure extends Failure {
  /// Creates an unexpected failure
  const UnexpectedFailure(
    String message, {
    String? code,
    StackTrace? stackTrace,
    Map<String, dynamic>? details,
  }) : super(
          message: message,
          code: code,
          stackTrace: stackTrace,
          details: details,
        );
}

/// Base repository interface
/// Provides common CRUD operations and patterns
abstract class BaseRepository<T> {
  /// Get all entities
  FutureEither<List<T>> getAll();

  /// Get paginated entities
  FutureEither<PaginationEntity<T>> getPaginated(PaginationParams params);

  /// Get entity by ID
  FutureEither<T> getById(int id);

  /// Create new entity
  FutureEither<T> create(T entity);

  /// Update existing entity
  FutureEither<T> update(T entity);

  /// Delete entity by ID
  FutureEitherVoid delete(int id);

  /// Check if entity exists by ID
  FutureEither<bool> exists(int id);
}

/// Repository with search capability
abstract class SearchableRepository<T> extends BaseRepository<T> {
  /// Search entities by query
  FutureEither<List<T>> search(String query);

  /// Search with pagination
  FutureEither<PaginationEntity<T>> searchPaginated(
    String query,
    PaginationParams params,
  );
}

/// Repository with batch operations
abstract class BatchRepository<T> extends BaseRepository<T> {
  /// Create multiple entities
  FutureEither<List<T>> createBatch(List<T> entities);

  /// Update multiple entities
  FutureEither<List<T>> updateBatch(List<T> entities);

  /// Delete multiple entities by IDs
  FutureEitherVoid deleteBatch(List<int> ids);
}

/// Repository with filtering capability
abstract class FilterableRepository<T> extends BaseRepository<T> {
  /// Get filtered entities
  FutureEither<List<T>> getFiltered(Map<String, dynamic> filters);

  /// Get filtered entities with pagination
  FutureEither<PaginationEntity<T>> getFilteredPaginated(
    Map<String, dynamic> filters,
    PaginationParams params,
  );
}

/// Repository with tenant awareness
abstract class TenantAwareRepository<T> extends BaseRepository<T> {
  /// Get tenant ID for current context
  int get currentTenantId;

  /// Get all entities for current tenant
  @override
  FutureEither<List<T>> getAll();

  /// Get entity by ID for current tenant
  @override
  FutureEither<T> getById(int id);
}

/// Repository with caching support (for future offline capability)
abstract class CacheableRepository<T> extends BaseRepository<T> {
  /// Clear cache for this repository
  FutureEitherVoid clearCache();

  /// Refresh cache from remote source
  FutureEitherVoid refreshCache();

  /// Check if cache is stale
  Future<bool> isCacheStale();
}

/// Complete repository with all capabilities
abstract class FullRepository<T>
    implements
        SearchableRepository<T>,
        BatchRepository<T>,
        FilterableRepository<T>,
        CacheableRepository<T> {
  /// Export entities to specific format
  FutureEither<String> export(String format);

  /// Import entities from specific format
  FutureEither<List<T>> import(String data, String format);
}