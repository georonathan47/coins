// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$User {

 bool? get rememberMe; String? get password; String? get captchaResponse;@HiveField(0) int? get userId;@HiveField(1) String? get email;@HiveField(2) DateTime? get dob;@HiveField(3) int? get countryId;@HiveField(4) String? get gender;@HiveField(5) String? get country;@HiveField(6) String? get lastname;@HiveField(7) bool? get mfaEnabled;@HiveField(8) bool? get legacyUser;@HiveField(9) String? get firstname;@HiveField(10) String? get phoneNumber;@HiveField(11) String? get profilePicture;
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCopyWith<User> get copyWith => _$UserCopyWithImpl<User>(this as User, _$identity);

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is User&&(identical(other.rememberMe, rememberMe) || other.rememberMe == rememberMe)&&(identical(other.password, password) || other.password == password)&&(identical(other.captchaResponse, captchaResponse) || other.captchaResponse == captchaResponse)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.countryId, countryId) || other.countryId == countryId)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.country, country) || other.country == country)&&(identical(other.lastname, lastname) || other.lastname == lastname)&&(identical(other.mfaEnabled, mfaEnabled) || other.mfaEnabled == mfaEnabled)&&(identical(other.legacyUser, legacyUser) || other.legacyUser == legacyUser)&&(identical(other.firstname, firstname) || other.firstname == firstname)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rememberMe,password,captchaResponse,userId,email,dob,countryId,gender,country,lastname,mfaEnabled,legacyUser,firstname,phoneNumber,profilePicture);

@override
String toString() {
  return 'User(rememberMe: $rememberMe, password: $password, captchaResponse: $captchaResponse, userId: $userId, email: $email, dob: $dob, countryId: $countryId, gender: $gender, country: $country, lastname: $lastname, mfaEnabled: $mfaEnabled, legacyUser: $legacyUser, firstname: $firstname, phoneNumber: $phoneNumber, profilePicture: $profilePicture)';
}


}

/// @nodoc
abstract mixin class $UserCopyWith<$Res>  {
  factory $UserCopyWith(User value, $Res Function(User) _then) = _$UserCopyWithImpl;
@useResult
$Res call({
 bool? rememberMe, String? password, String? captchaResponse,@HiveField(0) int? userId,@HiveField(1) String? email,@HiveField(2) DateTime? dob,@HiveField(3) int? countryId,@HiveField(4) String? gender,@HiveField(5) String? country,@HiveField(6) String? lastname,@HiveField(7) bool? mfaEnabled,@HiveField(8) bool? legacyUser,@HiveField(9) String? firstname,@HiveField(10) String? phoneNumber,@HiveField(11) String? profilePicture
});




}
/// @nodoc
class _$UserCopyWithImpl<$Res>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rememberMe = freezed,Object? password = freezed,Object? captchaResponse = freezed,Object? userId = freezed,Object? email = freezed,Object? dob = freezed,Object? countryId = freezed,Object? gender = freezed,Object? country = freezed,Object? lastname = freezed,Object? mfaEnabled = freezed,Object? legacyUser = freezed,Object? firstname = freezed,Object? phoneNumber = freezed,Object? profilePicture = freezed,}) {
  return _then(_self.copyWith(
rememberMe: freezed == rememberMe ? _self.rememberMe : rememberMe // ignore: cast_nullable_to_non_nullable
as bool?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,captchaResponse: freezed == captchaResponse ? _self.captchaResponse : captchaResponse // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,dob: freezed == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as DateTime?,countryId: freezed == countryId ? _self.countryId : countryId // ignore: cast_nullable_to_non_nullable
as int?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,lastname: freezed == lastname ? _self.lastname : lastname // ignore: cast_nullable_to_non_nullable
as String?,mfaEnabled: freezed == mfaEnabled ? _self.mfaEnabled : mfaEnabled // ignore: cast_nullable_to_non_nullable
as bool?,legacyUser: freezed == legacyUser ? _self.legacyUser : legacyUser // ignore: cast_nullable_to_non_nullable
as bool?,firstname: freezed == firstname ? _self.firstname : firstname // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,profilePicture: freezed == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _User extends User {
  const _User({this.rememberMe, this.password, this.captchaResponse, @HiveField(0) this.userId, @HiveField(1) this.email, @HiveField(2) this.dob, @HiveField(3) this.countryId, @HiveField(4) this.gender, @HiveField(5) this.country, @HiveField(6) this.lastname, @HiveField(7) this.mfaEnabled, @HiveField(8) this.legacyUser, @HiveField(9) this.firstname, @HiveField(10) this.phoneNumber, @HiveField(11) this.profilePicture}): super._();
  factory _User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

@override final  bool? rememberMe;
@override final  String? password;
@override final  String? captchaResponse;
@override@HiveField(0) final  int? userId;
@override@HiveField(1) final  String? email;
@override@HiveField(2) final  DateTime? dob;
@override@HiveField(3) final  int? countryId;
@override@HiveField(4) final  String? gender;
@override@HiveField(5) final  String? country;
@override@HiveField(6) final  String? lastname;
@override@HiveField(7) final  bool? mfaEnabled;
@override@HiveField(8) final  bool? legacyUser;
@override@HiveField(9) final  String? firstname;
@override@HiveField(10) final  String? phoneNumber;
@override@HiveField(11) final  String? profilePicture;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCopyWith<_User> get copyWith => __$UserCopyWithImpl<_User>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _User&&(identical(other.rememberMe, rememberMe) || other.rememberMe == rememberMe)&&(identical(other.password, password) || other.password == password)&&(identical(other.captchaResponse, captchaResponse) || other.captchaResponse == captchaResponse)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.countryId, countryId) || other.countryId == countryId)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.country, country) || other.country == country)&&(identical(other.lastname, lastname) || other.lastname == lastname)&&(identical(other.mfaEnabled, mfaEnabled) || other.mfaEnabled == mfaEnabled)&&(identical(other.legacyUser, legacyUser) || other.legacyUser == legacyUser)&&(identical(other.firstname, firstname) || other.firstname == firstname)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rememberMe,password,captchaResponse,userId,email,dob,countryId,gender,country,lastname,mfaEnabled,legacyUser,firstname,phoneNumber,profilePicture);

