import 'package:fpdart/fpdart.dart';

import '../../../shared/error/failures.dart';
import '../../../shared/usecase/usecase.dart';
import '../../data/models/reset_password.dart';
import '../repositories/auth_repository.dart';

/// Login User
class ResetPasswordUsecase
    implements UseCase<String, ObjectParams<ResetPassword>> {
  /// Constructor
  ResetPasswordUsecase(this.repository);

  /// Repository
  final AuthRepository repository;

  @override
  Future<Either<Failure, String>> call(ObjectParams<ResetPassword> params) {
    return repository.resetPassword(params.value);
  }
}
