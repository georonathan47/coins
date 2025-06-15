import 'package:flutter/cupertino.dart';

import '../../../../features/buy/domain/entities/country.dart';
import '../../../../features/buy/domain/usecases/fetch_countries_usecase.dart';
import '../../data/models/verify_otp_model.dart';
import '../../domain/usecases/fetch_user_info_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/refresh_token_usecase.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../../domain/usecases/retrieve_user.dart';
import '../../../usecase/usecase.dart';
import '../../domain/usecases/send_login_otp_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';
import '../../domain/usecases/verify_login_otp_usecase.dart';
import '../widgets/widgets.dart';

class AuthController extends GetxController {
  final rememberMe = false.obs;
  final captchaMessage = ''.obs;
  final currentUser = User.empty().obs;
  final loginKey = GlobalKey<FormState>().obs;
  final resetKey = GlobalKey<FormState>().obs;
  final signupKey = GlobalKey<FormState>().obs;
  static AuthController get instance => Get.find();

  final phoneController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final confirmController = TextEditingController().obs;
  final lastnameController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final firstnameController = TextEditingController().obs;

  final LoginUserUsecase loginUserUsecase;
  final LogoutUserUsecase logoutUserUsecase;
  final RefreshTokenUsecase refreshTokenUsecase;
  final RegisterUserUsecase registerUserUsecase;
  final RetrieveUserUsecase retrieveUserUsecase;
  final SendLoginOtpUseCase sendLoginOtpUseCase;
  final FetchUserInfoUsecase fetchUserInfoUsecase;
  final ResetPasswordUsecase resetPasswordUsecase;
  final FetchCountriesUsecase fetchCountriesUsecase;
  final VerifyLoginOtpUsecase verifyLoginOtpUsecase;

  AuthController({
    required this.loginUserUsecase,
    required this.logoutUserUsecase,
    required this.refreshTokenUsecase,
    required this.registerUserUsecase,
    required this.retrieveUserUsecase,
    required this.sendLoginOtpUseCase,
    required this.fetchUserInfoUsecase,
    required this.resetPasswordUsecase,
    required this.fetchCountriesUsecase,
    required this.verifyLoginOtpUsecase,
  });

  @override
  void onInit() {
    super.onInit();
    retrieveUser();
  }

  void clearControllers() {
    rememberMe.value = false;
    phoneController.value.clear();
    emailController.value.clear();
    confirmController.value.clear();
    lastnameController.value.clear();
    passwordController.value.clear();
    firstnameController.value.clear();
    resetKey.value.currentState?.reset();
    loginKey.value.currentState?.reset();
    signupKey.value.currentState?.reset();
  }

  @override
  void dispose() {
    clearControllers();
    super.dispose();
  }

  Future<User> retrieveUser() async {
    final result = await retrieveUserUsecase(NoParams());
    return result.fold((failure) => User.empty(), (success) {
      currentUser.value = success;
      update();
      return success;
    });
  }

