import 'dart:convert';

import 'package:get/get_connect.dart';

import '../../../../core/auth/data/datasources/auth_remote_database.dart';
import '../../../../core/shared/constants/env.dart';
import '../../../../core/shared/error/exception.dart';
import '../../../../core/shared/utils/logger.dart';
import '../../domain/entities/bank.dart';
import '../../domain/entities/coin_data.dart';
import '../../domain/entities/country.dart';
import '../../domain/entities/create_buy_order.dart';
import '../../domain/entities/fee_calculation.dart';
import '../../domain/entities/payment_mode.dart';
import '../models/buy_history_model.dart';
import '../models/create_order_response.dart';
import '../models/currency.dart';
import '../models/fee_calc_response.dart';

abstract class BuyRemoteDatabase {
  Future<List<Bank>> fetchBanks(Map tokens);
  Future<List<Bank>> fetchMomoList(Map tokens);
  Future<List<Country>> fetchCountries(Map tokens);
  Future<List<CoinData>> fetchListings(Map tokens);
  Future<List<BuyHistoryModel>> fetchHistory(Map tokens);
  Future<List<Currency>> fetchCurrencies(int countryId, Map tokens);
  Future<List<CoinData>> fetchTradableCoins(int countryId, Map tokens);
  Future<List<PaymentMode>> fetchPaymentModes(String country, Map tokens);
  Future<FeeCalcResponse> calculateFees(FeeCalculation request, Map tokens);
  Future<CreateBuyOrderResponse> createOrder(
    CreateBuyOrder request,
    Map tokens,
  );
}

