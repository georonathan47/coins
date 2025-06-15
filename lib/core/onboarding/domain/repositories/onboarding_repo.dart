import 'package:fpdart/fpdart.dart';

import '../../../data/result.dart';

abstract class OnboardingRepository {
	Future<Either<FailureResult, void>> saveOnboardingStatus(bool status);
}