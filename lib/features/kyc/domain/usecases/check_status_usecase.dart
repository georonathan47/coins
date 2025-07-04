import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/kyc_status.enum.dart';
import '../repositories/kyc_repository.dart';

class CheckKycStatusUsecase extends UseCase<KycStatus, NoParams> {
  final KycRepository repository;
  CheckKycStatusUsecase(this.repository);

  @override
  Future<Either<Failure, KycStatus>> call(NoParams params) {
    return repository.checkKycStatus();
  }
}
