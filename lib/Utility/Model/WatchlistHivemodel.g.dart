// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WatchlistHivemodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WatchlistHiveModelAdapter extends TypeAdapter<WatchlistHiveModel> {
  @override
  final int typeId = 2;

  @override
  WatchlistHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WatchlistHiveModel(
      (fields[0] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List).cast<Script>())),
    );
  }

  @override
  void write(BinaryWriter writer, WatchlistHiveModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.watchlists);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WatchlistHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
