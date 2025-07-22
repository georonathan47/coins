import 'package:fpdart/fpdart.dart';

import '../../../../core/shared/error/failures.dart';
import '../../../../core/shared/usecase/usecase.dart';
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
