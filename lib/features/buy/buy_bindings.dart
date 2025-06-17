import 'data/datasources/buy_remote_database.dart';
import 'data/repositories/buy_repo_impl.dart';
import 'domain/repositories/buy_repository.dart';
import 'domain/usecases/fee_calculation_usecase.dart';
import 'domain/usecases/fetch_countries_usecase.dart';
import 'domain/usecases/fetch_currencies_usecase.dart';
import 'domain/usecases/fetch_listings_usecase.dart';
import 'domain/usecases/fetch_tradable_usecase.dart';
import 'presentation/widgets/widgets.dart';

class BuyBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<BuyRemoteDatabase>(() => BuyRemoteDatabaseImpl(Get.find()))
      // ? Repository
      ..lazyPut<BuyRepository>(
        () => BuyRepositoryImpl(
          networkInfo: Get.find(),
          localDatabase: Get.find(),
          remoteDatabase: Get.find(),
        ),
      )
      ..lazyPut(() => CalculateFeeUsecase(Get.find()))
      ..lazyPut(() => FetchListingsUsecase(Get.find()))
      ..lazyPut(() => FetchCountriesUsecase(Get.find()))
      ..lazyPut(() => FetchCurrenciesUsecase(Get.find()))
      ..lazyPut(() => FetchTradableCoinsUsecase(Get.find()));
  }
}
