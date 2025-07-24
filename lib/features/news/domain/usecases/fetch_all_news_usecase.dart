import 'package:fpdart/fpdart.dart';

import '../../../../core/shared/error/failures.dart';
import '../../../../core/shared/usecase/usecase.dart';
import '../entities/news.dart';
import '../repositories/news_repository.dart';

class FetchAllNewsUsecase extends UseCase<List<News>, NoParams> {
  final NewsRepository repository;
  FetchAllNewsUsecase(this.repository);

  @override
  Future<Either<Failure, List<News>>> call(NoParams params) {
    return repository.fetchNews();
  }
}
