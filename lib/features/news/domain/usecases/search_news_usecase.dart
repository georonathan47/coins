import 'package:fpdart/fpdart.dart';

import '../../../../core/shared/error/failures.dart';
import '../../../../core/shared/usecase/usecase.dart';
import '../entities/news.dart';
import '../repositories/news_repository.dart';

class SearchNewsUsecase extends UseCase<List<News>, ObjectParams<String>> {
  final NewsRepository repository;
  SearchNewsUsecase(this.repository);

  @override
  Future<Either<Failure, List<News>>> call(ObjectParams<String> params) {
    return repository.getNews(params.value);
  }
}
