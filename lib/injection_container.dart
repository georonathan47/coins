import 'core/shared/binding_imports.dart';

void initBindings() {
  BaseBindings().dependencies();
  BuyBindings().dependencies();
  KycBindings().dependencies();
  AuthBindings().dependencies();
  SellBindings().dependencies();
  PaymentBindings().dependencies();
  HomepageBindings().dependencies();
  OnboardingBindings().dependencies();
  GeneralBindings().dependencies();
}
