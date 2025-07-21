import 'package:fpdart/fpdart.dart';

import '../../../../core/shared/error/failures.dart';
import '../../../../core/shared/usecase/usecase.dart';
import '../../../buy/data/models/buy_history_model.dart';
import '../repositories/sell_repository.dart';

class FetchSellHistoryUsecase
    extends UseCase<List<BuyHistoryModel>, NoParams> {
  final SellRepository _repository;
  FetchSellHistoryUsecase(this._repository);

  @override
  Future<Either<Failure, List<BuyHistoryModel>>> call(NoParams params) {
    return _repository.fetchOrderHistory();
  }
}
