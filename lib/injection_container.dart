import 'core/shared/binding_imports.dart';
import 'features/news/news_bindings.dart';
import 'features/profile/profile_bindings.dart';

void initBindings() {
  BaseBindings().dependencies();
  BuyBindings().dependencies();
  KycBindings().dependencies();
  AuthBindings().dependencies();
  SellBindings().dependencies();
  NewsBindings().dependencies();
  ProfileBindings().dependencies();
  PaymentBindings().dependencies();
  HomepageBindings().dependencies();
  OnboardingBindings().dependencies();
  GeneralBindings().dependencies();
}
