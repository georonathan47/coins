// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'country.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Country {

@HiveField(0) int get id;@HiveField(1) String get countryName;@HiveField(2) String get countryCurrency;@HiveField(3) String get countryFlag;@HiveField(4) String get bankList;
/// Create a copy of Country
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CountryCopyWith<Country> get copyWith => _$CountryCopyWithImpl<Country>(this as Country, _$identity);

  /// Serializes this Country to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Country&&(identical(other.id, id) || other.id == id)&&(identical(other.countryName, countryName) || other.countryName == countryName)&&(identical(other.countryCurrency, countryCurrency) || other.countryCurrency == countryCurrency)&&(identical(other.countryFlag, countryFlag) || other.countryFlag == countryFlag)&&(identical(other.bankList, bankList) || other.bankList == bankList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,countryName,countryCurrency,countryFlag,bankList);

@override
String toString() {
  return 'Country(id: $id, countryName: $countryName, countryCurrency: $countryCurrency, countryFlag: $countryFlag, bankList: $bankList)';
}


}

/// @nodoc
abstract mixin class $CountryCopyWith<$Res>  {
  factory $CountryCopyWith(Country value, $Res Function(Country) _then) = _$CountryCopyWithImpl;
@useResult
$Res call({
@HiveField(0) int id,@HiveField(1) String countryName,@HiveField(2) String countryCurrency,@HiveField(3) String countryFlag,@HiveField(4) String bankList
});




}
/// @nodoc
class _$CountryCopyWithImpl<$Res>
    implements $CountryCopyWith<$Res> {
  _$CountryCopyWithImpl(this._self, this._then);

  final Country _self;
  final $Res Function(Country) _then;

/// Create a copy of Country
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? countryName = null,Object? countryCurrency = null,Object? countryFlag = null,Object? bankList = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,countryName: null == countryName ? _self.countryName : countryName // ignore: cast_nullable_to_non_nullable
as String,countryCurrency: null == countryCurrency ? _self.countryCurrency : countryCurrency // ignore: cast_nullable_to_non_nullable
as String,countryFlag: null == countryFlag ? _self.countryFlag : countryFlag // ignore: cast_nullable_to_non_nullable
as String,bankList: null == bankList ? _self.bankList : bankList // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Country implements Country {
  const _Country({@HiveField(0) required this.id, @HiveField(1) required this.countryName, @HiveField(2) required this.countryCurrency, @HiveField(3) required this.countryFlag, @HiveField(4) required this.bankList});
  factory _Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);

@override@HiveField(0) final  int id;
@override@HiveField(1) final  String countryName;
@override@HiveField(2) final  String countryCurrency;
@override@HiveField(3) final  String countryFlag;
@override@HiveField(4) final  String bankList;

/// Create a copy of Country
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CountryCopyWith<_Country> get copyWith => __$CountryCopyWithImpl<_Country>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CountryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Country&&(identical(other.id, id) || other.id == id)&&(identical(other.countryName, countryName) || other.countryName == countryName)&&(identical(other.countryCurrency, countryCurrency) || other.countryCurrency == countryCurrency)&&(identical(other.countryFlag, countryFlag) || other.countryFlag == countryFlag)&&(identical(other.bankList, bankList) || other.bankList == bankList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,countryName,countryCurrency,countryFlag,bankList);

@override
String toString() {
  return 'Country(id: $id, countryName: $countryName, countryCurrency: $countryCurrency, countryFlag: $countryFlag, bankList: $bankList)';
}


}

/// @nodoc
abstract mixin class _$CountryCopyWith<$Res> implements $CountryCopyWith<$Res> {
  factory _$CountryCopyWith(_Country value, $Res Function(_Country) _then) = __$CountryCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) int id,@HiveField(1) String countryName,@HiveField(2) String countryCurrency,@HiveField(3) String countryFlag,@HiveField(4) String bankList
});




}
/// @nodoc
class __$CountryCopyWithImpl<$Res>
    implements _$CountryCopyWith<$Res> {
  __$CountryCopyWithImpl(this._self, this._then);

  final _Country _self;
  final $Res Function(_Country) _then;

/// Create a copy of Country
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? countryName = null,Object? countryCurrency = null,Object? countryFlag = null,Object? bankList = null,}) {
  return _then(_Country(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,countryName: null == countryName ? _self.countryName : countryName // ignore: cast_nullable_to_non_nullable
as String,countryCurrency: null == countryCurrency ? _self.countryCurrency : countryCurrency // ignore: cast_nullable_to_non_nullable
as String,countryFlag: null == countryFlag ? _self.countryFlag : countryFlag // ignore: cast_nullable_to_non_nullable
as String,bankList: null == bankList ? _self.bankList : bankList // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
