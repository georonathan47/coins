import '../../../features/kyc/data/datasources/kyc_local_database.dart';
import '../../../features/kyc/domain/entities/kyc_status.enum.dart';
import '../../auth/data/datasources/auth_local_database.dart';
import '../../auth/presentation/widgets/widgets.dart';
import '../utils/logger.dart';

class AuthGuard {
  final AuthLocalDatabase authLocalDatabase;
  final KycLocalDatabase kycLocalDatabase;

  AuthGuard({required this.authLocalDatabase, required this.kycLocalDatabase});

  Future<void> checkAuthAndExecute(VoidCallback action) async {
    final isLoggedIn = await authLocalDatabase.authenticationStatus();
    if (isLoggedIn) {
      action();
    } else {
      Get.toNamed(Routers.login);
    }
  }

  Future<void> checkKycAndExecute(VoidCallback action) async {
    final status = await kycLocalDatabase.getStatus();
    TLoggerHelper.logEvent(
      'KYC Status: $status',
      eventName: 'KYC Status Check',
    );
    if (status == KycStatus.none || status == KycStatus.rejected) {
      Get.toNamed(Routers.kyc);
    } else if (status == KycStatus.pending) {
      showAdaptiveDialog(
        context: Get.context!,
        builder: (ctx) {
          return AlertDialog(
            title: Text('KYC Under Review'),
            content: Text(
              'Your KYC verification is under review. It will take the team 3-5 business days to review your application. You will receive an email once your application is approved or rejected.',
            ),
            actions: [
              TextButton(onPressed: () => Get.back(), child: Text('OK')),
            ],
          );
        },
      );
    } else if (status == KycStatus.approved) {
      // Get.toNamed(Routers.kycSuccess);
      action();
    } else {
      showAdaptiveDialog(
        context: Get.context!,
        builder: (ctx) {
          return AlertDialog(
            title: Text('KYC Not Submitted'),
            content: Text(
              'You need to complete your KYC verification before proceeding. Please verify your KYC to continue.',
            ),
            actions: [
              TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
              TextButton(
                onPressed: () => Get.toNamed(Routers.kyc),
                child: Text('Verify KYC'),
              ),
            ],
          );
        },
      );
    }
  }
}
