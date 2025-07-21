import 'data/datasources/sell_remote_database.dart';
import 'data/repositories/sell_repo_impl.dart';
import 'domain/repositories/sell_repository.dart';
import 'domain/usecases/create_sell_order_usecase.dart';
import 'domain/usecases/set_hash_usecase.dart';
import 'domain/usecases/verify_hash_usecase.dart';
import 'presentation/widgets/widgets.dart';

class SellBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<SellRemoteDatabase>(
        () => SellRemoteDatabaseImpl(
          client: Get.find<GetHttpClient>(),
          authRemoteDatabase: Get.find(),
        ),
      )
      ..lazyPut<SellRepository>(
        () => SellRepositoryImpl(
          networkInfo: Get.find(),
          remoteDatabase: Get.find(),
          authLocalDatabase: Get.find(),
        ),
      )
      ..lazyPut(() => SetHashUsecase(Get.find()))
      ..lazyPut(() => VerifyHashUsecase(Get.find()))
      ..lazyPut(() => CreateSellOrderUsecase(Get.find()));
  }
}
