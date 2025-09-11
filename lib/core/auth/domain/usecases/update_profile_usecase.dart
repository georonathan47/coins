import 'package:fpdart/fpdart.dart';

import '../../../shared/error/failures.dart';
import '../../../shared/usecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Login User
class UpdateUserUsecase implements UseCase<String, ObjectParams<User>> {
  /// Constructor
  UpdateUserUsecase(this.repository);

  /// Repository
  final AuthRepository repository;

  @override
  Future<Either<Failure, String>> call(ObjectParams<User> params) {
    return repository.update(params.value);
  }
}
