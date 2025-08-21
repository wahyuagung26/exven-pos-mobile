import 'package:dartz/dartz.dart';
import '../../../../shared/domain/failures/failures.dart';
import '../entities/user_entity.dart';
import '../repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository _repository;

  GetCurrentUserUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call() async {
    return await _repository.getCurrentUser();
  }
}