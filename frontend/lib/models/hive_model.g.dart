// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalBathAdapter extends TypeAdapter<LocalBath> {
  @override
  final int typeId = 0;

  @override
  LocalBath read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalBath(
      bid: fields[0] as String,
      name: fields[1] as String,
      city: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LocalBath obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.bid)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.city);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalBathAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