  Future trySignup(User user) async {
    if (signupKey.value.currentState!.validate()) {
      if (passwordController.value.text != confirmController.value.text) {
        Get.snackbar(
          'Error',
          'Passwords do not match',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      } else {
        final result = await registerUserUsecase(ObjectParams(user));
        Get.back();
        return result.fold(
          (failure) {
            Get.snackbar(
              'Error',
              failure.message,
              snackPosition: SnackPosition.BOTTOM,
            );
          },
          (success) async {
            switch (success.userId! > 0) {
              case true:
                Get.toNamed(Routers.regOtp, arguments: success);
                break;
              default:
                THelperFunctions.showSnackBar(
                  bgColor: TColors.error,
                  title: 'Registration Error',
                  message:
                      'Failed to register your account... Please try again later!',
                );
            }
          },
        );
      }
    }
  }

  Future<User> fetchUserDetails() async {
    final result = await fetchUserInfoUsecase(NoParams());
    return result.fold((failure) => Future.error(failure.message), (
      success,
    ) async {
      final country = await countries().then(
        (countries) => countries.firstWhere(
          (country) => country.id == success.countryId,
          orElse: () => Country.empty(),
        ),
      );
      currentUser.value = success.copyWith(country: country.countryName);
      update();
      return success;
    });
  }

  Future tryLogin() async {
    if (loginKey.value.currentState!.validate()) {
      final user = currentUser.value.copyWith(
        rememberMe: rememberMe.value,
        email: emailController.value.text,
        captchaResponse: captchaMessage.value,
        password: passwordController.value.text,
      );
      update();
      final result = await loginUserUsecase(ObjectParams(user));
      Get.back();
      return result.fold(
        (failure) {
          THelperFunctions.showSnackBar(
            message: failure.message,
            title: 'Login Failed...',
            bgColor: TColors.error,
          );
        },
        (success) {
          switch (success.mfaEnabled) {
            case true:
              Get.toNamed(Routers.mfa);
              break;
            default:
              switch (success.legacyUser) {
                case true:
                  Get.offNamed(Routers.legacy);
                  break;
                default:
                  sendOtp(success.userId!);
                  Get.offNamed(Routers.otp);
              }
          }
        },
      );
    }
  }

  Future<void> logout() async {
    final result = await logoutUserUsecase(NoParams());
    return result.fold(
      (failure) {
        Get.snackbar(
          'Error',
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      (success) {
        Navigator.pop(Get.context!);
        Get.offAllNamed(Routers.login);
        THelperFunctions.showSnackBar(
          title: 'Logged Out',
          message: 'You have successfully logged out.',
          bgColor: TColors.success,
        );
      },
    );
  }

  Future<String> resetPassword(ResetPassword request) async {
    final result = await resetPasswordUsecase(ObjectParams(request));
    Get.back();
    return result.fold(
      (failure) {
        Get.snackbar(
          'Error',
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
        );
        return failure.message;
      },
      (success) {
        THelperFunctions.showSnackBar(
          title: 'Password Reset',
          message: 'A password reset link has been sent to your email.',
          bgColor: TColors.success,
        );
        Get.offAllNamed(Routers.login);
        clearControllers();
        return success;
      },
    );
  }

  Future<String> sendOtp(int userId) async {
    final result = await sendLoginOtpUseCase(ObjectParams(userId));
    Get.back();
    return result.fold(
      (failure) {
        THelperFunctions.showSnackBar(
          message: failure.message,
          title: 'Login Failed...',
          bgColor: TColors.error,
        );
        return failure.message;
      },
      (success) {
        THelperFunctions.showSnackBar(
          title: 'OTP Sent',
          message: 'An OTP has been sent to your email.',
          bgColor: TColors.success,
        );
        Get.toNamed(Routers.otp, arguments: userId);
        clearControllers();
        return success;
      },
    );
  }

  Future<String> verifyOtp(VerifyOtpModel otp) async {
    final result = await verifyLoginOtpUsecase(ObjectParams(otp));

    Get.back();
    return result.fold(
      (failure) {
        THelperFunctions.showSnackBar(
          message: failure.message,
          title: 'Login Failed...',
          bgColor: TColors.error,
        );
        return failure.message;
      },
      (success) async {
        await fetchUserDetails();
        THelperFunctions.showSnackBar(
          title: 'Login Successful',
          message: 'You have successfully logged in.',
          bgColor: TColors.success,
        );
        Get.offAllNamed(Routers.index);
        clearControllers();
        return success;
      },
    );
  }

  Future showLogoutDialog() async {
    final textTheme = Get.textTheme;
    final size = MediaQuery.sizeOf(Get.context!);
    showCupertinoModalPopup(
      context: Get.context!,
      builder: (_) {
        return AlertDialog(
          title: Center(
            child: Text(
              '🤔 Confirm Logout...',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: SizedBox(
            height: MediaQuery.sizeOf(Get.context!).height * 0.075,
            child: Text(
              'Are you sure you want to log out of your account?',
              style: textTheme.bodyLarge,
            ),
          ),
          actions: [
            OutlinedButton.icon(
              icon: const Icon(Icons.thumb_down_alt_rounded),
              label: Text(
                'Cancel',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () => Get.back(),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: size.width * 0.3,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: TColors.white,
                  backgroundColor: TColors.error,
                ),
                onPressed: () async {
                  Get.back();
                  showDialog(
                    context: Get.context!,
                    barrierDismissible: false,
                    builder: (context) {
                      return const Center(child: CircularProgressIndicator());
                    },
                  );
                  await logout();
                },
                child: Text(
                  'Logout',
                  style: textTheme.titleMedium?.copyWith(
                    color: TColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<List<Country>> countries() async {
    final countries = await fetchCountriesUsecase(NoParams());
    return countries.fold(
      (failure) => Future.error(failure.message),
      (success) => success,
    );
  }
}
