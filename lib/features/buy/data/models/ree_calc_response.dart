import 'dart:convert';

FeeCalcResponse feeCalcResponseFromJson(String str) =>
    FeeCalcResponse.fromJson(json.decode(str));

String feeCalcResponseToJson(FeeCalcResponse data) =>
    json.encode(data.toJson());

class FeeCalcResponse {
  double? amountLocalCurrency;
  double? amountStandardCurrency;
  double? regularNetworkFee;
  double? priorityNetworkFee;
  double? usdTotal;
  double? totalAmountLocalCurrency;

  FeeCalcResponse({
    this.amountLocalCurrency,
    this.amountStandardCurrency,
    this.regularNetworkFee,
    this.priorityNetworkFee,
    this.usdTotal,
    this.totalAmountLocalCurrency,
  });

  FeeCalcResponse copyWith({
    double? amountLocalCurrency,
    double? amountStandardCurrency,
    double? regularNetworkFee,
    double? priorityNetworkFee,
    double? usdTotal,
    double? totalAmountLocalCurrency,
  }) => FeeCalcResponse(
    amountLocalCurrency: amountLocalCurrency ?? this.amountLocalCurrency,
    amountStandardCurrency:
        amountStandardCurrency ?? this.amountStandardCurrency,
    regularNetworkFee: regularNetworkFee ?? this.regularNetworkFee,
    priorityNetworkFee: priorityNetworkFee ?? this.priorityNetworkFee,
    usdTotal: usdTotal ?? this.usdTotal,
    totalAmountLocalCurrency:
        totalAmountLocalCurrency ?? this.totalAmountLocalCurrency,
  );

  factory FeeCalcResponse.fromJson(Map<String, dynamic> json) =>
      FeeCalcResponse(
        amountLocalCurrency: json["amountLocalCurrency"],
        amountStandardCurrency: json["amountStandardCurrency"]?.toDouble(),
        regularNetworkFee: json["regularNetworkFee"],
        priorityNetworkFee: json["priorityNetworkFee"],
        usdTotal: json["usdTotal"]?.toDouble(),
        totalAmountLocalCurrency: json["totalAmountLocalCurrency"],
      );

  Map<String, dynamic> toJson() => {
    "amountLocalCurrency": amountLocalCurrency,
    "amountStandardCurrency": amountStandardCurrency,
    "regularNetworkFee": regularNetworkFee,
    "priorityNetworkFee": priorityNetworkFee,
    "usdTotal": usdTotal,
    "totalAmountLocalCurrency": totalAmountLocalCurrency,
  };

  factory FeeCalcResponse.empty() => FeeCalcResponse(
    amountLocalCurrency: 0,
    amountStandardCurrency: 0.0,
    regularNetworkFee: 0,
    priorityNetworkFee: 0,
    usdTotal: 0.0,
    totalAmountLocalCurrency: 0,
  );
}