@override
String toString() {
  return 'User(rememberMe: $rememberMe, password: $password, captchaResponse: $captchaResponse, userId: $userId, email: $email, dob: $dob, countryId: $countryId, gender: $gender, country: $country, lastname: $lastname, mfaEnabled: $mfaEnabled, legacyUser: $legacyUser, firstname: $firstname, phoneNumber: $phoneNumber, profilePicture: $profilePicture)';
}


}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) = __$UserCopyWithImpl;
@override @useResult
$Res call({
 bool? rememberMe, String? password, String? captchaResponse,@HiveField(0) int? userId,@HiveField(1) String? email,@HiveField(2) DateTime? dob,@HiveField(3) int? countryId,@HiveField(4) String? gender,@HiveField(5) String? country,@HiveField(6) String? lastname,@HiveField(7) bool? mfaEnabled,@HiveField(8) bool? legacyUser,@HiveField(9) String? firstname,@HiveField(10) String? phoneNumber,@HiveField(11) String? profilePicture
});




}
/// @nodoc
class __$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rememberMe = freezed,Object? password = freezed,Object? captchaResponse = freezed,Object? userId = freezed,Object? email = freezed,Object? dob = freezed,Object? countryId = freezed,Object? gender = freezed,Object? country = freezed,Object? lastname = freezed,Object? mfaEnabled = freezed,Object? legacyUser = freezed,Object? firstname = freezed,Object? phoneNumber = freezed,Object? profilePicture = freezed,}) {
  return _then(_User(
rememberMe: freezed == rememberMe ? _self.rememberMe : rememberMe // ignore: cast_nullable_to_non_nullable
as bool?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,captchaResponse: freezed == captchaResponse ? _self.captchaResponse : captchaResponse // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,dob: freezed == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as DateTime?,countryId: freezed == countryId ? _self.countryId : countryId // ignore: cast_nullable_to_non_nullable
as int?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,lastname: freezed == lastname ? _self.lastname : lastname // ignore: cast_nullable_to_non_nullable
as String?,mfaEnabled: freezed == mfaEnabled ? _self.mfaEnabled : mfaEnabled // ignore: cast_nullable_to_non_nullable
as bool?,legacyUser: freezed == legacyUser ? _self.legacyUser : legacyUser // ignore: cast_nullable_to_non_nullable
as bool?,firstname: freezed == firstname ? _self.firstname : firstname // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,profilePicture: freezed == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
