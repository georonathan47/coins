import 'dart:convert';

MarketData marketDataFromJson(String str) =>
    MarketData.fromJson(json.decode(str));

String marketDataToJson(MarketData data) => json.encode(data.toJson());

class MarketData {
  final int id;
  final String currencyName;
  final String address;
  final bool buyStatus;
  final bool sellStatus;
  final List<String> imageFile;
  final String note;

  MarketData({
    required this.id,
    required this.currencyName,
    required this.address,
    required this.buyStatus,
    required this.sellStatus,
    required this.imageFile,
    required this.note,
  });

  factory MarketData.fromJson(Map<String, dynamic> json) => MarketData(
    id: json["id"],
    currencyName: json["currencyName"],
    address: json["address"],
    buyStatus: json["buyStatus"],
    sellStatus: json["sellStatus"],
    imageFile: List<String>.from(json["imageFile"].map((x) => x)),
    note: json["note"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "currencyName": currencyName,
    "address": address,
    "buyStatus": buyStatus,
    "sellStatus": sellStatus,
    "imageFile": List<dynamic>.from(imageFile.map((x) => x)),
    "note": note,
  };
}
