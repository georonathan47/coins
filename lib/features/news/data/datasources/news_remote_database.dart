import 'dart:convert';

import 'package:get/get_connect/connect.dart';

import '../../../../core/auth/data/datasources/auth_remote_database.dart';
import '../../../../core/shared/constants/env.dart';
import '../../../../core/shared/error/exception.dart';
import '../../../../core/shared/utils/logger.dart';
import '../../domain/entities/news.dart';

abstract class NewsRemoteDatabase {
  Future<List<News>> fetchAll(Map tokens);
  Future<List<News>> search(String query, Map tokens);
}

class NewsRemoteDatabaseImpl implements NewsRemoteDatabase {
  final GetHttpClient client;
  final AuthRemoteDatabase authRemoteDatabase;
  NewsRemoteDatabaseImpl({
    required this.client,
    required this.authRemoteDatabase,
  });

  @override
  Future<List<News>> fetchAll(Map tokens) async {
    try {
      final result = await client.get(
        Env.fetchAllNewsUrl,
        headers: {'Authorization': 'Bearer ${tokens['accessToken']}'},
      );
      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        final List<dynamic> responseData = jsonDecode(result.bodyString!);
        List<News> allNews = responseData
            .map((country) => newsFromJson(jsonEncode(country)))
            .toSet()
            .toList();
        TLoggerHelper.logApiResult(
          code: result.statusCode!,
          httpMethod: 'GET',
          method: 'fetchAll',
          message: '${allNews.length} news items fetched!',
        );
        return allNews;
      } else if (result.statusCode! == 401) {
        TLoggerHelper.logRefreshAttempt(
          'fetchAll',
          statusCode: result.statusCode!,
        );
        try {
          final token = await authRemoteDatabase.refreshToken(tokens);
          // Update the existing map instead of creating a new one
          tokens['accessToken'] = token.accessToken;
          tokens['refreshToken'] = token.refreshToken;
          return fetchAll(tokens);
        } catch (e) {
          throw ServerException(result.statusText!);
        }
      } else {
        throw ServerException(result.statusText!);
      }
    } catch (e) {
      throw DeviceException('Unexpected Error!\nPlease try again later');
    }
  }

  @override
  Future<List<News>> search(String query, Map tokens) async {
    try {
      final result = await client.get(
        '${Env.searchNewsUrl}$query',
        headers: {'Authorization': 'Bearer ${tokens['accessToken']}'},
      );
      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        final List<dynamic> responseData = jsonDecode(result.bodyString!);
        List<News> search = responseData
            .map((country) => newsFromJson(jsonEncode(country)))
            .toSet()
            .toList();
        return search;
      } else if (result.statusCode! == 401) {
        TLoggerHelper.logRefreshAttempt(
          'search news',
          statusCode: result.statusCode!,
        );
        try {
          final token = await authRemoteDatabase.refreshToken(tokens);
          // Update the existing map instead of creating a new one
          tokens['accessToken'] = token.accessToken;
          tokens['refreshToken'] = token.refreshToken;
          return search(query, tokens);
        } catch (e) {
          throw ServerException(result.statusText!);
        }
      } else {
        throw ServerException(result.statusText!);
      }
    } catch (e) {
      throw DeviceException('Unexpected Error!\nPlease try again later');
    }
  }
}
