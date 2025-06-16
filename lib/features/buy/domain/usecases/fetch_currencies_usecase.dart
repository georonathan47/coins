import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/currency.dart';
import '../repositories/buy_repository.dart';

class FetchCurrenciesUsecase extends UseCase<List<Currency>, ObjectParams<int>> {
  FetchCurrenciesUsecase(this.repository);
  final BuyRepository repository;

  @override
  Future<Either<Failure, List<Currency>>> call(ObjectParams<int> params) {
    return repository.fetchCurrencies(params.value);
  }
}
