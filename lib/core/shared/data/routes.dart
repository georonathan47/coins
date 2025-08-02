import '../../../features/news/presentation/pages/news_details.dart';
import '../../../features/payment/presentation/pages/add_bank_account.dart';
import '../../../features/payment/presentation/pages/welcome_page.dart';
import '../../../features/sell/presentation/pages/history.dart';
import '../../../features/sell/presentation/pages/success.dart';
import 'data.dart';

class Routers {
  static const buy = '/buy';
  static const kyc = '/kyc';
  static const otp = '/otp';
  static const mfa = '/mfa';
  static const sell = '/sell';
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
  static const sellPay = '/sellPay';
  static const register = '/register';
  static const homepage = '/homepage';
  static const settings = '/settings';
  static const docUpload = '/docUpload';
  static const actionBuy = '/actionBuy';
  static const actionSell = '/actionSell';
  static const buyHistory = '/buyHistory';
  static const buySuccess = '/buySuccess';
  static const buySummary = '/buySummary';
  static const kycSuccess = '/kycSuccess';
  static const regCaptcha = '/regCaptcha';
  static const selfieInfo = '/selfieInfo';
  static const legacyEmail = '/legacyEmail';
  static const newsDetails = '/newsDetails';
  static const payAccounts = '/payAccounts';
  static const sellHistory = '/sellHistory';
  static const sellSuccess = '/sellSuccess';
  static const selfieUpload = '/selfieUpload';
  static const buyableAssets = '/buyableAssets';
  static const addMomoAccount = '/addMomoAccount';
  static const addBankAccount = '/addBankAccount';
  static const transactionInfo = '/transactionInfo';
  static const paymentSelection = '/paymentSelection';
  static const kycPersonalDetails = '/kycPersonalDetails';
}

class RouteManager {
  static const initial = Routers.splash;

  static List<GetPage> getPages() {
    return [
      // Onboarding and Auth
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

      /// Buy
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
      GetPage(
        name: Routers.kycSuccess,
        transition: Transition.fadeIn,
        page: () => const KycSuccess(),
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: Routers.transactionInfo,
        transition: Transition.fadeIn,
        page: () => const TransactionInfoPage(),
        transitionDuration: const Duration(milliseconds: 500),
      ),

      /// Sell
      GetPage(
        name: Routers.actionSell,
        transition: Transition.fadeIn,
        page: () => const ActionableSell(),
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: Routers.sell,
        page: () => const SellPage(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: Routers.sellPay,
        transition: Transition.fadeIn,
        page: () => const SellPaymentPage(),
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: Routers.sellSuccess,
        transition: Transition.fadeIn,
        page: () => const SellSuccessPage(),
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: Routers.sellHistory,
        transition: Transition.fadeIn,
        page: () => const SellOrderHistory(),
        transitionDuration: const Duration(milliseconds: 500),
      ),

      /// News
       GetPage(
        name: Routers.newsDetails,
        transition: Transition.fadeIn,
        page: () => const NewsDetails(),
        transitionDuration: const Duration(milliseconds: 500),
      ),

      ///  PayAccounts
      GetPage(
        name: Routers.payAccounts,
        transition: Transition.fadeIn,
        page: () => const PayAccountsWelcomePage(),
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: Routers.addBankAccount,
        transition: Transition.fadeIn,
        page: () => const AddBankAccount(),
        transitionDuration: const Duration(milliseconds: 500),
      ),
      // GetPage(
      //   name: Routers.addMomoAccount,
      //   transition: Transition.fadeIn,
      //   page: () => const AddMomoAccount(),
      //   transitionDuration: const Duration(milliseconds: 500),
      // ),
    ];
  }
}
