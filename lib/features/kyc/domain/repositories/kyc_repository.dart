import 'package:fpdart/fpdart.dart';
import '../../../../core/shared/error/failures.dart';
import '../entities/kyc_entity.dart';
import '../entities/kyc_status.enum.dart';

abstract class KycRepository {
  Future<Either<Failure, KycStatus>> checkKycStatus();
  Future<Either<Failure, String>> initiateKyc(KycModel request);
}
