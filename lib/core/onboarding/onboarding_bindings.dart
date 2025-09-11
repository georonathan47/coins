import 'package:get/get.dart';

import 'data/datasources/local_database.dart';
import 'data/repositories/onboarding_repository_impl.dart';
import 'domain/repositories/onboarding_repo.dart';
import 'domain/usecases/save_onboarding.dart';

class OnboardingBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => SaveOnboardingStatus(Get.find()))
      ..lazyPut<OnboardingRepository>(
        () => OnboardingRepositoryImpl(localDatabase: Get.find()),
      )
      ..lazyPut<OnboardingLocalDatabase>(
        () => OnboardingLocalDatabaseImpl(Get.find()),
      );
  }
}
