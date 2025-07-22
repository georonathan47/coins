import 'package:fpdart/fpdart.dart';

import '../../../shared/error/failures.dart';
import '../../../shared/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class SendLoginOtpUseCase extends UseCase<String, ObjectParams<int>> {
  SendLoginOtpUseCase(this.repository);
  final AuthRepository repository;

  @override
  Future<Either<Failure, String>> call(ObjectParams<int> params) {
    return repository.sendLoginOtp(params.value);
  }
}
