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

}
