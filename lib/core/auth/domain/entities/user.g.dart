// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      userId: (fields[0] as num?)?.toInt(),
      email: fields[1] as String?,
      dob: fields[2] as DateTime?,
      countryId: (fields[3] as num?)?.toInt(),
      gender: fields[4] as String?,
      country: fields[5] as String?,
      lastname: fields[6] as String?,
      mfaEnabled: fields[7] as bool?,
      legacyUser: fields[8] as bool?,
      firstname: fields[9] as String?,
      phoneNumber: fields[10] as String?,
      profilePicture: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.dob)
      ..writeByte(3)
      ..write(obj.countryId)
      ..writeByte(4)
      ..write(obj.gender)
      ..writeByte(5)
      ..write(obj.country)
      ..writeByte(6)
      ..write(obj.lastname)
      ..writeByte(7)
      ..write(obj.mfaEnabled)
      ..writeByte(8)
      ..write(obj.legacyUser)
      ..writeByte(9)
      ..write(obj.firstname)
      ..writeByte(10)
      ..write(obj.phoneNumber)
      ..writeByte(11)
      ..write(obj.profilePicture);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  rememberMe: json['rememberMe'] as bool?,
  password: json['password'] as String?,
  captchaResponse: json['captchaResponse'] as String?,
  userId: (json['userId'] as num?)?.toInt(),
  email: json['email'] as String?,
  dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
  countryId: (json['countryId'] as num?)?.toInt(),
  gender: json['gender'] as String?,
  country: json['country'] as String?,
  lastname: json['lastname'] as String?,
  mfaEnabled: json['mfaEnabled'] as bool?,
  legacyUser: json['legacyUser'] as bool?,
  firstname: json['firstname'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  profilePicture: json['profilePicture'] as String?,
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'rememberMe': instance.rememberMe,
  'password': instance.password,
  'captchaResponse': instance.captchaResponse,
  'userId': instance.userId,
  'email': instance.email,
  'dob': instance.dob?.toIso8601String(),
  'countryId': instance.countryId,
  'gender': instance.gender,
  'country': instance.country,
  'lastname': instance.lastname,
  'mfaEnabled': instance.mfaEnabled,
  'legacyUser': instance.legacyUser,
  'firstname': instance.firstname,
  'phoneNumber': instance.phoneNumber,
  'profilePicture': instance.profilePicture,
};
