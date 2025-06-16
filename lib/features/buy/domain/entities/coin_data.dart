import 'dart:convert';

CoinData coinDataFromJson(String str) => CoinData.fromJson(json.decode(str));

String coinDataToJson(CoinData data) => json.encode(data.toJson());

class CoinData {
    int id;
    String name;
    String icon;
    String color;
    String price;
    String symbol;
    List<double> sparkline;
    String percentageChange;
    List<dynamic> displaySection;

    CoinData({
        required this.id,
        required this.name,
        required this.icon,
        required this.color,
        required this.price,
        required this.symbol,
        required this.sparkline,
        required this.percentageChange,
        required this.displaySection,
    });

    CoinData copyWith({
        int? id,
        String? name,
        String? icon,
        String? color,
        String? price,
        String? symbol,
        List<double>? sparkline,
        String? percentageChange,
        List<dynamic>? displaySection,
    }) =>
        CoinData(
            id: id ?? this.id,
            name: name ?? this.name,
            icon: icon ?? this.icon,
            color: color ?? this.color,
            price: price ?? this.price,
            symbol: symbol ?? this.symbol,
            sparkline: sparkline ?? this.sparkline,
            percentageChange: percentageChange ?? this.percentageChange,
            displaySection: displaySection ?? this.displaySection,
        );

    factory CoinData.fromJson(Map<String, dynamic> json) => CoinData(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
        color: json["color"],
        price: json["price"],
        symbol: json["symbol"],
        sparkline: List<double>.from(json["sparkline"].map((x) => x.toDouble())),
        percentageChange: json["percentageChange"],
        displaySection: List<dynamic>.from(json["displaySection"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
        "color": color,
        "price": price,
        "symbol": symbol,
        "sparkline": List<dynamic>.from(sparkline.map((x) => x)),
        "percentageChange": percentageChange,
        "displaySection": List<dynamic>.from(displaySection.map((x) => x)),
    };
}
