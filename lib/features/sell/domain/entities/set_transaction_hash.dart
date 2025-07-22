import 'dart:convert';

SetTransactionHash setTransactionHashFromJson(String str) =>
    SetTransactionHash.fromJson(json.decode(str));

String setTransactionHashToJson(SetTransactionHash data) =>
    json.encode(data.toJson());

class SetTransactionHash {
  final String orderId;
  final String hashId;
  final DateTime depositDate;

  SetTransactionHash({
    required this.orderId,
    required this.hashId,
    required this.depositDate,
  });

  SetTransactionHash copyWith({
    String? orderId,
    String? hashId,
    DateTime? depositDate,
  }) => SetTransactionHash(
    orderId: orderId ?? this.orderId,
    hashId: hashId ?? this.hashId,
    depositDate: depositDate ?? this.depositDate,
  );

  factory SetTransactionHash.fromJson(Map<String, dynamic> json) =>
      SetTransactionHash(
        orderId: json["orderId"],
        hashId: json["hashId"],
        depositDate: DateTime.parse(json["depositDate"]),
      );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "hashId": hashId,
    "depositDate": depositDate.toIso8601String(),
  };

  factory SetTransactionHash.empty() =>
      SetTransactionHash(orderId: '', hashId: '', depositDate: DateTime.now());
}
