import 'dart:convert';

SellOrderResponse sellOrderResponseFromJson(String str) =>
    SellOrderResponse.fromJson(json.decode(str));

String sellOrderResponseToJson(SellOrderResponse data) =>
    json.encode(data.toJson());

class SellOrderResponse {
  final String orderId;
  final String orderType;
  final double orderAmount;
  final double amountPaid;
  final double amountReceived;
  final double networkFee;
  final double overAllTotal;
  final double localCurrencyTotal;
  final String localCurrency;
  final String status;
  final DateTime dateCreated;
  final String walletAddress;
  final DateTime timeCreated;
  final String transactionHash;
  final double rate;
  final String ecurrency;
  final String ecurrencyWalletAddress;

  SellOrderResponse({
    required this.orderId,
    required this.orderType,
    required this.orderAmount,
    required this.amountPaid,
    required this.amountReceived,
    required this.networkFee,
    required this.overAllTotal,
    required this.localCurrencyTotal,
    required this.localCurrency,
    required this.status,
    required this.dateCreated,
    required this.walletAddress,
    required this.timeCreated,
    required this.transactionHash,
    required this.rate,
    required this.ecurrency,
    required this.ecurrencyWalletAddress,
  });

  SellOrderResponse copyWith({
    String? orderId,
    String? orderType,
    double? orderAmount,
    double? amountPaid,
    double? amountReceived,
    double? networkFee,
    double? overAllTotal,
    double? localCurrencyTotal,
    String? localCurrency,
    String? status,
    DateTime? dateCreated,
    String? walletAddress,
    DateTime? timeCreated,
    String? transactionHash,
    double? rate,
    String? ecurrency,
    String? ecurrencyWalletAddress,
  }) => SellOrderResponse(
    orderId: orderId ?? this.orderId,
    orderType: orderType ?? this.orderType,
    orderAmount: orderAmount ?? this.orderAmount,
    amountPaid: amountPaid ?? this.amountPaid,
    amountReceived: amountReceived ?? this.amountReceived,
    networkFee: networkFee ?? this.networkFee,
    overAllTotal: overAllTotal ?? this.overAllTotal,
    localCurrencyTotal: localCurrencyTotal ?? this.localCurrencyTotal,
    localCurrency: localCurrency ?? this.localCurrency,
    status: status ?? this.status,
    dateCreated: dateCreated ?? this.dateCreated,
    walletAddress: walletAddress ?? this.walletAddress,
    timeCreated: timeCreated ?? this.timeCreated,
    transactionHash: transactionHash ?? this.transactionHash,
    rate: rate ?? this.rate,
    ecurrency: ecurrency ?? this.ecurrency,
    ecurrencyWalletAddress:
        ecurrencyWalletAddress ?? this.ecurrencyWalletAddress,
  );

  factory SellOrderResponse.fromJson(Map<String, dynamic> json) =>
      SellOrderResponse(
        orderId: json["orderId"],
        orderType: json["orderType"],
        orderAmount: json["orderAmount"],
        amountPaid: json["amountPaid"],
        amountReceived: json["amountReceived"],
        networkFee: json["networkFee"],
        overAllTotal: json["overAllTotal"],
        localCurrencyTotal: json["localCurrencyTotal"],
        localCurrency: json["localCurrency"],
        status: json["status"],
        dateCreated: DateTime.parse(json["dateCreated"]),
        walletAddress: json["walletAddress"],
        timeCreated: DateTime.parse(json["timeCreated"]),
        transactionHash: json["transactionHash"] ?? '',
        rate: json["rate"],
        ecurrency: json["ecurrency"],
        ecurrencyWalletAddress: json["ecurrencyWalletAddress"],
      );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "orderType": orderType,
    "orderAmount": orderAmount,
    "amountPaid": amountPaid,
    "amountReceived": amountReceived,
    "networkFee": networkFee,
    "overAllTotal": overAllTotal,
    "localCurrencyTotal": localCurrencyTotal,
    "localCurrency": localCurrency,
    "status": status,
    "dateCreated": dateCreated.toIso8601String(),
    "walletAddress": walletAddress,
    "timeCreated": timeCreated.toIso8601String(),
    "transactionHash": transactionHash,
    "rate": rate,
    "ecurrency": ecurrency,
    "ecurrencyWalletAddress": ecurrencyWalletAddress,
  };
}
