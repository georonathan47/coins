import '../../../features/homepage/presentation/widgets/widgets.dart';
import '../../onboarding/presentation/controller/onboarding_controller.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    // ? Claims Controller
    Get
      // //? Auth Controller
      ..put(
        AuthController(
          loginUserUsecase: Get.find(),
          logoutUserUsecase: Get.find(),
          refreshTokenUsecase: Get.find(),
          registerUserUsecase: Get.find(),
          retrieveUserUsecase: Get.find(),
          sendLoginOtpUseCase: Get.find(),
          fetchUserInfoUsecase: Get.find(),
          resetPasswordUsecase: Get.find(),
          verifyLoginOtpUsecase: Get.find(),
        ),
      )

      //? Onboarding Controller
      ..put(DashboardController(retrieveUserUsecase: Get.find()))
      ..put(OnboardingController(saveOnboardingStatus: Get.find()));
  }
}
