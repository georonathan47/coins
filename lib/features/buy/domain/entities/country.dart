import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
import 'dart:convert';

import '../../../../core/shared/data/hive_adapters.dart';

part 'country.freezed.dart';
part 'country.g.dart';

Country countryFromJson(String str) => Country.fromJson(json.decode(str));

String countryToJson(Country data) => json.encode(data.toJson());

@freezed
@HiveType(typeId: HiveAdapters.countries)
abstract class Country with _$Country {
  const factory Country({
    @HiveField(0) required int id,
    @HiveField(1) required String countryName,
    @HiveField(2) required String countryCurrency,
    @HiveField(3) required String countryFlag,
    @HiveField(4) required String bankList,
  }) = _Country;

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  factory Country.empty() => const Country(
    id: 0,
    countryName: '',
    countryCurrency: '',
    countryFlag: '',
    bankList: '',
  );
}
