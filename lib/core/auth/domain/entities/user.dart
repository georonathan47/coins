import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
import 'dart:convert';

import '../../../data/hive_adapters.dart';

part 'user.freezed.dart';
part 'user.g.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

@freezed
@HiveType(typeId: HiveAdapters.user)
abstract class User with _$User {
  const User._();

  const factory User({
    bool? rememberMe,
    String? password,
    String? captchaResponse,
    @HiveField(0) int? userId,
    @HiveField(1) String? email,
    @HiveField(2) DateTime? dob,
    @HiveField(3) int? countryId,
    @HiveField(4) String? gender,
    @HiveField(5) String? country,
    @HiveField(6) String? lastname,
    @HiveField(7) bool? mfaEnabled,
    @HiveField(8) bool? legacyUser,
    @HiveField(9) String? firstname,
    @HiveField(10) String? phoneNumber,
    @HiveField(11) String? profilePicture,
  }) = _User;


  String get fullName => '$firstname $lastname';

  factory User.empty() => const User();

  /// Convert from json to model
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
