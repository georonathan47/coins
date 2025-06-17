import 'dart:convert';

import 'package:get/get_connect.dart';

import '../../../../core/constants/env.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/coin_data.dart';
import '../../domain/entities/country.dart';
import '../../domain/entities/fee_calculation.dart';
import '../models/currency.dart';
import '../models/ree_calc_response.dart';

abstract class BuyRemoteDatabase {
  Future<List<Country>> fetchCountries(Map tokens);
  Future<List<CoinData>> fetchListings(Map tokens);
  Future<List<Currency>> fetchCurrencies(int countryId, Map tokens);
  Future<List<CoinData>> fetchTradableCoins(int countryId, Map tokens);
  Future<FeeCalcResponse> calculateFees(FeeCalculation request, Map tokens);
}

class BuyRemoteDatabaseImpl implements BuyRemoteDatabase {
  final GetHttpClient client;
  BuyRemoteDatabaseImpl(this.client);

  @override
  Future<List<Country>> fetchCountries(Map tokens) async {
    try {
      final result = await client.get(
        Env.activateCountriesUrl,
        headers: {'Authorization': 'Bearer ${tokens['accessToken']}'},
      );
      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        final List<dynamic> responseData = jsonDecode(result.bodyString!);
        List<Country> countries = responseData
            .map((country) => countryFromJson(jsonEncode(country)))
            .toSet()
            .toList();
        return countries;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw DeviceException('Unexpected Error!\nPlease try again later');
    }
  }

  @override
  Future<List<CoinData>> fetchListings(Map tokens) async {
    try {
      final result = await client.get(
        Env.listingsUrl,
        headers: {'Authorization': 'Bearer ${tokens['accessToken']}'},
      );
      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        final List<dynamic> responseData = result.body;
        List<CoinData> coinData = responseData
            .map((country) => coinDataFromJson(jsonEncode(country)))
            .toList();
        TLoggerHelper.logApiResult(
          httpMethod: 'GET',
          code: result.statusCode!,
          method: 'fetchCurrencies',
          message: 'Fetched ${coinData.length} listed currencies',
        );
        return coinData;
      } else {
        throw ServerException();
      }
    } catch (e, s) {
      TLoggerHelper.logEvent(
        e,
        stackTrace: s,
        eventName: 'Error Fetching Listings',
      );
      throw DeviceException('Unexpected Error!\nPlease try again later');
    }
  }

  

  @override
  Future<FeeCalcResponse> calculateFees(
    FeeCalculation request,
    Map tokens,
  ) async {
    try {
      final url =
          '${Env.buyUrl}=${request.country.id}&currencyId=${request.currencyId}&amount=${request.amount}&networkFeeType=${request.networkFeeType}&networkFeePaymentType=${request.paymentMode}&amountIsLocal=${request.isLocal}';
      final result = await client.get(
        url,
        headers: {'Authorization': 'Bearer ${tokens['accessToken']}'},
      );
      TLoggerHelper.logApiResult(
        httpMethod: 'GET',
        code: result.statusCode!,
        method: 'calculateFees',
        message:
            'Calculated fees for ${request.amount} worth of ${request.currencyId} in ${request.country.countryName} with ${request.networkFeeType} network fee type and ${request.paymentMode} payment mode',
      );
      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        return feeCalcResponseFromJson(result.bodyString!);
      } else if (result.statusCode! == 404) {
        throw NoResultException(
          'Buy/Sell rate with the provided parameters does not exist',
        );
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw DeviceException('Unexpected Error!\nPlease try again later');
    }
  }

  @override
  Future<List<Currency>> fetchCurrencies(int countryId, Map tokens) async {
    try {
      final result = await client.get(
        '${Env.specificCurrencyUrl}=$countryId',
        headers: {'Authorization': 'Bearer ${tokens['accessToken']}'},
      );
      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        final List<dynamic> responseData = jsonDecode(result.bodyString!);
        List<Currency> currencies = responseData
            .map((currency) => currencyFromJson(jsonEncode(currency)))
            .toSet()
            .toList();
        TLoggerHelper.logApiResult(
          httpMethod: 'GET',
          code: result.statusCode!,
          method: 'fetchCurrencies',
          message:
              'Fetched ${currencies.length} currencies for country $countryId',
        );
        return currencies;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw DeviceException('Unexpected Error!\nPlease try again later');
    }
  }

  @override
  Future<List<CoinData>> fetchTradableCoins(int countryId, Map tokens) async {
    try {
      final result = await client.get(
        '${Env.tradableCurrenciesUrl}=$countryId',
        headers: {'Authorization': 'Bearer ${tokens['accessToken']}'},
      );

      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        final List<dynamic> responseData = result.body;
        List<CoinData> coinData = responseData
            .map((coin) => coinDataFromJson(jsonEncode(coin)))
            .toList();
        TLoggerHelper.logApiResult(
          code: result.statusCode!,
          httpMethod: 'GET',
          method: 'fetchTradableCoins',
          message:
              'Fetched ${coinData.length} tradable coins for country $countryId',
        );
        return coinData;
      } else {
        throw ServerException();
      }
    } catch (e, s) {
      TLoggerHelper.logEvent(
        e,
        stackTrace: s,
        eventName: 'Error Fetching Tradables',
      );
      throw DeviceException('Unexpected Error!\nPlease try again later');
    }
  }
}
