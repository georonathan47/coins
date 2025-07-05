import 'dart:convert';

PaymentMode paymentModeFromJson(String str) =>
    PaymentMode.fromJson(json.decode(str));

String paymentModeToJson(PaymentMode data) => json.encode(data.toJson());

class PaymentMode {
  final int id;
  final String paymentMode;
  final String paymentType;
  final String country;

  PaymentMode({
    required this.id,
    required this.paymentMode,
    required this.paymentType,
    required this.country,
  });

  factory PaymentMode.fromJson(Map<String, dynamic> json) => PaymentMode(
    id: json["id"],
    paymentMode: json["paymentMode"],
    paymentType: json["paymentType"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "paymentMode": paymentMode,
    "paymentType": paymentType,
    "country": country,
  };
}
