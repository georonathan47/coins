import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/coin_data.dart';
import '../repositories/buy_repository.dart';

class FetchTradableCoinsUsecase extends UseCase<List<CoinData>, ObjectParams<int>> {
  FetchTradableCoinsUsecase(this._repository);
  final BuyRepository _repository;

  @override
  Future<Either<Failure, List<CoinData>>> call(ObjectParams<int> params) {
    return _repository.fetchTradableCoins(params.value);
  }
}
