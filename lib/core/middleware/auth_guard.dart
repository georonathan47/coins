import '../auth/data/datasources/auth_local_database.dart';
import '../auth/presentation/widgets/widgets.dart';

class AuthGuard {
  final AuthLocalDatabase authLocalDatabase;

  AuthGuard(this.authLocalDatabase);

  Future<void> checkAuthAndExecute(VoidCallback action) async {
    final isLoggedIn = await authLocalDatabase.authenticationStatus();
    if (isLoggedIn) {
      action();
    } else {
      Get.toNamed(Routers.login);
    }
  }

  Future<void> checkKycAndExecute(VoidCallback action) async {
    final isKycVerified = await authLocalDatabase.authenticationStatus();
    if (isKycVerified) {
      action();
    } else {
      Get.toNamed(Routers.kyc);
    }
  }
}
