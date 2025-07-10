import 'package:fpdart/fpdart.dart';

import '../../../../core/shared/error/failures.dart';
import '../../../../core/shared/usecase/usecase.dart';
import '../entities/kyc_entity.dart';
import '../repositories/kyc_repository.dart';

class InitiateKycUsecase extends UseCase<String, ObjectParams<KycModel>> {
  final KycRepository repository;
  InitiateKycUsecase(this.repository);

  @override
  Future<Either<Failure, String>> call(ObjectParams<KycModel> params) {
    return repository.initiateKyc(params.value);
  }
}