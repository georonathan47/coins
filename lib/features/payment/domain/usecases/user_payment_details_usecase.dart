import 'package:fpdart/fpdart.dart';

import '../../../../core/shared/error/failures.dart';
import '../../../../core/shared/usecase/usecase.dart';
import '../../data/models/user_payment_details.dart';
import '../repositories/payment_repository.dart';

class FetchUserPaymentDetailsUseCase
    extends UseCase<List<UserPaymentDetail>, NoParams> {
  final PaymentRepository _repository;

  FetchUserPaymentDetailsUseCase(this._repository);

  @override
  Future<Either<Failure, List<UserPaymentDetail>>> call(NoParams params) {
    return _repository.fetchPaymentDetails();
  }
}
