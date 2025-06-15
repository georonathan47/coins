import 'package:fpdart/fpdart.dart';

import '../../../../core/error/exception.dart';
import '../../../data/result.dart';
import '../../domain/repositories/onboarding_repo.dart';
import '../datasources/local_database.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  /// Constructor
  OnboardingRepositoryImpl({required this.localDatabase});

  /// Local database
  final OnboardingLocalDatabase localDatabase;

  @override
  Future<Either<FailureResult, void>> saveOnboardingStatus(bool status) async {
    try {
      return Right(await localDatabase.saveOnboardingStatus(status));
    } on DeviceException catch (error) {
      return Left(
        FailureResult(message: error.message, statusCode: 500, data: null),
      );
    }
  }
}
