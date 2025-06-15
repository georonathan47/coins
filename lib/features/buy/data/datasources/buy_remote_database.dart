import 'dart:convert';

import 'package:get/get_connect.dart';

import '../../../../core/constants/env.dart';
import '../../../../core/error/exception.dart';
import '../../domain/entities/country.dart';

abstract class BuyRemoteDatabase {
  Future<List<Country>> fetchCountries(Map tokens);
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
            .toList();
        return countries;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw DeviceException('Unexpected Error!\nPlease try again later');
    }
  }
}
