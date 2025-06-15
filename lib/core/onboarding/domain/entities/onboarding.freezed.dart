// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Onboarding {

/// Onboarding status
@HiveField(0) bool get onboardingComplete;
/// Create a copy of Onboarding
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingCopyWith<Onboarding> get copyWith => _$OnboardingCopyWithImpl<Onboarding>(this as Onboarding, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Onboarding&&(identical(other.onboardingComplete, onboardingComplete) || other.onboardingComplete == onboardingComplete));
}


@override
int get hashCode => Object.hash(runtimeType,onboardingComplete);

@override
String toString() {
  return 'Onboarding(onboardingComplete: $onboardingComplete)';
}


}

/// @nodoc
abstract mixin class $OnboardingCopyWith<$Res>  {
  factory $OnboardingCopyWith(Onboarding value, $Res Function(Onboarding) _then) = _$OnboardingCopyWithImpl;
@useResult
$Res call({
@HiveField(0) bool onboardingComplete
});




}
/// @nodoc
class _$OnboardingCopyWithImpl<$Res>
    implements $OnboardingCopyWith<$Res> {
  _$OnboardingCopyWithImpl(this._self, this._then);

  final Onboarding _self;
  final $Res Function(Onboarding) _then;

/// Create a copy of Onboarding
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? onboardingComplete = null,}) {
  return _then(_self.copyWith(
onboardingComplete: null == onboardingComplete ? _self.onboardingComplete : onboardingComplete // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _Onboarding extends Onboarding {
  const _Onboarding({@HiveField(0) required this.onboardingComplete}): super._();
  

/// Onboarding status
@override@HiveField(0) final  bool onboardingComplete;

/// Create a copy of Onboarding
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingCopyWith<_Onboarding> get copyWith => __$OnboardingCopyWithImpl<_Onboarding>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Onboarding&&(identical(other.onboardingComplete, onboardingComplete) || other.onboardingComplete == onboardingComplete));
}


@override
int get hashCode => Object.hash(runtimeType,onboardingComplete);

@override
String toString() {
  return 'Onboarding(onboardingComplete: $onboardingComplete)';
}


}

/// @nodoc
abstract mixin class _$OnboardingCopyWith<$Res> implements $OnboardingCopyWith<$Res> {
  factory _$OnboardingCopyWith(_Onboarding value, $Res Function(_Onboarding) _then) = __$OnboardingCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) bool onboardingComplete
});




}
/// @nodoc
class __$OnboardingCopyWithImpl<$Res>
    implements _$OnboardingCopyWith<$Res> {
  __$OnboardingCopyWithImpl(this._self, this._then);

  final _Onboarding _self;
  final $Res Function(_Onboarding) _then;

/// Create a copy of Onboarding
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? onboardingComplete = null,}) {
  return _then(_Onboarding(
onboardingComplete: null == onboardingComplete ? _self.onboardingComplete : onboardingComplete // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
