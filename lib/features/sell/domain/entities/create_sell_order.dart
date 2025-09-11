import 'dart:convert';

SellOrder sellOrderFromJson(String str) => SellOrder.fromJson(json.decode(str));

String sellOrderToJson(SellOrder data) => json.encode(data.toJson());

class SellOrder {
  final int userId;
  final double sellAmount;
  final double networkFee;
  final double overAllTotal;
  final double localCurrencyTotal;
  final String bankName;
  final String nameOnAccount;
  final String accountNumber;
  final String bankBranchName;
  final String phoneNumber;
  final String senderSName;
  final String paymentMode;
  final String accountType;
  final String ecurrency;

  SellOrder({
    required this.userId,
    required this.sellAmount,
    required this.networkFee,
    required this.overAllTotal,
    required this.localCurrencyTotal,
    required this.bankName,
    required this.nameOnAccount,
    required this.accountNumber,
    required this.bankBranchName,
    required this.phoneNumber,
    required this.senderSName,
    required this.paymentMode,
    required this.accountType,
    required this.ecurrency,
  });

  SellOrder copyWith({
    int? userId,
    double? sellAmount,
    double? networkFee,
    double? overAllTotal,
    double? localCurrencyTotal,
    String? bankName,
    String? nameOnAccount,
    String? accountNumber,
    String? bankBranchName,
    String? phoneNumber,
    String? senderSName,
    String? paymentMode,
    String? accountType,
    String? ecurrency,
  }) => SellOrder(
    userId: userId ?? this.userId,
    sellAmount: sellAmount ?? this.sellAmount,
    networkFee: networkFee ?? this.networkFee,
    overAllTotal: overAllTotal ?? this.overAllTotal,
    localCurrencyTotal: localCurrencyTotal ?? this.localCurrencyTotal,
    bankName: bankName ?? this.bankName,
    nameOnAccount: nameOnAccount ?? this.nameOnAccount,
    accountNumber: accountNumber ?? this.accountNumber,
    bankBranchName: bankBranchName ?? this.bankBranchName,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    senderSName: senderSName ?? this.senderSName,
    paymentMode: paymentMode ?? this.paymentMode,
    accountType: accountType ?? this.accountType,
    ecurrency: ecurrency ?? this.ecurrency,
  );

  factory SellOrder.fromJson(Map<String, dynamic> json) => SellOrder(
    userId: json["userId"],
    sellAmount: json["sellAmount"]?.toDouble(),
    networkFee: json["networkFee"]?.toDouble(),
    overAllTotal: json["overAllTotal"]?.toDouble(),
    localCurrencyTotal: json["localCurrencyTotal"]?.toDouble(),
    bankName: json["bankName"],
    nameOnAccount: json["nameOnAccount"],
    accountNumber: json["accountNumber"],
    bankBranchName: json["bankBranchName"],
    phoneNumber: json["phoneNumber"],
    senderSName: json["senderSName"],
    paymentMode: json["paymentMode"],
    accountType: json["accountType"],
    ecurrency: json["ecurrency"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "sellAmount": sellAmount,
    "networkFee": networkFee,
    "overAllTotal": overAllTotal,
    "localCurrencyTotal": localCurrencyTotal,
    "bankName": bankName,
    "nameOnAccount": nameOnAccount,
    "accountNumber": accountNumber,
    "bankBranchName": bankBranchName,
    "phoneNumber": phoneNumber,
    "senderSName": senderSName,
    "paymentMode": paymentMode,
    "accountType": accountType,
    "ecurrency": ecurrency,
  };

  factory SellOrder.empty() => SellOrder(
    userId: 0,
    bankName: '',
    ecurrency: '',
    sellAmount: 0.0,
    networkFee: 1.5,
    phoneNumber: '',
    senderSName: '',
    accountType: '',
    paymentMode: '',
    overAllTotal: 0.0,
    nameOnAccount: '',
    accountNumber: '',
    bankBranchName: '',
    localCurrencyTotal: 0.0,
  );
}
