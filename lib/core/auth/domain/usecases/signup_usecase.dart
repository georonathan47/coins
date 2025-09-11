import 'package:fpdart/fpdart.dart';

import '../../../shared/error/failures.dart';
import '../../../shared/usecase/usecase.dart';
import '../../data/models/auth_response.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Login User
class RegisterUserUsecase implements UseCase<AuthResponse, ObjectParams<User>> {
  /// Constructor
  RegisterUserUsecase(this.repository);

  /// Repository
  final AuthRepository repository;

  @override
  Future<Either<Failure, AuthResponse>> call(ObjectParams<User> params) {
    return repository.register(params.value);
  }
}
