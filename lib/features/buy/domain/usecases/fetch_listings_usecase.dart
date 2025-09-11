import 'package:fpdart/fpdart.dart';

import '../../../../core/shared/error/failures.dart';
import '../../../../core/shared/usecase/usecase.dart';
import '../entities/coin_data.dart';
import '../repositories/buy_repository.dart';

class FetchListingsUsecase extends UseCase<List<CoinData>, NoParams> {
  FetchListingsUsecase(this._repository);
  final BuyRepository _repository;

  @override
  Future<Either<Failure, List<CoinData>>> call(NoParams params) {
    return _repository.fetchListings();
  }
}
