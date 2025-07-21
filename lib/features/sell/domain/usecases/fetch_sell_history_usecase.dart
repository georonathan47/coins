import 'package:fpdart/fpdart.dart';

import '../../../../core/shared/error/failures.dart';
import '../../../../core/shared/usecase/usecase.dart';
import '../../data/models/sell_history_model.dart';
import '../repositories/sell_repository.dart';

class FetchSellHistoryUsecase
    extends UseCase<List<SellHistoryModel>, NoParams> {
  final SellRepository _repository;
  FetchSellHistoryUsecase(this._repository);

  @override
  Future<Either<Failure, List<SellHistoryModel>>> call(NoParams params) {
    return _repository.fetchOrderHistory();
  }
}
