import 'package:fpdart/fpdart.dart';

import '../../../shared/data/result.dart';

abstract class OnboardingRepository {
	Future<Either<FailureResult, void>> saveOnboardingStatus(bool status);
}