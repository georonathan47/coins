import 'dart:convert';

PayAccount payAccountFromJson(String str) =>
    PayAccount.fromJson(json.decode(str));

String payAccountToJson(PayAccount data) => json.encode(data.toJson());

class PayAccount {
  final int? userId;
  final String nameOnAccount;
  final String accountNumber;
  final String country;
  final String paymentMode;
  final String paymentType;
  final String bankName;
  final String dateOfBirth;
  final bool activated;

  PayAccount({
    this.userId,
    required this.nameOnAccount,
    required this.accountNumber,
    required this.country,
    required this.paymentMode,
    required this.paymentType,
    required this.bankName,
    required this.dateOfBirth,
    required this.activated,
  });

  PayAccount copyWith({
    int? userId,
    String? nameOnAccount,
    String? accountNumber,
    String? country,
    String? paymentMode,
    String? paymentType,
    String? bankName,
    String? dateOfBirth,
    bool? activated,
  }) => PayAccount(
    userId: userId ?? this.userId,
    nameOnAccount: nameOnAccount ?? this.nameOnAccount,
    accountNumber: accountNumber ?? this.accountNumber,
    country: country ?? this.country,
    paymentMode: paymentMode ?? this.paymentMode,
    paymentType: paymentType ?? this.paymentType,
    bankName: bankName ?? this.bankName,
    dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    activated: activated ?? this.activated,
  );

  factory PayAccount.fromJson(Map<String, dynamic> json) => PayAccount(
    userId: json["userId"],
    nameOnAccount: json["nameOnAccount"],
    accountNumber: json["accountNumber"],
    country: json["country"],
    paymentMode: json["paymentMode"],
    paymentType: json["paymentType"],
    bankName: json["bankName"],
    dateOfBirth: json["dateOfBirth"],
    activated: json["activated"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "nameOnAccount": nameOnAccount,
    "accountNumber": accountNumber,
    "country": country,
    "paymentMode": paymentMode,
    "paymentType": paymentType,
    "bankName": bankName,
    "dateOfBirth": dateOfBirth,
    "activated": activated,
  };

  factory PayAccount.empty() => PayAccount(
    userId: 0,
    nameOnAccount: '',
    accountNumber: '',
    country: '',
    paymentMode: '',
    paymentType: '',
    bankName: '',
    dateOfBirth: '',
    activated: false,
  );
}
