import 'dart:convert';

DashPortfolio dashPortfolioFromJson(String str) =>
    DashPortfolio.fromJson(json.decode(str));

String dashPortfolioToJson(DashPortfolio data) => json.encode(data.toJson());

class DashPortfolio {
  final int userId;
  final double balance;
  final String currency;

  DashPortfolio({
    required this.userId,
    required this.balance,
    required this.currency,
  });

  DashPortfolio copyWith({int? userId, double? balance, String? currency}) =>
      DashPortfolio(
        userId: userId ?? this.userId,
        balance: balance ?? this.balance,
        currency: currency ?? this.currency,
      );

  factory DashPortfolio.fromJson(Map<String, dynamic> json) => DashPortfolio(
    userId: json["userId"],
    balance: json["balance"]?.toDouble(),
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "balance": balance,
    "currency": currency,
  };
}
