// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OnboardingAdapter extends TypeAdapter<Onboarding> {
  @override
  final typeId = 2;

  @override
  Onboarding read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Onboarding(onboardingComplete: fields[0] as bool);
  }

  @override
  void write(BinaryWriter writer, Onboarding obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.onboardingComplete);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OnboardingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
