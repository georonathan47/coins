import 'dart:convert';

import 'package:get/get_connect.dart';

import '../../../../core/constants/env.dart';
import '../../../../core/error/exception.dart';
import '../../domain/entities/country.dart';
import '../../domain/entities/fee_calculation.dart';
import '../models/currency.dart';
import '../models/ree_calc_response.dart';

abstract class BuyRemoteDatabase {
  Future<List<Country>> fetchCountries(Map tokens);
  Future<List<Currency>> fetchCurrencies(int countryId, Map tokens);
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
        return currencies;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw DeviceException('Unexpected Error!\nPlease try again later');
    }
  }
}
