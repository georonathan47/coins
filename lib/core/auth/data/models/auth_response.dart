// To parse this JSON data, do
//
//     final authResponse = authResponseFromJson(jsonString);

import 'dart:convert';

AuthResponse authResponseFromJson(String str) =>
    AuthResponse.fromJson(json.decode(str));

String authResponseToJson(AuthResponse data) => json.encode(data.toJson());

class AuthResponse {
  int? userId;
  String? userEmail;
  bool? mfaEnabled;
  bool? legacyUser;
  String? accessToken;
  String? refreshToken;

  AuthResponse({
    this.userId,
    this.userEmail,
    this.mfaEnabled,
    this.legacyUser,
    this.accessToken,
    this.refreshToken,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
    userId: json["userId"],
    userEmail: json["userEmail"],
    mfaEnabled: json["mfaEnabled"],
    legacyUser: json["legacyUser"],
    accessToken: json["access_token"],
    refreshToken: json["refresh_token"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "userEmail": userEmail,
    "mfaEnabled": mfaEnabled,
    "legacyUser": legacyUser,
    "access_token": accessToken,
    "refresh_token": refreshToken,
  };
}
