import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/token_pair.dart';
import '../repositories/auth_repository.dart';

class RefreshToken implements UseCase<TokenPair, RefreshTokenParams> {
  final AuthRepository repository;

  RefreshToken(this.repository);

  @override
  Future<Either<Failure, TokenPair>> call(RefreshTokenParams params) async {
    return await repository.refreshToken(
      refreshToken: params.refreshToken,
    );
  }
}

class RefreshTokenParams extends Equatable {
  final String refreshToken;

  const RefreshTokenParams({
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [refreshToken];
}