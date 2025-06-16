import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/ree_calc_response.dart';
import '../entities/fee_calculation.dart';
import '../repositories/buy_repository.dart';

class CalculateFeeUsecase
    extends UseCase<FeeCalcResponse, ObjectParams<FeeCalculation>> {
  CalculateFeeUsecase(this.repository);
  final BuyRepository repository;

  @override
  Future<Either<Failure, FeeCalcResponse>> call(
    ObjectParams<FeeCalculation> params,
  ) {
    return repository.calculateAmount(params.value);
  }
}
