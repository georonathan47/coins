import 'package:fpdart/fpdart.dart';

import '../../../../core/shared/error/failures.dart';
import '../../../../core/shared/usecase/usecase.dart';

import '../entities/payment_details.dart';
import '../repositories/payment_repository.dart';

class GetPaymentDetailsUsecase
    extends
        DualUseCase<
          List<PaymentDetails>,
          ObjectParams<String>,
          ObjectParams<String>
        > {
  GetPaymentDetailsUsecase(this.repository);
  final PaymentRepository repository;

  @override
  Future<Either<Failure, List<PaymentDetails>>> call(
    ObjectParams<String> params,
    ObjectParams<String> params2,
  ) {
    return repository.getPaymentDetails(params.value, params2.value);
  }
}
