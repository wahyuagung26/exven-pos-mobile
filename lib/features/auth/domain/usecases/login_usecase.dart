import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../shared/domain/failures/failures.dart';
import '../entities/user_entity.dart';
import '../repository.dart';

part 'login_usecase.freezed.dart';

@freezed
class LoginParams with _$LoginParams {
  const factory LoginParams({
    required String email,
    required String password,
  }) = _LoginParams;
}

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call(LoginParams params) async {
    // Basic validation
    if (params.email.isEmpty) {
      return const Left(Failure.validation('Email is required'));
    }
    
    if (params.password.isEmpty) {
      return const Left(Failure.validation('Password is required'));
    }
    
    if (!params.email.contains('@')) {
      return const Left(Failure.validation('Please enter a valid email'));
    }
    
    if (params.password.length < 6) {
      return const Left(Failure.validation('Password must be at least 6 characters'));
    }
    
    return await _repository.login(params.email, params.password);
  }
}