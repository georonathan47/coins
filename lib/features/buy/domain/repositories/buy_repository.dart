import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/country.dart';

abstract class BuyRepository {
  /// Fetch all countries
  Future<Either<Failure, List<Country>>> fetchCountries();
}
