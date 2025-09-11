import 'package:get/get.dart';

import 'data/datasources/news_remote_database.dart';
import 'data/repositories/news_repo_impl.dart';
import 'domain/repositories/news_repository.dart';
import 'domain/usecases/fetch_all_news_usecase.dart';
import 'domain/usecases/search_news_usecase.dart';

class NewsBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<NewsRepository>(
        () => NewsRepositoryImpl(
          networkInfo: Get.find(),
          remoteDatabase: Get.find(),
          authLocalDatabase: Get.find(),
        ),
      )
      ..lazyPut<NewsRemoteDatabase>(
        () => NewsRemoteDatabaseImpl(
          client: Get.find(),
          authRemoteDatabase: Get.find(),
        ),
      )
      ..lazyPut(() => SearchNewsUsecase(Get.find()))
      ..lazyPut(() => FetchAllNewsUsecase(Get.find()));
  }
}
