import 'dart:convert';

import 'country.dart';

FeeCalculation feeCalculationFromJson(String str) =>
    FeeCalculation.fromJson(json.decode(str));

String feeCalculationToJson(FeeCalculation data) => json.encode(data.toJson());

class FeeCalculation {
  String amount;
  int currencyId;
  bool isLocal;
  String paymentMode;
  String networkFeeType;
  Country country;

  FeeCalculation({
    required this.amount,
    required this.currencyId,
    required this.isLocal,
    required this.paymentMode,
    required this.networkFeeType,
    required this.country,
  });

  FeeCalculation copyWith({
    String? amount,
    int? currencyId,
    bool? isLocal,
    String? paymentMode,
    String? networkFeeType,
    Country? country,
  }) => FeeCalculation(
    amount: amount ?? this.amount,
    currencyId: currencyId ?? this.currencyId,
    isLocal: isLocal ?? this.isLocal,
    paymentMode: paymentMode ?? this.paymentMode,
    networkFeeType: networkFeeType ?? this.networkFeeType,
    country: country ?? this.country,
  );

  factory FeeCalculation.fromJson(Map<String, dynamic> json) => FeeCalculation(
    amount: json["amount"],
    currencyId: json["currencyId"],
    isLocal: json["isLocal"],
    paymentMode: json["paymentMode"],
    networkFeeType: json["networkFeeType"],
    country: Country.fromJson(json["country"]),
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "currencyId": currencyId,
    "isLocal": isLocal,
    "paymentMode": paymentMode,
    "networkFeeType": networkFeeType,
    "country": country.toJson(),
  };
}