class BuyRemoteDatabaseImpl implements BuyRemoteDatabase {
  final GetHttpClient client;
  final AuthRemoteDatabase authRemoteDatabase;
  BuyRemoteDatabaseImpl({
    required this.client,
    required this.authRemoteDatabase,
  });

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
      } else if (result.statusCode! == 401 || result.statusCode! == 403) {
        TLoggerHelper.logRefreshAttempt(
          'fetchCountries',
          statusCode: result.statusCode!,
        );
        try {
          final token = await authRemoteDatabase.refreshToken(tokens);
          // Update the existing map instead of creating a new one
          tokens['accessToken'] = token.accessToken;
          tokens['refreshToken'] = token.refreshToken;
          return fetchCountries(tokens);
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
      } else if (result.statusCode! == 401 || result.statusCode! == 403) {
        TLoggerHelper.logRefreshAttempt(
          'fetchListings',
          statusCode: result.statusCode!,
        );
        try {
          final token = await authRemoteDatabase.refreshToken(tokens);
          // Update the existing map instead of creating a new one
          tokens['accessToken'] = token.accessToken;
          tokens['refreshToken'] = token.refreshToken;
          return fetchListings(tokens);
        } catch (e) {
          throw ServerException(result.statusText!);
        }
      } else {
        throw ServerException(result.statusText!);
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
      TLoggerHelper.logEvent(url);
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
      } else if (result.statusCode! == 401 || result.statusCode! == 403) {
        TLoggerHelper.logRefreshAttempt(
          'calculateFees',
          statusCode: result.statusCode!,
        );
        try {
          final token = await authRemoteDatabase.refreshToken(tokens);
          // Update the existing map instead of creating a new one
          tokens['accessToken'] = token.accessToken;
          tokens['refreshToken'] = token.refreshToken;
          return calculateFees(request, tokens);
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
      } else if (result.statusCode! == 401 || result.statusCode! == 403) {
        TLoggerHelper.logRefreshAttempt(
          'fetchCurrencies',
          statusCode: result.statusCode!,
        );
        try {
          final token = await authRemoteDatabase.refreshToken(tokens);
          // Update the existing map instead of creating a new one
          tokens['accessToken'] = token.accessToken;
          tokens['refreshToken'] = token.refreshToken;
          return fetchCurrencies(countryId, tokens);
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
      } else if (result.statusCode! == 401 || result.statusCode! == 403) {
        TLoggerHelper.logRefreshAttempt(
          'fetchTradableCoins',
          statusCode: result.statusCode!,
        );
        try {
          final token = await authRemoteDatabase.refreshToken(tokens);
          // Update the existing map instead of creating a new one
          tokens['accessToken'] = token.accessToken;
          tokens['refreshToken'] = token.refreshToken;
          return fetchTradableCoins(countryId, tokens);
        } catch (e) {
          throw ServerException(result.statusText!);
        }
      } else {
        throw ServerException(result.statusText!);
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

  @override
  Future<CreateBuyOrderResponse> createOrder(
    CreateBuyOrder request,
    Map tokens,
  ) async {
    try {
      final result = await client.post(
        Env.createBuyOrderUrl,
        body: jsonEncode(request.toJson()),
        headers: {'Authorization': 'Bearer ${tokens['accessToken']}'},
      );
      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        TLoggerHelper.logApiResult(
          httpMethod: 'POST',
          method: 'createBuyOrder',
          code: result.statusCode!,
          message: result.bodyString!,
        );
        return createBuyOrderResponseFromJson(result.bodyString!);
      } else if (result.statusCode! == 401 || result.statusCode! == 403) {
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
      TLoggerHelper.logEvent(
        e,
        stackTrace: s,
        eventName: 'Error Fetching Listings',
      );
      throw DeviceException('Unexpected Error!\nPlease try again later');
    }
  }

  @override
  Future<List<PaymentMode>> fetchPaymentModes(
    String country,
    Map tokens,
  ) async {
    try {
      final result = await client.get(
        '${Env.paymentModesUrl}=$country',
        headers: {'Authorization': 'Bearer ${tokens['accessToken']}'},
      );

      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        final List<dynamic> responseData = result.body;
        List<PaymentMode> modes = responseData
            .map((coin) => paymentModeFromJson(jsonEncode(coin)))
            .toList();
        TLoggerHelper.logApiResult(
          code: result.statusCode!,
          httpMethod: 'GET',
          method: 'fetchPaymentModes',
          message: 'Fetched ${modes.length} payment modes for country $country',
        );
        return modes;
      } else if (result.statusCode! == 401) {
        TLoggerHelper.logRefreshAttempt(
          'fetchPaymentModes',
          statusCode: result.statusCode!,
        );
        try {
          final token = await authRemoteDatabase.refreshToken(tokens);
          // Update the existing map instead of creating a new one
          tokens['accessToken'] = token.accessToken;
          tokens['refreshToken'] = token.refreshToken;
          return fetchPaymentModes(country, tokens);
        } catch (e) {
          throw ServerException(result.statusText!);
        }
      } else {
        throw ServerException(result.statusText!);
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

  @override
  Future<List<Bank>> fetchBanks(Map tokens) async {
    try {
      final result = await client.get(
        Env.bankListUrl,
        headers: {'Authorization': 'Bearer ${tokens['accessToken']}'},
      );

      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        final List<dynamic> responseData = result.body;
        List<Bank> banks = responseData
            .map((coin) => bankFromJson(jsonEncode(coin)))
            .toList();
        TLoggerHelper.logApiResult(
          httpMethod: 'GET',
          method: 'fetchBanks',
          code: result.statusCode!,
          message: 'Fetched ${banks.length} banks',
        );
        return banks;
      } else if (result.statusCode! == 401) {
        TLoggerHelper.logRefreshAttempt(
          'fetchBanks',
          statusCode: result.statusCode!,
        );
        try {
          final token = await authRemoteDatabase.refreshToken(tokens);
          // Update the existing map instead of creating a new one
          tokens['accessToken'] = token.accessToken;
          tokens['refreshToken'] = token.refreshToken;
          return fetchBanks(tokens);
        } catch (e) {
          throw ServerException(result.statusText!);
        }
      } else {
        throw ServerException(result.statusText!);
      }
    } catch (e, s) {
      TLoggerHelper.logEvent(
        e,
        stackTrace: s,
        eventName: 'Error Fetching Banks',
      );
      throw DeviceException('Unexpected Error!\nPlease try again later');
    }
  }

  @override
  Future<List<Bank>> fetchMomoList(Map tokens) async {
    try {
      final result = await client.get(
        Env.momoListUrl,
        headers: {'Authorization': 'Bearer ${tokens['accessToken']}'},
      );

      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        final List<dynamic> responseData = result.body;
        List<Bank> momo = responseData.map((coin) {
          TLoggerHelper.logEvent(coin, eventName: 'Momo Network');
          return Bank(
            id: coin['id'],
            bankName: coin['name'],
            countryId: coin['countryId'],
            bankCode: coin['networkCode'],
            countryName: coin['countryName'],
          );
        }).toList();
        TLoggerHelper.logApiResult(
          httpMethod: 'GET',
          method: 'fetchMomoList',
          code: result.statusCode!,
          message: 'Fetched ${momo.length} momo networks',
        );
        return momo;
      } else if (result.statusCode! == 401) {
        TLoggerHelper.logRefreshAttempt(
          'fetchMomoList',
          statusCode: result.statusCode!,
        );
        try {
          final token = await authRemoteDatabase.refreshToken(tokens);
          // Update the existing map instead of creating a new one
          tokens['accessToken'] = token.accessToken;
          tokens['refreshToken'] = token.refreshToken;
          return fetchMomoList(tokens);
        } catch (e) {
          throw ServerException(result.statusText!);
        }
      } else {
        throw ServerException(result.statusText!);
      }
    } catch (e, s) {
      TLoggerHelper.logEvent(
        e,
        stackTrace: s,
        eventName: 'Error Fetching Momo List',
      );
      throw DeviceException('Unexpected Error!\nPlease try again later');
    }
  }

  @override
  Future<List<BuyHistoryModel>> fetchHistory(Map tokens) async {
    try {
      final result = await client.get(
        '${Env.buyHistoryUrl}=${tokens['userId']}',
        headers: {'Authorization': 'Bearer ${tokens['accessToken']}'},
      );

      if (result.statusCode! >= 200 && result.statusCode! < 300) {
        final List<dynamic> responseData = result.body;
        List<BuyHistoryModel> history = responseData
            .map((coin) => buyHistoryModelFromJson(jsonEncode(coin)))
            .toList();
        TLoggerHelper.logApiResult(
          httpMethod: 'GET',
          method: 'fetchBuyHistory',
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
          return fetchHistory(tokens);
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
        method: 'fetchBuyHistory',
        eventName: 'Buy History',
        message: 'Error fetching buy history',
      );
      throw DeviceException('Unexpected Error!\nPlease try again later');
    }
  }
}
