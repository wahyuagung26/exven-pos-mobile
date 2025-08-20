import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/token_pair.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, TokenPair>> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await remoteDataSource.login(
        email: email,
        password: password,
      );

      // Cache tokens and user data
      final tokenPair = result.data.toTokenPair();
      await localDataSource.cacheAccessToken(tokenPair.accessToken);
      await localDataSource.cacheRefreshToken(tokenPair.refreshToken);
      await localDataSource.cacheUser(result.data.user);

      return Right(tokenPair.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Server error', code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message ?? 'Network error'));
    } on CacheException catch (e) {
      // Login succeeded but caching failed - still return success
      // but log the cache failure
      return Left(CacheFailure(message: e.message ?? 'Cache error'));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error during login: $e'));
    }
  }

  @override
  Future<Either<Failure, User>> register({
    required String tenantName,
    String? businessType,
    required String email,
    String? phone,
    required String password,
    required String fullName,
  }) async {
    try {
      final result = await remoteDataSource.register(
        tenantName: tenantName,
        businessType: businessType,
        email: email,
        phone: phone,
        password: password,
        fullName: fullName,
      );

      return Right(result.data.user.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Server error', code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error during registration: $e'));
    }
  }

  @override
  Future<Either<Failure, TokenPair>> refreshToken({
    required String refreshToken,
  }) async {
    try {
      final result = await remoteDataSource.refreshToken(
        refreshToken: refreshToken,
      );

      // Cache new tokens
      await Future.wait([
        localDataSource.cacheAccessToken(result.accessToken),
        localDataSource.cacheRefreshToken(result.refreshToken),
      ]);

      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Server error', code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message ?? 'Network error'));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message ?? 'Cache error'));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error during token refresh: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // Logout from server first
      await remoteDataSource.logout();
      
      // Clear local auth data
      await localDataSource.clearAuthData();

      return const Right(null);
    } on ServerException catch (e) {
      // Even if server logout fails, clear local data
      await localDataSource.clearAuthData();
      return Left(ServerFailure(message: e.message ?? 'Server error', code: e.code));
    } on NetworkException catch (e) {
      // Even if network fails, clear local data
      await localDataSource.clearAuthData();
      return Left(NetworkFailure(message: e.message ?? 'Network error'));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message ?? 'Cache error'));
    } catch (e) {
      // Clear local data on any error
      await localDataSource.clearAuthData();
      return Left(ServerFailure(message: 'Unexpected error during logout: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      await remoteDataSource.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Server error', code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error during password change: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String email,
  }) async {
    try {
      await remoteDataSource.resetPassword(email: email);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Server error', code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error during password reset: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> verifyEmail({
    required String token,
  }) async {
    try {
      await remoteDataSource.verifyEmail(token: token);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Server error', code: e.code));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error during email verification: $e'));
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final cachedUser = await localDataSource.getCachedUser();
      
      if (cachedUser != null) {
        return Right(cachedUser.toEntity());
      }
      
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message ?? 'Cache error'));
    } catch (e) {
      return Left(CacheFailure(message: 'Unexpected error getting current user: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> clearAuthData() async {
    try {
      await localDataSource.clearAuthData();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message ?? 'Cache error'));
    } catch (e) {
      return Left(CacheFailure(message: 'Unexpected error clearing auth data: $e'));
    }
  }
}