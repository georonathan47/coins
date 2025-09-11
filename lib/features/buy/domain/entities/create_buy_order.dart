import 'dart:convert';

CreateBuyOrder createBuyOrderFromJson(String str) =>
    CreateBuyOrder.fromJson(jsonDecode(str));

String createBuyOrderToJson(CreateBuyOrder data) => jsonEncode(data.toJson());

class CreateBuyOrder {
  int? userId;
  double? buyAmount;
  double? networkFee;
  double? total;
  double? localCurrencyTotal;
  String? walletAddress;
  String? transactionDetails;
  DateTime? depositDate;
  String? bankName;
  String? paymentMode;
  double? depositAmount;
  String? accountNumber;
  String? nameOnAccount;
  String? eCurrency;

  CreateBuyOrder({
    this.userId,
    this.buyAmount,
    this.networkFee,
    this.total,
    this.localCurrencyTotal,
    this.walletAddress,
    this.transactionDetails,
    this.depositDate,
    this.bankName,
    this.paymentMode,
    this.depositAmount,
    this.accountNumber,
    this.nameOnAccount,
    this.eCurrency,
  });

  CreateBuyOrder copyWith({
    int? userId,
    double? buyAmount,
    double? networkFee,
    double? total,
    double? localCurrencyTotal,
    String? walletAddress,
    String? transactionDetails,
    DateTime? depositDate,
    String? bankName,
    String? paymentMode,
    double? depositAmount,
    String? accountNumber,
    String? nameOnAccount,
    String? eCurrency,
  }) => CreateBuyOrder(
    userId: userId ?? this.userId,
    buyAmount: buyAmount ?? this.buyAmount,
    networkFee: networkFee ?? this.networkFee,
    total: total ?? this.total,
    localCurrencyTotal: localCurrencyTotal ?? this.localCurrencyTotal,
    walletAddress: walletAddress ?? this.walletAddress,
    transactionDetails: transactionDetails ?? this.transactionDetails,
    depositDate: depositDate ?? this.depositDate,
    bankName: bankName ?? this.bankName,
    paymentMode: paymentMode ?? this.paymentMode,
    depositAmount: depositAmount ?? this.depositAmount,
    accountNumber: accountNumber ?? this.accountNumber,
    nameOnAccount: nameOnAccount ?? this.nameOnAccount,
    eCurrency: eCurrency ?? this.eCurrency,
  );

  factory CreateBuyOrder.fromJson(Map<String, dynamic> json) => CreateBuyOrder(
    userId: json["userId"],
    buyAmount: json["buyAmount"]?.toDouble(),
    networkFee: json["networkFee"],
    total: json["total"]?.toDouble(),
    localCurrencyTotal: json["localCurrencyTotal"],
    walletAddress: json["walletAddress"],
    transactionDetails: json["transactionDetails"],
    depositDate: json["depositDate"] == null
        ? null
        : DateTime.parse(json["depositDate"]),
    bankName: json["bankName"],
    paymentMode: json["paymentMode"],
    depositAmount: json["depositAmount"],
    accountNumber: json["accountNumber"],
    nameOnAccount: json["nameOnAccount"],
    eCurrency: json["eCurrency"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "buyAmount": buyAmount,
    "networkFee": networkFee,
    "total": total,
    "localCurrencyTotal": localCurrencyTotal,
    "walletAddress": walletAddress,
    "transactionDetails": transactionDetails,
    "depositDate": depositDate?.toIso8601String(),
    "bankName": bankName,
    "paymentMode": paymentMode,
    "depositAmount": depositAmount,
    "accountNumber": accountNumber,
    "nameOnAccount": nameOnAccount,
    "eCurrency": eCurrency,
  };

  factory CreateBuyOrder.empty() => CreateBuyOrder(
    userId: 0,
    buyAmount: 0.0,
    networkFee: 0,
    total: 0.0,
    localCurrencyTotal: 0,
    walletAddress: '',
    transactionDetails: '',
    depositDate: DateTime.now(),
    bankName: '',
    paymentMode: '',
    depositAmount: 0,
    accountNumber: '',
    nameOnAccount: '',
    eCurrency: '',
  );
}
