import 'dart:convert';

CoinData coinDataFromJson(String str) => CoinData.fromJson(json.decode(str));

String coinDataToJson(CoinData data) => json.encode(data.toJson());

class CoinData {
  int id;
  String name;
  String symbol;
  String price;
  String percentageChange;
  String icon;
  String color;
  List<String> displaySection;
  List<double> sparkline;

  CoinData({
    required this.id,
    required this.name,
    required this.symbol,
    required this.price,
    required this.percentageChange,
    required this.icon,
    required this.color,
    required this.displaySection,
    required this.sparkline,
  });

  CoinData copyWith({
    int? id,
    String? name,
    String? symbol,
    String? price,
    String? percentageChange,
    String? icon,
    String? color,
    List<String>? displaySection,
    List<double>? sparkline,
  }) => CoinData(
    id: id ?? this.id,
    name: name ?? this.name,
    symbol: symbol ?? this.symbol,
    price: price ?? this.price,
    percentageChange: percentageChange ?? this.percentageChange,
    icon: icon ?? this.icon,
    color: color ?? this.color,
    displaySection: displaySection ?? this.displaySection,
    sparkline: sparkline ?? this.sparkline,
  );

  factory CoinData.fromJson(Map<String, dynamic> json) => CoinData(
    id: json["id"],
    icon: json["icon"],
    name: json["name"],
    price: json["price"],
    symbol: json["symbol"],
    color: json["color"] ?? '#000000',
    percentageChange: json["percentageChange"],
    sparkline: List<double>.from(json["sparkline"].map((x) => double.parse(x))),
    displaySection: List<String>.from(json["displaySection"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "symbol": symbol,
    "price": price,
    "percentageChange": percentageChange,
    "icon": icon,
    "color": color,
    "displaySection": List<dynamic>.from(displaySection.map((x) => x)),
    "sparkline": List<dynamic>.from(sparkline.map((x) => x)),
  };

  factory CoinData.empty() {
    return CoinData(
      id: 0,
      name: '',
      symbol: '',
      price: '0.00',
      percentageChange: '0.00',
      icon: '',
      color: '#000000',
      displaySection: [],
      sparkline: [],
    );
  }
}
