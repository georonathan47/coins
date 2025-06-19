import 'package:get/get.dart';

import '../../features/buy/presentation/pages/actionable_buy.dart';
import '../../features/buy/presentation/pages/buy_otp.dart';
import '../../features/buy/presentation/pages/buy_page.dart';
import '../../features/buy/presentation/pages/buy_summary.dart';
import '../../features/buy/presentation/pages/buyable_assets.dart';
import '../../features/buy/presentation/pages/history.dart';
import '../../features/buy/presentation/pages/payment_selection.dart';
import '../../features/buy/presentation/pages/success.dart';
import '../../features/homepage/presentation/pages/index.dart';
import '../../features/kyc/presentation/pages/home.dart';
import '../../features/kyc/presentation/pages/id_upload.dart';
import '../../features/kyc/presentation/pages/personal_details.dart';
import '../../features/kyc/presentation/pages/selfie_info.dart';
import '../../features/kyc/presentation/pages/selfie_upload.dart';
import '../auth/presentation/pages/captcha.dart';
import '../auth/presentation/pages/check_mail.dart';
import '../auth/presentation/pages/legacy.dart';
import '../auth/presentation/pages/mfa_otp.dart';
import '../auth/presentation/pages/login.dart';
import '../auth/presentation/pages/otp.dart';
import '../onboarding/presentation/pages/onboarding.dart';
import '../auth/presentation/pages/reg_otp.dart';
import '../auth/presentation/pages/signup.dart';
import '../auth/presentation/pages/signup_captcha.dart';
import '../presentation/animations/splash.dart';

class Routers {
  static const buy = '/buy';
  static const kyc = '/kyc';
  static const otp = '/otp';
  static const mfa = '/mfa';
  static const edit = '/edit';
  static const index = '/index';
  static const login = '/login';
  static const reset = '/reset';
  static const buyOtp = '/buyOtp';
  static const splash = '/splash';
  static const legacy = '/legacy';
  static const regOtp = '/regOtp';
  static const captcha = '/captcha';
  static const onboard = '/onboard';
  static const profile = '/profile';
  static const register = '/register';
  static const homepage = '/homepage';
  static const settings = '/settings';
  static const docUpload = '/docUpload';
  static const actionBuy = '/actionBuy';
  static const buyHistory = '/buyHistory';
  static const buySuccess = '/buySuccess';
  static const buySummary = '/buySummary';
  static const regCaptcha = '/regCaptcha';
  static const selfieInfo = '/selfieInfo';
  static const legacyEmail = '/legacyEmail';
  static const selfieUpload = '/selfieUpload';
  static const buyableAssets = '/buyableAssets';
  static const paymentSelection = '/paymentSelection';
  static const kycPersonalDetails = '/kycPersonalDetails';
}

class RouteManager {
  static const initial = Routers.splash;

  static List<GetPage> getPages() {
    return [
      // Onboarding
      GetPage(
        name: Routers.splash,
        transition: Transition.fadeIn,
        page: () => const SplashScreen(),
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: Routers.onboard,
        transition: Transition.fadeIn,
        page: () => const OnboardingScreen(),
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: Routers.login,
        page: () => const LoginPage(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: Routers.register,
        transition: Transition.fadeIn,
        page: () => const SignupPage(),
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: Routers.regCaptcha,
        transition: Transition.fadeIn,
        page: () => const SignupCaptcha(),
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: Routers.regOtp,
        page: () => const OtpPage(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: Routers.captcha,
        transition: Transition.fadeIn,
        page: () => const LoginCaptcha(),
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: Routers.otp,
        page: () => const Otp(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: Routers.mfa,
        page: () => const MfaOTP(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: Routers.index,
        page: () => const Index(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: Routers.legacy,
        transition: Transition.fadeIn,
        page: () => const LegacyUser(),
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: Routers.legacyEmail,
        transition: Transition.fadeIn,
        page: () => const CheckEmail(),
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: Routers.buy,
        page: () => const BuyPage(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: Routers.buySummary,
        transition: Transition.fadeIn,
        page: () => const BuySummary(),
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: Routers.buyOtp,
        page: () => const BuyOtp(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: Routers.buySuccess,
        transition: Transition.fadeIn,
        page: () => const BuySuccessPage(),
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: Routers.buyHistory,
        transition: Transition.fadeIn,
        page: () => const BuyOrderHistory(),
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: Routers.buyableAssets,
        transition: Transition.fadeIn,
        page: () => const BuyableAssets(),
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        transition: Transition.fadeIn,
        name: Routers.paymentSelection,
        page: () => const PaymentSelectionPage(),
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: Routers.actionBuy,
        transition: Transition.fadeIn,
        page: () => const ActionableBuy(),
        transitionDuration: const Duration(milliseconds: 500),
      ),

      /// KYC and Profile
      GetPage(
        name: Routers.kyc,
        page: () => const KycHome(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        transition: Transition.fadeIn,
        name: Routers.kycPersonalDetails,
        page: () => const PersonalDetails(),
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: Routers.docUpload,
        transition: Transition.fadeIn,
        page: () => const KycDocUpload(),
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: Routers.selfieInfo,
        transition: Transition.fadeIn,
        page: () => const KycSelfieInfo(),
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: Routers.selfieUpload,
        transition: Transition.fadeIn,
        page: () => const KycSelfieUpload(),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    ];
  }
}
