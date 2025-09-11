import 'package:fpdart/fpdart.dart';

import '../../../shared/error/failures.dart';
import '../../../shared/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class LogoutUserUsecase implements UseCase<void, NoParams> {
  /// Constructor
  LogoutUserUsecase(this.repository);

  /// Repository
  final AuthRepository repository;

  @override
  Future<Either<Failure, void>> call(params) {
    return repository.logout();
  }
}
