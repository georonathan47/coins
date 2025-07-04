import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/payment_mode.dart';
import '../repositories/buy_repository.dart';

class FetchPaymentModesUsecase
    extends UseCase<List<PaymentMode>, ObjectParams<String>> {
  FetchPaymentModesUsecase(this._repository);
  final BuyRepository _repository;

  @override
  Future<Either<Failure, List<PaymentMode>>> call(ObjectParams params) {
    return _repository.fetchPaymentModes(params.value);
  }
}
