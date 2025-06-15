// To parse this JSON data, do
//
//     final verifyOtpModel = verifyOtpModelFromJson(jsonString);

import 'dart:convert';

VerifyOtpModel verifyOtpModelFromJson(String str) =>
    VerifyOtpModel.fromJson(json.decode(str));

String verifyOtpModelToJson(VerifyOtpModel data) => json.encode(data.toJson());

class VerifyOtpModel {
  String? type, otp;

  VerifyOtpModel({this.type, this.otp});

  VerifyOtpModel copyWith({String? type, String? otp}) =>
      VerifyOtpModel(type: type ?? this.type, otp: otp ?? this.otp);

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) =>
      VerifyOtpModel(type: json["type"], otp: json["otp"]);

  Map<String, dynamic> toJson() => {"type": type, "otp": otp};
}
