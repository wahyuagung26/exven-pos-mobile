import 'package:dartz/dartz.dart';
import '../../../../shared/domain/failures/failures.dart';
import '../repository.dart';

class LogoutUseCase {
  final AuthRepository _repository;

  LogoutUseCase(this._repository);

  Future<Either<Failure, void>> call() async {
    return await _repository.logout();
  }
}