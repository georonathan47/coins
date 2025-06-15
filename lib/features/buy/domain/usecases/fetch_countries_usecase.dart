import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/country.dart';
import '../repositories/buy_repository.dart';

class FetchCountriesUsecase extends UseCase<List<Country>, NoParams> {
  FetchCountriesUsecase(this.repository);
  final BuyRepository repository;

  @override
  Future<Either<Failure, List<Country>>> call(NoParams params) {
    return repository.fetchCountries();
  }
}
