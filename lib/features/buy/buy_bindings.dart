import 'data/datasources/buy_local_database.dart';
import 'data/datasources/buy_remote_database.dart';
import 'data/datasources/currency_local_database.dart';
import 'data/repositories/buy_repo_impl.dart';
import 'domain/repositories/buy_repository.dart';
import 'domain/usecases/create_order_usecase.dart';
import 'domain/usecases/fee_calculation_usecase.dart';
import 'domain/usecases/fetch_banks_usecase.dart';
import 'domain/usecases/fetch_buy_history_usecase.dart';
import 'domain/usecases/fetch_countries_usecase.dart';
import 'domain/usecases/fetch_currencies_usecase.dart';
import 'domain/usecases/fetch_listings_usecase.dart';
import 'domain/usecases/fetch_momo_list_usecase.dart';
import 'domain/usecases/fetch_payment_modes_usecase.dart';
import 'domain/usecases/fetch_tradable_usecase.dart';
import 'presentation/widgets/widgets.dart';

class BuyBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<BuyLocalDatabase>(() => BuyLocalDatabaseImpl(Get.find()))
      ..lazyPut<BuyRemoteDatabase>(
        () => BuyRemoteDatabaseImpl(
          client: Get.find(),
          authRemoteDatabase: Get.find(),
        ),
      )
      ..lazyPut<CurrencyLocalDatabase>(
        () => CurrencyLocalDatabaseImpl(Get.find()),
      )
      // ? Repository
      ..lazyPut<BuyRepository>(
        () => BuyRepositoryImpl(
          networkInfo: Get.find(),
          localDatabase: Get.find(),
          remoteDatabase: Get.find(),
          authLocalDatabase: Get.find(),
          currencyLocalDatabase: Get.find(),
        ),
      )
      ..lazyPut(() => FetchMomoUsecase(Get.find()))
      ..lazyPut(() => FetchBanksUsecase(Get.find()))
      ..lazyPut(() => CalculateFeeUsecase(Get.find()))
      ..lazyPut(() => FetchListingsUsecase(Get.find()))
      ..lazyPut(() => CreateBuyOrderUsecase(Get.find()))
      ..lazyPut(() => FetchCountriesUsecase(Get.find()))
      ..lazyPut(() => FetchBuyHistoryUsecase(Get.find()))
      ..lazyPut(() => FetchCurrenciesUsecase(Get.find()))
      ..lazyPut(() => FetchPaymentModesUsecase(Get.find()))
      ..lazyPut(() => FetchTradableCoinsUsecase(Get.find()));
  }
}
