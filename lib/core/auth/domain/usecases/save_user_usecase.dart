import 'package:fpdart/fpdart.dart';

import '../../../shared/error/failures.dart';
import '../../../shared/usecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Login User
class SaveUserInfoUsecase implements UseCase<void, ObjectParams<User>> {
  /// Constructor
  SaveUserInfoUsecase(this.repository);

  /// Repository
  final AuthRepository repository;

  @override
  Future<Either<Failure, void>> call(ObjectParams<User> params) {
    return repository.saveUserInfo(params.value);
  }
}
