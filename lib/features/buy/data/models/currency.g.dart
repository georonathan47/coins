// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrencyAdapter extends TypeAdapter<Currency> {
  @override
  final typeId = 3;

  @override
  Currency read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Currency(
      id: (fields[0] as num).toInt(),
      currencyName: fields[1] as String,
      address: fields[2] as String,
      buyStatus: fields[3] as bool,
      sellStatus: fields[4] as bool,
      imageFile: fields[5] as String,
      note: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Currency obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.currencyName)
      ..writeByte(2)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.buyStatus)
      ..writeByte(4)
      ..write(obj.sellStatus)
      ..writeByte(5)
      ..write(obj.imageFile)
      ..writeByte(6)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrencyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
