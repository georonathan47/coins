import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'assets/configs/dev.env', requireEnvFile: true)
abstract class Env {
  @EnviedField(varName: 'BASEURL')
  static const String baseUrl = _Env.baseUrl;
  @EnviedField(varName: 'MAIN_URL')
  static const String mainUrl = _Env.mainUrl;
  @EnviedField(varName: 'AUTH_URL')
  static const String authUrl = _Env.authUrl;
  @EnviedField(varName: 'USER_URL')
  static const String userUrl = _Env.userUrl;
  @EnviedField(varName: 'BANK_LIST')
  static const String bankListUrl = _Env.bankListUrl;
  @EnviedField(varName: 'CAPTCHA_URL')
  static const String captchaUrl = _Env.captchaUrl;
  @EnviedField(varName: 'REGISTER_URL')
  static const String registerUrl = _Env.registerUrl;
  @EnviedField(varName: 'LOGIN')
  static const String loginUrl = _Env.loginUrl;
  @EnviedField(varName: 'LOGOUT')
  static const String logoutUrl = _Env.logoutUrl;
  @EnviedField(varName: 'REFRESH_TOKEN')
  static const String refreshTokenUrl = _Env.refreshTokenUrl;
  @EnviedField(varName: 'USER_DETAILS')
  static const String userDetailsUrl = _Env.userDetailsUrl;
  @EnviedField(varName: 'VERIFY_MAIL')
  static const String verifyEmailUrl = _Env.verifyEmailUrl;
  @EnviedField(varName: 'VERIFY_OTP')
  static const String verifyOtpUrl = _Env.verifyOtpUrl;
  @EnviedField(varName: 'SEND_OTP')
  static const String sendOtpUrl = _Env.sendOtpUrl;
  @EnviedField(varName: 'SEND_MAIL')
  static const String sendMailUrl = _Env.sendMailUrl;
  @EnviedField(varName: 'KYC_URL')
  static const String kycUrl = _Env.kycUrl;
  @EnviedField(varName: 'GUARDIAN')
  static const String guardian = _Env.guardian;
  @EnviedField(varName: 'VECTOR')
  static const String vector = _Env.vector;
  @EnviedField(varName: 'AUTHENTICATE')
  static const String authenticateUrl = _Env.authenticateUrl;
  @EnviedField(varName: 'GOOGLE_LOGIN')
  static const String googleLoginUrl = _Env.googleLoginUrl;
  @EnviedField(varName: 'MFA')
  static const String mfaUrl = _Env.mfaUrl;
  @EnviedField(varName: 'ACTIVATE_COUNTRIES')
  static const String activateCountriesUrl = _Env.activateCountriesUrl;
  @EnviedField(varName: 'BUY_URL')
  static const String buyUrl = _Env.buyUrl;
  @EnviedField(varName: 'SPECIFIC_CURRENCY')
  static const String specificCurrencyUrl = _Env.specificCurrencyUrl;
  @EnviedField(varName: 'COIN_DATA')
  static const String listingsUrl = _Env.listingsUrl;
  @EnviedField(varName: 'TRADABLE_CURRENCIES')
  static const String tradableCurrenciesUrl = _Env.tradableCurrenciesUrl;
  @EnviedField(varName: 'CHECK_STATUS')
  static const String checkStatusUrl = _Env.checkStatusUrl;
  @EnviedField(varName: 'PAYMENT_MODES')
  static const String paymentModesUrl = _Env.paymentModesUrl;
  @EnviedField(varName: 'MOMO_LIST')
  static const String momoListUrl = _Env.momoListUrl;
  @EnviedField(varName: 'PAYMENT_DETAILS')
  static const String paymentDetailsUrl = _Env.paymentDetailsUrl;
  @EnviedField(varName: 'CREATE_BUY_ORDER')
  static const String createBuyOrderUrl = _Env.createBuyOrderUrl;
  @EnviedField(varName: 'CREATE_SELL_ORDER')
  static const String createSellOrderUrl = _Env.createSellOrderUrl;
  @EnviedField(varName: 'SET_HASH')
  static const String setHashIdUrl = _Env.setHashIdUrl;
  @EnviedField(varName: 'BUY_ORDER_HISTORY')
  static const String buyHistoryUrl = _Env.buyHistoryUrl;
  @EnviedField(varName: 'SELL_ORDER_HISTORY')
  static const String sellHistoryUrl = _Env.sellHistoryUrl;
  @EnviedField(varName: 'WALLET_DETAILS')
  static const String walletInfoUrl = _Env.walletInfoUrl;
  @EnviedField(varName: 'FETCH_PAYMENT_DETAILS')
  static const String userPaymentDetailsUrl = _Env.userPaymentDetailsUrl;
  @EnviedField(varName: 'FETCH_ALL_NEWS')
  static const String fetchAllNewsUrl = _Env.fetchAllNewsUrl;
  @EnviedField(varName: 'SEARCH_NEWS')
  static const String searchNewsUrl = _Env.searchNewsUrl;
  @EnviedField(varName: 'ADD_PAYMENT_DETAILS')
  static const String addPayAccountUrl = _Env.addPayAccountUrl;
}
