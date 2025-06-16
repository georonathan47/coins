import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/currency.dart';
import '../../data/models/ree_calc_response.dart';
import '../entities/country.dart';
import '../entities/fee_calculation.dart';

abstract class BuyRepository {
  /// Fetch all countries
  Future<Either<Failure, List<Country>>> fetchCountries();

  /// Fetch all currencies
  Future<Either<Failure, List<Currency>>> fetchCurrencies(int countryId);

  // ? Calculate amount based on selected fee type
  Future<Either<Failure, FeeCalcResponse>> calculateAmount(FeeCalculation fee);
}
