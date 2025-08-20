import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class Register implements UseCase<User, RegisterParams> {
  final AuthRepository repository;

  Register(this.repository);

  @override
  Future<Either<Failure, User>> call(RegisterParams params) async {
    return await repository.register(
      tenantName: params.tenantName,
      businessType: params.businessType,
      email: params.email,
      phone: params.phone,
      password: params.password,
      fullName: params.fullName,
    );
  }
}

class RegisterParams extends Equatable {
  final String tenantName;
  final String? businessType;
  final String email;
  final String? phone;
  final String password;
  final String fullName;

  const RegisterParams({
    required this.tenantName,
    this.businessType,
    required this.email,
    this.phone,
    required this.password,
    required this.fullName,
  });

  @override
  List<Object?> get props => [
        tenantName,
        businessType,
        email,
        phone,
        password,
        fullName,
      ];
}