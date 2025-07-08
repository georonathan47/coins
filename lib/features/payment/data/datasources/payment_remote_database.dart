import 'dart:convert';

import 'package:get/get_connect.dart';

import '../../../../core/auth/data/datasources/auth_remote_database.dart';
import '../../../../core/constants/env.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/payment_details.dart';

abstract class PaymentRemoteDatabase {
  /// Get payment details from remote database
  Future<List<PaymentDetails>> getPaymentDetails(
    String mode,
    String country,
    Map tokens,
  );
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
        for (var detail in details) {
          TLoggerHelper.logEvent(detail.note);
        }
        TLoggerHelper.logApiResult(
          httpMethod: 'GET',
          code: result.statusCode!,
          method: 'getPaymentDetails',
          message: 'Fetched ${details.length} details for $mode in $country',
        );
        return details;
      } else if (result.statusCode! == 401) {
        TLoggerHelper.logRefreshAttempt(
          'fetchCurrencies',
          statusCode: result.statusCode!,
        );
        try {
          final token = await authRemoteDatabase.refreshToken(tokens);
          // Update the existing map instead of creating a new one
          tokens['accessToken'] = token.accessToken;
          tokens['refreshToken'] = token.refreshToken;
          return getPaymentDetails(mode, country, tokens);
        } catch (e) {
          throw ServerException();
        }
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw DeviceException('Unexpected Error!\nPlease try again later');
    }
  }
}
