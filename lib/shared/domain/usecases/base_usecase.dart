import 'package:dartz/dartz.dart';

import '../repositories/base_repository.dart';

/// Base use case interface
/// Implements the Command pattern for business logic
abstract class UseCase<Type, Params> {
  /// Execute the use case with given parameters
  Future<Either<Failure, Type>> call(Params params);
}

/// Use case without parameters
abstract class NoParamsUseCase<Type> {
  /// Execute the use case without parameters
  Future<Either<Failure, Type>> call();
}

/// Use case that returns void/unit
abstract class VoidUseCase<Params> {
  /// Execute the use case with given parameters
  Future<Either<Failure, void>> call(Params params);
}

/// Use case that returns a stream
abstract class StreamUseCase<Type, Params> {
  /// Execute the use case and return a stream of results
  Stream<Either<Failure, Type>> call(Params params);
}

/// Base class for use case parameters
abstract class Params {
  /// Convert parameters to JSON for logging/debugging
  Map<String, dynamic> toJson();

  /// Validate parameters before execution
  Either<Failure, void> validate() {
    return const Right(null);
  }
}

/// Empty parameters for use cases that don't need input
class NoParams extends Params {
  /// Creates no parameters instance
  const NoParams();

  @override
  Map<String, dynamic> toJson() => {};
}

/// Parameters for ID-based operations
class IdParams extends Params {
  /// Entity ID
  final int id;

  /// Creates ID parameters
  const IdParams({required this.id});

  @override
  Map<String, dynamic> toJson() => {'id': id};

  @override
  Either<Failure, void> validate() {
    if (id <= 0) {
      return const Left(
        ValidationFailure('Invalid ID: ID must be greater than 0'),
      );
    }
    return const Right(null);
  }
}

/// Parameters for search operations
class SearchParams extends Params {
  /// Search query
  final String query;
  
  /// Optional filters
  final Map<String, dynamic>? filters;

  /// Creates search parameters
  const SearchParams({
    required this.query,
    this.filters,
  });

  @override
  Map<String, dynamic> toJson() => {
        'query': query,
        if (filters != null) 'filters': filters!,
      };

  @override
  Either<Failure, void> validate() {
    if (query.isEmpty) {
      return const Left(
        ValidationFailure('Search query cannot be empty'),
      );
    }
    return const Right(null);
  }
}

/// Base class for compound use cases that coordinate multiple operations
abstract class CompoundUseCase<Type, Params> extends UseCase<Type, Params> {
  /// Execute pre-processing logic
  Future<Either<Failure, void>> preProcess(Params params) async {
    return const Right(null);
  }

  /// Execute main business logic
  Future<Either<Failure, Type>> process(Params params);

  /// Execute post-processing logic
  Future<Either<Failure, void>> postProcess(
    Params params,
    Type result,
  ) async {
    return const Right(null);
  }

  @override
  Future<Either<Failure, Type>> call(Params params) async {
    // Validate parameters
    final validation = params.validate();
    if (validation.isLeft()) {
      return Left(validation.fold((l) => l, (r) => null)!);
    }

    // Pre-processing
    final preResult = await preProcess(params);
    if (preResult.isLeft()) {
      return Left(preResult.fold((l) => l, (r) => null)!);
    }

    // Main processing
    final processResult = await process(params);
    if (processResult.isLeft()) {
      return processResult;
    }

    // Post-processing
    final result = processResult.fold((l) => null, (r) => r)!;
    final postResult = await postProcess(params, result);
    if (postResult.isLeft()) {
      return Left(postResult.fold((l) => l, (r) => null)!);
    }

    return Right(result);
  }
}

/// Use case with retry capability
abstract class RetryableUseCase<Type, Params> extends UseCase<Type, Params> {
  /// Maximum number of retry attempts
  int get maxRetries => 3;

  /// Delay between retry attempts in milliseconds
  int get retryDelay => 1000;

  /// Determine if error is retryable
  bool isRetryable(Failure failure) {
    return failure is NetworkFailure;
  }

  /// Execute the actual use case logic
  Future<Either<Failure, Type>> execute(Params params);

  @override
  Future<Either<Failure, Type>> call(Params params) async {
    int attempts = 0;
    
    while (attempts < maxRetries) {
      final result = await execute(params);
      
      if (result.isRight()) {
        return result;
      }
      
      final failure = result.fold((l) => l, (r) => null)!;
      
      if (!isRetryable(failure) || attempts == maxRetries - 1) {
        return result;
      }
      
      attempts++;
      await Future.delayed(Duration(milliseconds: retryDelay * attempts));
    }
    
    return Left(
      UnexpectedFailure(
        'Max retry attempts ($maxRetries) exceeded',
      ),
    );
  }
}

/// Use case with caching capability (for future offline support)
abstract class CacheableUseCase<Type, Params> extends UseCase<Type, Params> {
  /// Cache key for this use case
  String getCacheKey(Params params);

  /// Cache duration in milliseconds
  int get cacheDuration => 5 * 60 * 1000; // 5 minutes default

  /// Whether to use cache for this request
  bool shouldUseCache(Params params) => true;

  /// Get cached result if available
  Future<Either<Failure, Type>?> getCached(Params params);

  /// Save result to cache
  Future<void> saveToCache(Params params, Type result);

  /// Execute the actual use case logic
  Future<Either<Failure, Type>> execute(Params params);

  @override
  Future<Either<Failure, Type>> call(Params params) async {
    // Check if cache should be used
    if (shouldUseCache(params)) {
      final cached = await getCached(params);
      if (cached != null) {
        return cached;
      }
    }

    // Execute the use case
    final result = await execute(params);

    // Save to cache if successful
    if (result.isRight()) {
      final data = result.fold((l) => null, (r) => r)!;
      await saveToCache(params, data);
    }

    return result;
  }
}

/// Use case with transaction support
abstract class TransactionalUseCase<Type, Params>
    extends UseCase<Type, Params> {
  /// Begin transaction
  Future<Either<Failure, void>> beginTransaction();

  /// Commit transaction
  Future<Either<Failure, void>> commitTransaction();

  /// Rollback transaction
  Future<Either<Failure, void>> rollbackTransaction();

  /// Execute the actual use case logic within transaction
  Future<Either<Failure, Type>> executeInTransaction(Params params);

  @override
  Future<Either<Failure, Type>> call(Params params) async {
    // Begin transaction
    final beginResult = await beginTransaction();
    if (beginResult.isLeft()) {
      return Left(beginResult.fold((l) => l, (r) => null)!);
    }

    try {
      // Execute in transaction
      final result = await executeInTransaction(params);

      if (result.isRight()) {
        // Commit if successful
        final commitResult = await commitTransaction();
        if (commitResult.isLeft()) {
          await rollbackTransaction();
          return Left(commitResult.fold((l) => l, (r) => null)!);
        }
      } else {
        // Rollback if failed
        await rollbackTransaction();
      }

      return result;
    } catch (e) {
      // Rollback on exception
      await rollbackTransaction();
      return Left(
        UnexpectedFailure(
          'Transaction failed: ${e.toString()}',
          stackTrace: StackTrace.current,
        ),
      );
    }
  }
}