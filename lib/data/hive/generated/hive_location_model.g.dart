// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../hive_models/hive_location_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveLocationModelAdapter extends TypeAdapter<HiveLocationModel> {
  @override
  final int typeId = 3;

  @override
  HiveLocationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveLocationModel(
      lat: fields[0] as double?,
      lon: fields[1] as double?,
      city: fields[2] as String?,
      country: fields[3] as String?,
      state: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveLocationModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.lat)
      ..writeByte(1)
      ..write(obj.lon)
      ..writeByte(2)
      ..write(obj.city)
      ..writeByte(3)
      ..write(obj.country)
      ..writeByte(4)
      ..write(obj.state);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveLocationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
