import 'core/auth/auth_bindings.dart';
import 'core/onboarding/onboarding_bindings.dart';
import 'core/utils/bindings/base_bindings.dart';
import 'core/utils/bindings/general_bindings.dart';
import 'features/buy/buy_bindings.dart';
import 'features/homepage/homepage_bindings.dart';
import 'features/kyc/kyc_bindings.dart';
import 'features/payment/payment_bindings.dart';

void initBindings() {
  BaseBindings().dependencies();
  BuyBindings().dependencies();
  KycBindings().dependencies();
  AuthBindings().dependencies();
  PaymentBindings().dependencies();
  HomepageBindings().dependencies();
  OnboardingBindings().dependencies();
  GeneralBindings().dependencies();
}
