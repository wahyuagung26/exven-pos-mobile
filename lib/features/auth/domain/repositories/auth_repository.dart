import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/token_pair.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, TokenPair>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> register({
    required String tenantName,
    String? businessType,
    required String email,
    String? phone,
    required String password,
    required String fullName,
  });

  Future<Either<Failure, TokenPair>> refreshToken({
    required String refreshToken,
  });

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, void>> changePassword({
    required String oldPassword,
    required String newPassword,
  });

  Future<Either<Failure, void>> resetPassword({
    required String email,
  });

  Future<Either<Failure, void>> verifyEmail({
    required String token,
  });

  Future<Either<Failure, User?>> getCurrentUser();

  Future<Either<Failure, void>> clearAuthData();
}