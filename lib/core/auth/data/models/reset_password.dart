// To parse this JSON data, do
//
//     final resetPassword = resetPasswordFromJson(jsonString);

import 'dart:convert';

ResetPassword resetPasswordFromJson(String str) => ResetPassword.fromJson(json.decode(str));

String resetPasswordToJson(ResetPassword data) => json.encode(data.toJson());

class ResetPassword {
    int? userId;
    String? newPassword;

    ResetPassword({
        this.userId,
        this.newPassword,
    });

    ResetPassword copyWith({
        int? userId,
        String? newPassword,
    }) =>
        ResetPassword(
            userId: userId ?? this.userId,
            newPassword: newPassword ?? this.newPassword,
        );

    factory ResetPassword.fromJson(Map<String, dynamic> json) => ResetPassword(
        userId: json["userId"],
        newPassword: json["newPassword"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "newPassword": newPassword,
    };
}
