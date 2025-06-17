import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/create_buy_order.dart';
import '../repositories/buy_repository.dart';

class CreateBuyOrderUsecase
    extends UseCase<dynamic, ObjectParams<CreateBuyOrder>> {
  CreateBuyOrderUsecase(this.repository);
  final BuyRepository repository;

  @override
  Future<Either<Failure, dynamic>> call(ObjectParams<CreateBuyOrder> params) {
    return repository.createBuyOrder(params.value);
  }
}
