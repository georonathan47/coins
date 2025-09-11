import 'dart:convert';

CreateBuyOrderResponse createBuyOrderResponseFromJson(String str) =>
    CreateBuyOrderResponse.fromJson(json.decode(str));

String createBuyOrderResponseToJson(CreateBuyOrderResponse data) =>
    json.encode(data.toJson());

class CreateBuyOrderResponse {
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
  final String? walletAddress;
  final dynamic timeCreated;
  final String transactionHash;
  final double rate;
  final String ecurrency;
  final String? ecurrencyWalletAddress;

  CreateBuyOrderResponse({
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

  CreateBuyOrderResponse copyWith({
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
    dynamic timeCreated,
    String? transactionHash,
    double? rate,
    String? ecurrency,
    String? ecurrencyWalletAddress,
  }) => CreateBuyOrderResponse(
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

  factory CreateBuyOrderResponse.fromJson(Map<String, dynamic> json) =>
      CreateBuyOrderResponse(
        orderId: json["orderId"],
        orderType: json["orderType"],
        orderAmount: json["orderAmount"]?.toDouble(),
        amountPaid: json["amountPaid"],
        amountReceived: json["amountReceived"],
        networkFee: json["networkFee"],
        overAllTotal: json["overAllTotal"]?.toDouble(),
        localCurrencyTotal: json["localCurrencyTotal"],
        localCurrency: json["localCurrency"],
        status: json["status"],
        dateCreated: DateTime.parse(json["dateCreated"]),
        walletAddress: json["walletAddress"] ?? '',
        timeCreated: json["timeCreated"],
        transactionHash: json["transactionHash"],
        rate: json["rate"],
        ecurrency: json["ecurrency"],
        ecurrencyWalletAddress: json["ecurrencyWalletAddress"] ?? '',
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
    "timeCreated": timeCreated,
    "transactionHash": transactionHash,
    "rate": rate,
    "ecurrency": ecurrency,
    "ecurrencyWalletAddress": ecurrencyWalletAddress,
  };
}
