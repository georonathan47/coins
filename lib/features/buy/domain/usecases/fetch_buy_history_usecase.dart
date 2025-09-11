import 'package:fpdart/fpdart.dart';

import '../../../../core/shared/error/failures.dart';
import '../../../../core/shared/usecase/usecase.dart';
import '../../data/models/buy_history_model.dart';
import '../repositories/buy_repository.dart';

class FetchBuyHistoryUsecase  extends UseCase<List<BuyHistoryModel>, NoParams> {
  final BuyRepository _repository;
  FetchBuyHistoryUsecase(this._repository);

  @override
  Future<Either<Failure, List<BuyHistoryModel>>> call(NoParams params) {
   return _repository.fetchOrderHistory();
  }

}