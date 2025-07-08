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

// Momo momoFromJson(String str) => Momo.fromJson(json.decode(str));

// String momoToJson(Momo data) => json.encode(data.toJson());

// class Momo {
//   final int id;
//   final int countryId;
//   final String name;
//   final String networkCode;
//   final String countryName;

//   Momo({
//     required this.id,
//     required this.name,
//     required this.networkCode,
//     required this.countryId,
//     required this.countryName,
//   });

//   factory Momo.fromJson(Map<String, dynamic> json) => Momo(
//     id: json["id"],
//     name: json["name"],
//     networkCode: json["networkCode"],
//     countryId: json["countryId"],
//     countryName: json["countryName"],
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "networkCode": networkCode,
//     "countryId": countryId,
//     "countryName": countryName,
//   };
// }
