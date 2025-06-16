// To parse this JSON data, do
//
//     final feeCalcResponse = feeCalcResponseFromJson(jsonString);

import 'dart:convert';

FeeCalcResponse feeCalcResponseFromJson(String str) => FeeCalcResponse.fromJson(json.decode(str));

String feeCalcResponseToJson(FeeCalcResponse data) => json.encode(data.toJson());

class FeeCalcResponse {
    int? id;
    int? startAmount;
    int? endAmount;
    int? regularFee;
    int? priorityFee;
    String? networkFeePaymentType;
    String? ecurrencyName;

    FeeCalcResponse({
        this.id,
        this.startAmount,
        this.endAmount,
        this.regularFee,
        this.priorityFee,
        this.networkFeePaymentType,
        this.ecurrencyName,
    });

    FeeCalcResponse copyWith({
        int? id,
        int? startAmount,
        int? endAmount,
        int? regularFee,
        int? priorityFee,
        String? networkFeePaymentType,
        String? ecurrencyName,
    }) =>
        FeeCalcResponse(
            id: id ?? this.id,
            startAmount: startAmount ?? this.startAmount,
            endAmount: endAmount ?? this.endAmount,
            regularFee: regularFee ?? this.regularFee,
            priorityFee: priorityFee ?? this.priorityFee,
            networkFeePaymentType: networkFeePaymentType ?? this.networkFeePaymentType,
            ecurrencyName: ecurrencyName ?? this.ecurrencyName,
        );

    factory FeeCalcResponse.fromJson(Map<String, dynamic> json) => FeeCalcResponse(
        id: json["id"],
        startAmount: json["startAmount"],
        endAmount: json["endAmount"],
        regularFee: json["regularFee"],
        priorityFee: json["priorityFee"],
        networkFeePaymentType: json["networkFeePaymentType"],
        ecurrencyName: json["ecurrencyName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "startAmount": startAmount,
        "endAmount": endAmount,
        "regularFee": regularFee,
        "priorityFee": priorityFee,
        "networkFeePaymentType": networkFeePaymentType,
        "ecurrencyName": ecurrencyName,
    };
}
