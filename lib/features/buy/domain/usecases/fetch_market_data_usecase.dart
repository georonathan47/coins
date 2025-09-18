import 'package:fpdart/fpdart.dart';

import '../../../../core/shared/error/failures.dart';
import '../../../../core/shared/usecase/usecase.dart';
import '../entities/coin_data.dart';
import '../repositories/buy_repository.dart';

class FetchMarketDataUsecase extends UseCase<List<CoinData>, NoParams> {
  FetchMarketDataUsecase(this.repository);
  final BuyRepository repository;

  @override
  Future<Either<Failure, List<CoinData>>> call(NoParams params) {
    return repository.fetchMarketData();
  }
}
