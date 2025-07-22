import 'dart:convert';

import 'package:get/get_connect.dart';

import '../../../../core/auth/data/datasources/auth_remote_database.dart';
import '../../../../core/shared/constants/env.dart';
import '../../../../core/shared/error/exception.dart';
import '../../../../core/shared/utils/logger.dart';
import '../../domain/entities/dash_portfolio.dart';
import '../../domain/entities/payment_details.dart';
import '../models/user_payment_details.dart';

abstract class PaymentRemoteDatabase {
  /// Get payment details from remote database
  Future<List<PaymentDetails>> getPaymentDetails(
    String mode,
    String country,
    Map tokens,
  );

  Future<DashPortfolio> fetchPortfolio(Map tokens);
  Future<List<UserPaymentDetail>> fetchPaymentDetails(Map tokens);
}

class PaymentRemoteDatabaseImpl implements PaymentRemoteDatabase {
  final GetHttpClient client;
  final AuthRemoteDatabase authRemoteDatabase;

  PaymentRemoteDatabaseImpl({
    required this.client,
    required this.authRemoteDatabase,
  });

  @override
  Future<List<PaymentDetails>> getPaymentDetails(
    String mode,
    String country,
    Map tokens,
  ) async {
    try {
      TLoggerHelper.logEvent(
        '${Env.paymentDetailsUrl}=$country&paymentModeName=$mode',
      );
      final result = await client.get(
        '${Env.paymentDetailsUrl}=$country&paymentModeName=$mode',
        headers: {'Authorization': 'Bearer ${tokens['accessToken']}'},
      );
      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        final List<dynamic> responseData = jsonDecode(result.bodyString!);
        List<PaymentDetails> details = responseData
            .map((currency) => paymentDetailsFromJson(jsonEncode(currency)))
            .toSet()
            .toList();
        TLoggerHelper.logApiResult(
          httpMethod: 'GET',
          code: result.statusCode!,
          method: 'getPaymentDetails',
          message: 'Fetched ${details.length} details for $mode in $country',
        );
        return details;
      } else if (result.statusCode! == 401) {
        TLoggerHelper.logRefreshAttempt(
          'fetchPaymentDetails',
          statusCode: result.statusCode!,
        );
        try {
          final token = await authRemoteDatabase.refreshToken(tokens);
          // Update the existing map instead of creating a new one
          tokens['accessToken'] = token.accessToken;
          tokens['refreshToken'] = token.refreshToken;
          return getPaymentDetails(mode, country, tokens);
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
  Future<DashPortfolio> fetchPortfolio(Map tokens) async {
    try {
      final result = await client.get(
        '${Env.walletInfoUrl}=${tokens['userId']}',
        headers: {'Authorization': 'Bearer ${tokens['accessToken']}'},
      );
      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        final resultJson = dashPortfolioFromJson(result.bodyString!);
        TLoggerHelper.logApiResult(
          httpMethod: 'GET',
          code: result.statusCode!,
          method: 'fetchPortfolio',
          message: 'Fetched portfolio for user ${resultJson.userId}',
        );
        return resultJson;
      } else if (result.statusCode! == 401) {
        TLoggerHelper.logRefreshAttempt(
          'fetchPortfolio',
          statusCode: result.statusCode!,
        );
        try {
          final token = await authRemoteDatabase.refreshToken(tokens);
          // Update the existing map instead of creating a new one
          tokens['accessToken'] = token.accessToken;
          tokens['refreshToken'] = token.refreshToken;
          return fetchPortfolio(tokens);
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
  Future<List<UserPaymentDetail>> fetchPaymentDetails(Map tokens) async {
    try {
      final result = await client.get(
        '${Env.userPaymentDetailsUrl}=${tokens['userId']}',
        headers: {'Authorization': 'Bearer ${tokens['accessToken']}'},
      );
      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        final List<dynamic> responseData = jsonDecode(result.bodyString!);
        List<UserPaymentDetail> details = responseData
            .map((info) => userPaymentDetailFromJson(jsonEncode(info)))
            .toSet()
            .toList();
        TLoggerHelper.logApiResult(
          httpMethod: 'GET',
          code: result.statusCode!,
          method: 'fetchPaymentDetails',
          message:
              'Fetched ${details.length} details for user ${tokens['userId']}',
        );
        return details;
      } else if (result.statusCode! == 401) {
        TLoggerHelper.logRefreshAttempt(
          'getPaymentDetails',
          statusCode: result.statusCode!,
        );
        try {
          final token = await authRemoteDatabase.refreshToken(tokens);
          // Update the existing map instead of creating a new one
          tokens['accessToken'] = token.accessToken;
          tokens['refreshToken'] = token.refreshToken;
          return fetchPaymentDetails(tokens);
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
