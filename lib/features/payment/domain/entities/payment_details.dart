import 'dart:convert';

PaymentDetails paymentDetailsFromJson(String str) =>
    PaymentDetails.fromJson(json.decode(str));

String paymentDetailsToJson(PaymentDetails data) => json.encode(data.toJson());

class PaymentDetails {
  final int id;
  final String accountName;
  final String accountNumber;
  final String bankName;
  final String note;
  final String country;
  final String paymentType;

  PaymentDetails({
    required this.id,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
    required this.note,
    required this.country,
    required this.paymentType,
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) => PaymentDetails(
    id: json["id"],
    accountName: json["accountName"],
    accountNumber: json["accountNumber"],
    bankName: json["bankName"],
    country: json["country"],
    paymentType: json["paymentType"],
    note: json["note"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "accountName": accountName,
    "accountNumber": accountNumber,
    "bankName": bankName,
    "note": note,
    "country": country,
    "paymentType": paymentType,
  };
}
