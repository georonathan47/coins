import 'package:get/get.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/save_onboarding.dart';

class OnboardingController extends GetxController {
  final SaveOnboardingStatus saveOnboardingStatus;

  OnboardingController({required this.saveOnboardingStatus});
  final onboarded = false.obs;
  static OnboardingController get instance => Get.find();

  Future<void> onboardingComplete() async {
    final result = await saveOnboardingStatus(const ObjectParams(true));
    result.fold((failure) => onboarded.value = false, (success) {
      onboarded.value = true;
    });
  }
}
