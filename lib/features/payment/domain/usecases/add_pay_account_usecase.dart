import 'package:fpdart/fpdart.dart';

import '../../../../core/shared/error/failures.dart';
import '../../../../core/shared/usecase/usecase.dart';
import '../entities/pay_account.dart';
import '../repositories/payment_repository.dart';

class AddPayAccountUsecase
    extends UseCase<PayAccount, ObjectParams<PayAccount>> {
  AddPayAccountUsecase(this.repository);
  final PaymentRepository repository;

  @override
  Future<Either<Failure, PayAccount>> call(ObjectParams<PayAccount> params) {
    return repository.addPayAccount(params.value);
  }
}
