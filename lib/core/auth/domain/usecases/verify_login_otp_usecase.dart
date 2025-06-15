import 'package:fpdart/fpdart.dart';

import '../../../error/failures.dart';
import '../../../usecase/usecase.dart';
import '../../data/models/verify_otp_model.dart';
import '../repositories/auth_repository.dart';

class VerifyLoginOtpUsecase
    extends UseCase<String, ObjectParams<VerifyOtpModel>> {
  VerifyLoginOtpUsecase(this.repository);
  final AuthRepository repository;

  @override
  Future<Either<Failure, String>> call(ObjectParams<VerifyOtpModel> params) {
    return repository.verifyOtp(params.value);
  }
}
