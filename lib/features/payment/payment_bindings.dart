import 'package:get/get.dart';

import 'data/datasources/payment_remote_database.dart';
import 'data/repositories/payment_repo_impl.dart';
import 'domain/repositories/payment_repository.dart';
import 'domain/usecases/get_payment_details_usecase.dart';

class PaymentBindings extends Bindings {
  @override
  void dependencies() {
    Get
      // ..lazyPut<BuyLocalDatabase>(() => BuyLocalDatabaseImpl(Get.find()))
      ..lazyPut<PaymentRemoteDatabase>(
        () => PaymentRemoteDatabaseImpl(
          client: Get.find(),
          authRemoteDatabase: Get.find(),
        ),
      )
      // ? Repository
      ..lazyPut<PaymentRepository>(
        () => PaymentRepositoryImpl(
          networkInfo: Get.find(),
          remoteDatabase: Get.find(),
          authLocalDatabase: Get.find(),
        ),
      )
      // ..lazyPut(() => FetchMomoUsecase(Get.find()))
      // ..lazyPut(() => FetchBanksUsecase(Get.find()))
      // ..lazyPut(() => CalculateFeeUsecase(Get.find()))
      // ..lazyPut(() => FetchListingsUsecase(Get.find()))
      // ..lazyPut(() => CreateBuyOrderUsecase(Get.find()))
      // ..lazyPut(() => FetchCountriesUsecase(Get.find()))
      // ..lazyPut(() => FetchCurrenciesUsecase(Get.find()))
      // ..lazyPut(() => FetchPaymentModesUsecase(Get.find()))
      ..lazyPut(() => GetPaymentDetailsUsecase(Get.find()));
  }
}
