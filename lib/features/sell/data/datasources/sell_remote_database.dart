import 'dart:convert';

import 'package:get/get_connect.dart';

import '../../../../core/auth/data/datasources/auth_remote_database.dart';
import '../../../../core/shared/constants/env.dart';
import '../../../../core/shared/error/exception.dart';
import '../../../../core/shared/utils/logger.dart';
import '../../domain/entities/create_sell_order.dart';
import '../../domain/entities/set_transaction_hash.dart';
import '../models/sell_history_model.dart';
import '../models/sell_order_response.dart';

abstract class SellRemoteDatabase {
  Future<List<SellHistoryModel>> fetchOrderHistory(Map tokens);
  Future<String> setHash(SetTransactionHash order, Map tokens);
  Future<String> verifyHash(String transactionHash, Map tokens);
  Future<SellOrderResponse> createOrder(SellOrder order, Map tokens);
}

class SellRemoteDatabaseImpl implements SellRemoteDatabase {
  final GetHttpClient client;
  final AuthRemoteDatabase authRemoteDatabase;

  SellRemoteDatabaseImpl({
    required this.client,
    required this.authRemoteDatabase,
  });

  @override
  Future<String> setHash(SetTransactionHash request, Map tokens) async {
    try {
      final result = await client.post(
        Env.setHashIdUrl,
        body: jsonEncode(request.toJson()),
        headers: {'Authorization': 'Bearer ${tokens['accessToken']}'},
      );
      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        TLoggerHelper.logApiResult(
          httpMethod: 'POST',
          method: 'set hash id',
          code: result.statusCode!,
          message: result.bodyString!,
        );
        return result.bodyString!;
      } else if (result.statusCode! == 401) {
        TLoggerHelper.logRefreshAttempt(
          'setHash',
          statusCode: result.statusCode!,
        );
        try {
          final token = await authRemoteDatabase.refreshToken(tokens);
          // Update the existing map instead of creating a new one
          tokens['accessToken'] = token.accessToken;
          tokens['refreshToken'] = token.refreshToken;
          return setHash(request, tokens);
        } catch (e) {
          throw ServerException(result.statusText!);
        }
      } else if (result.statusCode == 409) {
        final message = jsonDecode(result.bodyString!);
        throw ConflictException(message['message']);
      } else {
        throw ServerException(result.statusText!);
      }
    } catch (e, s) {
      TLoggerHelper.logError(
        error: e,
        stackTrace: s,
        message: 'Request failed',
        method: 'Set Hash Id',
        eventName: 'setHash',
      );
      throw DeviceException('Unexpected Error!\nPlease try again later');
    }
  }

  @override
  Future<String> verifyHash(String transactionHash, Map tokens) async {
    try {
      final result = await client.post(
        Env.setHashIdUrl,
        body: jsonEncode({'transactionHas': transactionHash}),
        headers: {'Authorization': 'Bearer ${tokens['accessToken']}'},
      );
      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        TLoggerHelper.logApiResult(
          httpMethod: 'POST',
          method: 'verify hash id',
          code: result.statusCode!,
          message: result.bodyString!,
        );
        return result.bodyString!;
      } else if (result.statusCode! == 401) {
        TLoggerHelper.logRefreshAttempt(
          'setHash',
          statusCode: result.statusCode!,
        );
        try {
          final token = await authRemoteDatabase.refreshToken(tokens);
          // Update the existing map instead of creating a new one
          tokens['accessToken'] = token.accessToken;
          tokens['refreshToken'] = token.refreshToken;
          return verifyHash(transactionHash, tokens);
        } catch (e) {
          // ToDo: get a fix for this later.
          throw ServerException(e.toString());
        }
      } else if (result.statusCode == 409) {
        final message = jsonDecode(result.bodyString!);
        throw ConflictException(message['message']);
      } else {
        throw ServerException(result.statusText!);
      }
    } catch (e, s) {
      TLoggerHelper.logError(
        error: e,
        stackTrace: s,
        message: 'Request failed',
        method: 'Verify Hash Id',
        eventName: 'verifyHash',
      );
      throw DeviceException(
        e is ConflictException
            ? e.message
            : 'Unexpected Error!\nPlease try again later',
      );
    }
  }

  @override
  Future<SellOrderResponse> createOrder(SellOrder request, Map tokens) async {
    try {
      TLoggerHelper.logEvent(
        request.toJson(),
        eventName: 'Create Sell Order Request',
      );
      final result = await client.post(
        Env.createSellOrderUrl,
        body: jsonEncode(request.toJson()),
        headers: {'Authorization': 'Bearer ${tokens['accessToken']}'},
      );
      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        TLoggerHelper.logApiResult(
          httpMethod: 'POST',
          method: 'createSellOrder',
          code: result.statusCode!,
          message: result.bodyString!,
        );
        return sellOrderResponseFromJson(result.bodyString!);
      } else if (result.statusCode! == 401) {
        TLoggerHelper.logRefreshAttempt(
          'createOrder',
          statusCode: result.statusCode!,
        );
        try {
          final token = await authRemoteDatabase.refreshToken(tokens);
          // Update the existing map instead of creating a new one
          tokens['accessToken'] = token.accessToken;
          tokens['refreshToken'] = token.refreshToken;
          return createOrder(request, tokens);
        } catch (e) {
          throw ServerException(result.statusText!);
        }
      } else {
        throw ServerException(result.statusText!);
      }
    } catch (e, s) {
      TLoggerHelper.logError(
        error: e,
        stackTrace: s,
        message: 'Request failed',
        method: 'Create Sell Order',
        eventName: 'Sell Order',
      );
      throw DeviceException('Unexpected Error!\nPlease try again later');
    }
  }

  @override
  Future<List<SellHistoryModel>> fetchOrderHistory(Map tokens) async {
    try {
      final result = await client.get(
        '${Env.sellHistoryUrl}=${tokens['userId']}',
        headers: {'Authorization': 'Bearer ${tokens['accessToken']}'},
      );

      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        final List<dynamic> responseData = result.body;
        List<SellHistoryModel> history = responseData
            .map((coin) => sellHistoryModelFromJson(jsonEncode(coin)))
            .toList();
        TLoggerHelper.logApiResult(
          httpMethod: 'GET',
          method: 'fetchSellHistory',
          code: result.statusCode!,
          message: 'Fetched ${history.length} orders',
        );
        return history;
      } else if (result.statusCode! == 401) {
        TLoggerHelper.logRefreshAttempt(
          'fetchBuyHistory',
          statusCode: result.statusCode!,
        );
        try {
          final token = await authRemoteDatabase.refreshToken(tokens);
          // Update the existing map instead of creating a new one
          tokens['accessToken'] = token.accessToken;
          tokens['refreshToken'] = token.refreshToken;
          return fetchOrderHistory(tokens);
        } catch (e) {
          throw ServerException(result.statusText!);
        }
      } else {
        throw ServerException(result.statusText!);
      }
    } catch (e, s) {
      TLoggerHelper.logError(
        error: e,
        stackTrace: s,
        method: 'fetchSellHistory',
        eventName: 'Sell History',
        message: 'Error fetching sell history',
      );
      throw DeviceException('Unexpected Error!\nPlease try again later');
    }
  }
}
