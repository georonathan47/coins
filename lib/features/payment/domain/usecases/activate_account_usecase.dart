import 'package:fpdart/fpdart.dart';

import '../../../../core/shared/error/failures.dart';
import '../../../../core/shared/usecase/usecase.dart';
import '../../data/models/user_payment_details.dart';
import '../repositories/payment_repository.dart';

class ActivateAccountUsecase
    extends UseCase<String, ObjectParams<UserPaymentDetail>> {
  ActivateAccountUsecase(this.repository);
  final PaymentRepository repository;

  @override
  Future<Either<Failure, String>> call(
    ObjectParams<UserPaymentDetail> params,
  ) {
    return repository.activate(params.value);
  }
}
