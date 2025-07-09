import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/create_order_response.dart';
import '../entities/create_buy_order.dart';
import '../repositories/buy_repository.dart';

class CreateBuyOrderUsecase
    extends UseCase<CreateBuyOrderResponse, ObjectParams<CreateBuyOrder>> {
  CreateBuyOrderUsecase(this.repository);
  final BuyRepository repository;

  @override
  Future<Either<Failure, CreateBuyOrderResponse>> call(
    ObjectParams<CreateBuyOrder> params,
  ) {
    return repository.createBuyOrder(params.value);
  }
}
