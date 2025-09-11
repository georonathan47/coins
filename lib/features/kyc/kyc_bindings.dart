import 'package:get/get.dart';

import 'data/datasources/kyc_local_database.dart';
import 'data/datasources/kyc_remote_database.dart';
import 'data/repositories/kyc_repo_impl.dart';
import 'domain/repositories/kyc_repository.dart';
import 'domain/usecases/check_status_usecase.dart';
import 'domain/usecases/initiate_kyc_usecase.dart';

class KycBindings extends Bindings {
  @override
  void dependencies() {
    Get
      // Data sources
      ..lazyPut<KycLocalDatabase>(() => KycLocalDatabaseImpl())
      ..lazyPut<KycRemoteDatabase>(
        () => KycRemoteDatabaseImpl(
          client: Get.find(),
          authRemoteDatabase: Get.find(),
        ),
      )
      // Repositories
      ..lazyPut<KycRepository>(
        () => KycRepositoryImpl(
          networkInfo: Get.find(),
          localDatabase: Get.find(),
          remoteDatabase: Get.find(),
          authLocalDatabase: Get.find(),
        ),
      )
      // Usecases
      ..lazyPut(() => InitiateKycUsecase(Get.find()))
      ..lazyPut(() => CheckKycStatusUsecase(Get.find()));
  }
}
