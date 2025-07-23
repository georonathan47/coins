import 'package:fpdart/fpdart.dart';

import '../../../../core/auth/data/datasources/auth_local_database.dart';
import '../../../../core/shared/constants/text_strings.dart';
import '../../../../core/shared/error/exception.dart';
import '../../../../core/shared/error/failures.dart';
import '../../../../core/shared/platform/network_info.dart';
import '../../domain/entities/news.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/news_remote_database.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NetworkInfo networkInfo;
  final NewsRemoteDatabase remoteDatabase;
  final AuthLocalDatabase authLocalDatabase;

  NewsRepositoryImpl({
    required this.networkInfo,
    required this.remoteDatabase,
    required this.authLocalDatabase,
  });

  @override
  Future<Either<Failure, List<News>>> fetchNews() async {
    try {
      if (await networkInfo.hasInternet()) {
        final tokens = await authLocalDatabase.fetchTokens();
        final response = await remoteDatabase.fetchAll(tokens);
        return Right(response);
      } else {
        return Left(NetworkFailure(TTexts.noInternetMessage));
      }
    } on NoResultException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<News>>> getNews(String searchQuery) async {
    try {
      if (await networkInfo.hasInternet()) {
        final tokens = await authLocalDatabase.fetchTokens();
        final response = await remoteDatabase.search(searchQuery, tokens);
        return Right(response);
      } else {
        return Left(NetworkFailure(TTexts.noInternetMessage));
      }
    } on NoResultException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
