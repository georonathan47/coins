// To parse this JSON data, do
//
//     final userPaymentDetail = userPaymentDetailFromJson(jsonString);

import 'dart:convert';

UserPaymentDetail userPaymentDetailFromJson(String str) =>
    UserPaymentDetail.fromJson(json.decode(str));

String userPaymentDetailToJson(UserPaymentDetail data) =>
    json.encode(data.toJson());

class UserPaymentDetail {
  final int id;
  final int userId;
  final String nameOnAccount;
  final String accountNumber;
  final String country;
  final String paymentMode;
  final String paymentType;
  final String bankName;
  final String dateOfBirth;
  final bool isActivated;

  UserPaymentDetail({
    required this.id,
    required this.userId,
    required this.nameOnAccount,
    required this.accountNumber,
    required this.country,
    required this.paymentMode,
    required this.paymentType,
    required this.bankName,
    required this.dateOfBirth,
    required this.isActivated,
  });

  UserPaymentDetail copyWith({
    int? id,
    int? userId,
    String? nameOnAccount,
    String? accountNumber,
    String? country,
    String? paymentMode,
    String? paymentType,
    String? bankName,
    String? dateOfBirth,
    bool? isActivated,
  }) => UserPaymentDetail(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    nameOnAccount: nameOnAccount ?? this.nameOnAccount,
    accountNumber: accountNumber ?? this.accountNumber,
    country: country ?? this.country,
    paymentMode: paymentMode ?? this.paymentMode,
    paymentType: paymentType ?? this.paymentType,
    bankName: bankName ?? this.bankName,
    dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    isActivated: isActivated ?? this.isActivated,
  );

  factory UserPaymentDetail.fromJson(Map<String, dynamic> json) =>
      UserPaymentDetail(
        id: json["id"],
        userId: json["userId"],
        nameOnAccount: json["nameOnAccount"],
        accountNumber: json["accountNumber"],
        country: json["country"],
        paymentMode: json["paymentMode"],
        paymentType: json["paymentType"],
        bankName: json["bankName"],
        dateOfBirth: json["dateOfBirth"],
        isActivated: json["isActivated"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "nameOnAccount": nameOnAccount,
    "accountNumber": accountNumber,
    "country": country,
    "paymentMode": paymentMode,
    "paymentType": paymentType,
    "bankName": bankName,
    "dateOfBirth": dateOfBirth,
    "isActivated": isActivated,
  };

  factory UserPaymentDetail.empty() => UserPaymentDetail(
    id: 0,
    userId: 0,
    nameOnAccount: '',
    accountNumber: '',
    country: '',
    paymentMode: '',
    paymentType: '',
    bankName: '',
    dateOfBirth: '',
    isActivated: false,
  );
}
