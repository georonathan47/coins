import '../../../features/buy/presentation/controller/buy_controller.dart';
import '../../../features/homepage/presentation/widgets/widgets.dart';
import '../../../features/kyc/presentation/controller/kyc_controller.dart';
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
          saveUserInfoUsecase: Get.find(),
          sendLoginOtpUseCase: Get.find(),
          fetchUserInfoUsecase: Get.find(),
          resetPasswordUsecase: Get.find(),
          fetchCountriesUsecase: Get.find(),
          verifyLoginOtpUsecase: Get.find(),
        ),
      )
      ..put(
        BuyController(
          fetchMomoUsecase: Get.find(),
          fetchBanksUsecase: Get.find(),
          calculateFeeUsecase: Get.find(),
          retrieveUserUsecase: Get.find(),
          fetchListingsUsecase: Get.find(),
          fetchCountriesUsecase: Get.find(),
          createBuyOrderUsecase: Get.find(),
          fetchBuyHistoryUsecase: Get.find(),
          fetchCurrenciesUsecase: Get.find(),
          fetchPaymentModesUsecase: Get.find(),
          getPaymentDetailsUsecase: Get.find(),
        ),
      )
      ..put(
        DashboardController(
          retrieveUserUsecase: Get.find(),
          saveUserInfoUsecase: Get.find(),
          fetchListingsUsecase: Get.find(),
          fetchUserInfoUsecase: Get.find(),
          checkKycStatusUsecase: Get.find(),
          fetchCountriesUsecase: Get.find(),
          fetchCurrenciesUsecase: Get.find(),
          fetchDashPortfolioUsecase: Get.find(),
          fetchTradableCoinsUsecase: Get.find(),
        ),
      )
      ..put(
        KycController(
          openImageCamera: Get.find(),
          openImageGallery: Get.find(),
          initiateKycUsecase: Get.find(),
          retrieveUserUsecase: Get.find(),
          checkKycStatusUsecase: Get.find(),
        ),
      )
      //? Onboarding Controller
      ..put(OnboardingController(saveOnboardingStatus: Get.find()));
  }
}
