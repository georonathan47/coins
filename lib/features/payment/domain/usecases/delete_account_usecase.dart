import 'package:fpdart/fpdart.dart';

import '../../../../core/shared/error/failures.dart';
import '../../../../core/shared/usecase/usecase.dart';
import '../repositories/payment_repository.dart';

class DeletePayAccountUsecase extends UseCase<void, ObjectParams<int>> {
  DeletePayAccountUsecase(this.repository);
  final PaymentRepository repository;

  @override
  Future<Either<Failure, void>> call(ObjectParams<int> params) {
    return repository.deletePayAccount(params.value);
  }
}
