// To parse this JSON data, do
//
//     final country = countryFromJson(jsonString);

import 'dart:convert';

Country countryFromJson(String str) => Country.fromJson(json.decode(str));

String countryToJson(Country data) => json.encode(data.toJson());

class Country {
  int id;
  String countryName;
  String countryCurrency;
  String countryFlag;
  String bankList;

  Country({
    required this.id,
    required this.countryName,
    required this.countryCurrency,
    required this.countryFlag,
    required this.bankList,
  });

  Country copyWith({
    int? id,
    String? countryName,
    String? countryCurrency,
    String? countryFlag,
    String? bankList,
  }) => Country(
    id: id ?? this.id,
    countryName: countryName ?? this.countryName,
    countryCurrency: countryCurrency ?? this.countryCurrency,
    countryFlag: countryFlag ?? this.countryFlag,
    bankList: bankList ?? this.bankList,
  );

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    countryName: json["countryName"],
    countryCurrency: json["countryCurrency"],
    countryFlag: json["countryFlag"],
    bankList: json["bankList"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "countryName": countryName,
    "countryCurrency": countryCurrency,
    "countryFlag": countryFlag,
    "bankList": bankList,
  };

  factory Country.empty() => Country(
    id: 0,
    countryName: '',
    countryCurrency: '',
    countryFlag: '',
    bankList: '',
  );
}
