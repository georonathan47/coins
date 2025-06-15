import 'package:fpdart/fpdart.dart';

import '../../../error/failures.dart';
import '../../../usecase/usecase.dart';
import '../../data/models/auth_response.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Login User
class LoginUserUsecase implements UseCase<AuthResponse, ObjectParams<User>> {
  /// Constructor
  LoginUserUsecase(this.repository);

  /// Repository
  final AuthRepository repository;

  @override
  Future<Either<Failure, AuthResponse>> call(ObjectParams<User> params) {
    return repository.login(params.value);
  }
}
