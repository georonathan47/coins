import 'dart:convert';

import 'package:hive_ce/hive.dart';

import '../../../../core/shared/data/hive_adapters.dart';

part 'currency.g.dart';

Currency currencyFromJson(String str) => Currency.fromJson(json.decode(str));

String currencyToJson(Currency data) => json.encode(data.toJson());

@HiveType(typeId: HiveAdapters.currencies)
class Currency {
  @HiveField(0)
  int id;
  @HiveField(1)
  String currencyName;
  @HiveField(2)
  String address;
  @HiveField(3)
  bool buyStatus;
  @HiveField(4)
  bool sellStatus;
  @HiveField(5)
  String imageFile;
  @HiveField(6)
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
    note: json["note"],
    address: json["address"],
    buyStatus: json["buyStatus"],
    imageFile: json["imageFile"],
    sellStatus: json["sellStatus"],
    currencyName: json["currencyName"],
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

  factory Currency.empty() => Currency(
    id: 0,
    currencyName: '',
    address: '',
    buyStatus: false,
    sellStatus: false,
    imageFile: '',
    note: '',
  );
}
