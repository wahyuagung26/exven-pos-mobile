import 'package:dartz/dartz.dart';
import '../../../shared/domain/failures/failures.dart';
import 'entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(String email, String password);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, UserEntity>> getCurrentUser();
  Future<Either<Failure, void>> refreshToken();
}