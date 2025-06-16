import 'dart:convert';

Currency currencyFromJson(String str) => Currency.fromJson(json.decode(str));

String currencyToJson(Currency data) => json.encode(data.toJson());

class Currency {
  int id;
  String currencyName;
  String address;
  bool buyStatus;
  bool sellStatus;
  String imageFile;
  String note;

  Currency({
    required this.id,
    required this.currencyName,
    required this.address,
    required this.buyStatus,
    required this.sellStatus,
    required this.imageFile,
    required this.note,
  });

  Currency copyWith({
    int? id,
    String? currencyName,
    String? address,
    bool? buyStatus,
    bool? sellStatus,
    String? imageFile,
    String? note,
  }) => Currency(
    id: id ?? this.id,
    currencyName: currencyName ?? this.currencyName,
    address: address ?? this.address,
    buyStatus: buyStatus ?? this.buyStatus,
    sellStatus: sellStatus ?? this.sellStatus,
    imageFile: imageFile ?? this.imageFile,
    note: note ?? this.note,
  );

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
    id: json["id"],
    currencyName: json["currencyName"],
    address: json["address"],
    buyStatus: json["buyStatus"],
    sellStatus: json["sellStatus"],
    imageFile: json["imageFile"],
    note: json["note"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "currencyName": currencyName,
    "address": address,
    "buyStatus": buyStatus,
    "sellStatus": sellStatus,
    "imageFile": imageFile,
    "note": note,
  };
}
