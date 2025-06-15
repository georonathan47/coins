import 'package:get/get.dart';

import '../../features/homepage/presentation/pages/index.dart';
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
  static const otp = '/otp';
  static const mfa = '/mfa';
  static const edit = '/edit';
  static const index = '/index';
  static const login = '/login';
  static const reset = '/reset';
  static const splash = '/splash';
  static const legacy = '/legacy';
  static const regOtp = '/regOtp';
  static const captcha = '/captcha';
  static const onboard = '/onboard';
  static const profile = '/profile';
  static const register = '/register';
  static const homepage = '/homepage';
  static const settings = '/settings';
  static const regCaptcha = '/regCaptcha';
  static const legacyEmail = '/legacyEmail';
}

class RouteManager {
  static const initial = Routers.index;

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
    ];
  }
}
