import 'dart:convert';

BuyHistoryModel buyHistoryModelFromJson(String str) =>
    BuyHistoryModel.fromJson(json.decode(str));

String buyHistoryModelToJson(BuyHistoryModel data) =>
    json.encode(data.toJson());

class BuyHistoryModel {
  final int id;
  final String orderId;
  final String orderType;
  final double amountBuy;
  final double amountReceived;
  final double amountPaid;
  final double networkFee;
  final double overAllTotal;
  final double localCurrencyTotal;
  final String localCurrency;
  final String walletAddress;
  final String status;
  final DateTime dateCreated;
  // final String note;
  final String userFullName;
  final String userEmail;
  final String timeCreated;
  final String transactionHash;
  final String bankName;
  final String transactionDetails;
  final double depositedAmount;
  final String paymentMode;
  final String depositDate;
  final String accountNumber;
  final String nameOnAccount;
  final double rate;
  final String ecurrency;

  BuyHistoryModel({
    required this.id,
    required this.orderId,
    required this.orderType,
    required this.amountBuy,
    required this.amountReceived,
    required this.amountPaid,
    required this.networkFee,
    required this.overAllTotal,
    required this.localCurrencyTotal,
    required this.localCurrency,
    required this.walletAddress,
    required this.status,
    required this.dateCreated,
    // required this.note,
    required this.userFullName,
    required this.userEmail,
    required this.timeCreated,
    required this.transactionHash,
    required this.bankName,
    required this.transactionDetails,
    required this.depositedAmount,
    required this.paymentMode,
    required this.depositDate,
    required this.accountNumber,
    required this.nameOnAccount,
    required this.rate,
    required this.ecurrency,
  });

  BuyHistoryModel copyWith({
    int? id,
    String? orderId,
    String? orderType,
    double? amountBuy,
    double? amountReceived,
    double? amountPaid,
    double? networkFee,
    double? overAllTotal,
    double? localCurrencyTotal,
    String? localCurrency,
    String? walletAddress,
    String? status,
    DateTime? dateCreated,
    // String? note,
    String? userFullName,
    String? userEmail,
    String? timeCreated,
    String? transactionHash,
    String? bankName,
    String? transactionDetails,
    double? depositedAmount,
    String? paymentMode,
    String? depositDate,
    String? accountNumber,
    String? nameOnAccount,
    double? rate,
    String? ecurrency,
  }) => BuyHistoryModel(
    id: id ?? this.id,
    orderId: orderId ?? this.orderId,
    orderType: orderType ?? this.orderType,
    amountBuy: amountBuy ?? this.amountBuy,
    amountReceived: amountReceived ?? this.amountReceived,
    amountPaid: amountPaid ?? this.amountPaid,
    networkFee: networkFee ?? this.networkFee,
    overAllTotal: overAllTotal ?? this.overAllTotal,
    localCurrencyTotal: localCurrencyTotal ?? this.localCurrencyTotal,
    localCurrency: localCurrency ?? this.localCurrency,
    walletAddress: walletAddress ?? this.walletAddress,
    status: status ?? this.status,
    dateCreated: dateCreated ?? this.dateCreated,
    // note: note ?? this.note,
    userFullName: userFullName ?? this.userFullName,
    userEmail: userEmail ?? this.userEmail,
    timeCreated: timeCreated ?? this.timeCreated,
    transactionHash: transactionHash ?? this.transactionHash,
    bankName: bankName ?? this.bankName,
    transactionDetails: transactionDetails ?? this.transactionDetails,
    depositedAmount: depositedAmount ?? this.depositedAmount,
    paymentMode: paymentMode ?? this.paymentMode,
    depositDate: depositDate ?? this.depositDate,
    accountNumber: accountNumber ?? this.accountNumber,
    nameOnAccount: nameOnAccount ?? this.nameOnAccount,
    rate: rate ?? this.rate,
    ecurrency: ecurrency ?? this.ecurrency,
  );

  factory BuyHistoryModel.fromJson(Map<String, dynamic> json) =>
      BuyHistoryModel(
        id: json["id"],
        orderId: json["orderId"],
        orderType: json["orderType"],
        amountBuy: json["amountBuy"],
        amountReceived: json["amountReceived"],
        amountPaid: json["amountPaid"],
        networkFee: json["networkFee"],
        overAllTotal: json["overAllTotal"],
        localCurrencyTotal: json["localCurrencyTotal"],
        localCurrency: json["localCurrency"],
        walletAddress: json["walletAddress"],
        status: json["status"],
        dateCreated: DateTime.parse(json["dateCreated"]),
        // note: json["note"],
        userFullName: json["userFullName"],
        userEmail: json["userEmail"],
        timeCreated: json["timeCreated"],
        transactionHash: json["transactionHash"],
        bankName: json["bankName"],
        transactionDetails: json["transactionDetails"],
        depositedAmount: json["depositedAmount"],
        paymentMode: json["paymentMode"],
        depositDate: json["depositDate"],
        accountNumber: json["accountNumber"],
        nameOnAccount: json["nameOnAccount"],
        rate: json["rate"],
        ecurrency: json["ecurrency"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "orderId": orderId,
    "orderType": orderType,
    "amountBuy": amountBuy,
    "amountReceived": amountReceived,
    "amountPaid": amountPaid,
    "networkFee": networkFee,
    "overAllTotal": overAllTotal,
    "localCurrencyTotal": localCurrencyTotal,
    "localCurrency": localCurrency,
    "walletAddress": walletAddress,
    "status": status,
    "dateCreated": dateCreated.toIso8601String(),
    // "note": note,
    "userFullName": userFullName,
    "userEmail": userEmail,
    "timeCreated": timeCreated,
    "transactionHash": transactionHash,
    "bankName": bankName,
    "transactionDetails": transactionDetails,
    "depositedAmount": depositedAmount,
    "paymentMode": paymentMode,
    "depositDate": depositDate,
    "accountNumber": accountNumber,
    "nameOnAccount": nameOnAccount,
    "rate": rate,
    "ecurrency": ecurrency,
  };
}
