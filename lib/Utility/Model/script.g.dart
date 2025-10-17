// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'script.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScriptAdapter extends TypeAdapter<Script> {
  @override
  final int typeId = 0;

  @override
  Script read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Script(
      symbol: fields[0] as String,
      exchange: fields[1] as String,
      company: fields[2] as String,
      ltp: fields[3] as double,
      change: fields[4] as double,
      close: fields[5] as double,
      open: fields[8] as double,
      high: fields[6] as double,
      low: fields[7] as double,
      prevltp: (fields[9] as List).cast<double>(),
    );
  }

  @override
  void write(BinaryWriter writer, Script obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.symbol)
      ..writeByte(1)
      ..write(obj.exchange)
      ..writeByte(2)
      ..write(obj.company)
      ..writeByte(3)
      ..write(obj.ltp)
      ..writeByte(4)
      ..write(obj.change)
      ..writeByte(5)
      ..write(obj.close)
      ..writeByte(6)
      ..write(obj.high)
      ..writeByte(7)
      ..write(obj.low)
      ..writeByte(8)
      ..write(obj.open)
      ..writeByte(9)
      ..write(obj.prevltp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScriptAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
