// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CountryAdapter extends TypeAdapter<Country> {
  @override
  final typeId = 1;

  @override
  Country read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Country(
      id: (fields[0] as num).toInt(),
      countryName: fields[1] as String,
      countryCurrency: fields[2] as String,
      countryFlag: fields[3] as String,
      bankList: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Country obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.countryName)
      ..writeByte(2)
      ..write(obj.countryCurrency)
      ..writeByte(3)
      ..write(obj.countryFlag)
      ..writeByte(4)
      ..write(obj.bankList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Country _$CountryFromJson(Map<String, dynamic> json) => _Country(
  id: (json['id'] as num).toInt(),
  countryName: json['countryName'] as String,
  countryCurrency: json['countryCurrency'] as String,
  countryFlag: json['countryFlag'] as String,
  bankList: json['bankList'] as String,
);

Map<String, dynamic> _$CountryToJson(_Country instance) => <String, dynamic>{
  'id': instance.id,
  'countryName': instance.countryName,
  'countryCurrency': instance.countryCurrency,
  'countryFlag': instance.countryFlag,
  'bankList': instance.bankList,
};
