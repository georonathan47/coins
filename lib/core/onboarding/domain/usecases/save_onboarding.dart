import 'package:fpdart/fpdart.dart';

import '../../../shared/usecase/usecase.dart';
import '../../../shared/data/result.dart';
import '../repositories/onboarding_repo.dart';

/// Save Onboarding usecase
class SaveOnboardingStatus implements APIUseCase<void, ObjectParams<bool>> {
  /// Constructor
  SaveOnboardingStatus(this.repository);

  /// Repository
  final OnboardingRepository repository;

  @override
  Future<Either<FailureResult, void>> call(ObjectParams<bool> params) =>
      repository.saveOnboardingStatus(params.value);
}
