import 'package:get/get.dart';

import 'data/datasources/auth_local_database.dart';
import 'data/datasources/auth_remote_database.dart';
import 'data/repositories/auth_repo_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/fetch_user_info_usecase.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/logout_usecase.dart';
import 'domain/usecases/refresh_token_usecase.dart';
import 'domain/usecases/reset_password_usecase.dart';
import 'domain/usecases/retrieve_user.dart';
import 'domain/usecases/save_user_usecase.dart';
import 'domain/usecases/send_login_otp_usecase.dart';
import 'domain/usecases/signup_usecase.dart';
import 'domain/usecases/update_profile_usecase.dart';
import 'domain/usecases/verify_login_otp_usecase.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get
      // ? Data
      ..lazyPut<AuthRemoteDatabase>(
        () => AuthRemoteDatabaseImpl(client: Get.find()),
      )
      ..lazyPut<AuthLocalDatabase>(() => AuthLocalDatabaseImpl(Get.find()))
      // ? Repository
      ..lazyPut<AuthRepository>(
        () => AuthRepoImpl(
          networkInfo: Get.find(),
          localDatabase: Get.find(),
          remoteDatabase: Get.find(),
        ),
      )
      // ? Usecase
      ..lazyPut(() => LoginUserUsecase(Get.find()))
      ..lazyPut(() => LogoutUserUsecase(Get.find()))
      ..lazyPut(() => UpdateUserUsecase(Get.find()))
      ..lazyPut(() => RetrieveUserUsecase(Get.find()))
      ..lazyPut(() => RegisterUserUsecase(Get.find()))
      ..lazyPut(() => RefreshTokenUsecase(Get.find()))
      ..lazyPut(() => SaveUserInfoUsecase(Get.find()))
      ..lazyPut(() => SendLoginOtpUseCase(Get.find()))
      ..lazyPut(() => FetchUserInfoUsecase(Get.find()))
      ..lazyPut(() => ResetPasswordUsecase(Get.find()))
      ..lazyPut(() => VerifyLoginOtpUsecase(Get.find()));
  }
}
