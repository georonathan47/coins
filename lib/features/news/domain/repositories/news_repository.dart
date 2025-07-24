import 'package:fpdart/fpdart.dart';

import '../../../../core/shared/error/failures.dart';
import '../entities/news.dart';

abstract class NewsRepository {
  /// Fetches news based on the provided search query.
  Future<Either<Failure, List<News>>> getNews(String searchQuery);

  /// Fetches all new.
  Future<Either<Failure, List<News>>> fetchNews();
}
