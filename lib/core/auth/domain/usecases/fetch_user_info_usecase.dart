
import 'package:fpdart/fpdart.dart';

import '../../../shared/error/failures.dart';
import '../../../shared/usecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Login User
class FetchUserInfoUsecase implements UseCase<User, NoParams> {
  /// Constructor
  FetchUserInfoUsecase(this.repository);

  /// Repository
  final AuthRepository repository;

  @override
  Future<Either<Failure, User>> call(NoParams params) {
    return repository.fetchUserInfo();
  }
}
