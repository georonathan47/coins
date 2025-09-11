import 'presentation/widgets/widgets.dart';

class ProfileBindings extends Bindings {
  @override
  void dependencies() {
    // Get
      // ..lazyPut<NewsRepository>(
      //   () => NewsRepositoryImpl(
      //     networkInfo: Get.find(),
      //     remoteDatabase: Get.find(),
      //     authLocalDatabase: Get.find(),
      //   ),
      // )
      // ..lazyPut<NewsRemoteDatabase>(
      //   () => NewsRemoteDatabaseImpl(
      //     client: Get.find(),
      //     authRemoteDatabase: Get.find(),
      //   ),
      // )
      // ..lazyPut(() => SearchNewsUsecase(Get.find()))
      // ..lazyPut(() => FetchAllNewsUsecase(Get.find()));
  }
}
