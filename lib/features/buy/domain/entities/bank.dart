import 'dart:convert';

Bank bankFromJson(String str) => Bank.fromJson(json.decode(str));

String bankToJson(Bank data) => json.encode(data.toJson());

class Bank {
  final int id;
  final int countryId;
  final String bankCode;
  final String bankName;
  final String countryName;

  Bank({
    required this.id,
    required this.bankCode,
    required this.bankName,
    required this.countryName,
    required this.countryId,
  });

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
    id: json["id"],
    bankCode: json["bankCode"],
    bankName: json["bankName"],
    countryId: json["countryId"],
    countryName: json["countryName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bankCode": bankCode,
    "bankName": bankName,
    "countryId": countryId,
    "countryName": countryName,
  };
}
