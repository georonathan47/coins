import 'package:fpdart/fpdart.dart';

import '../../../../core/shared/error/failures.dart';
import '../../../../core/shared/usecase/usecase.dart';
import '../../data/models/sell_order_response.dart';
import '../entities/create_sell_order.dart';
import '../repositories/sell_repository.dart';

class CreateSellOrderUsecase
    extends UseCase<SellOrderResponse, ObjectParams<SellOrder>> {
  final SellRepository _repository;
  CreateSellOrderUsecase(this._repository);

  @override
  Future<Either<Failure, SellOrderResponse>> call(
    ObjectParams<SellOrder> params,
  ) {
    return _repository.create(params.value);
  }
}
