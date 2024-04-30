// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../hive_models/hive_weather_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveWeatherModelAdapter extends TypeAdapter<HiveWeatherModel> {
  @override
  final int typeId = 0;

  @override
  HiveWeatherModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveWeatherModel(
      city: fields[0] as String?,
      lat: fields[1] as double?,
      lon: fields[2] as double?,
      icon: fields[3] as String?,
      description: fields[4] as String?,
      sunrise: fields[5] as double?,
      sunset: fields[6] as double?,
      speed: fields[7] as double?,
      deg: fields[8] as double?,
      gust: fields[9] as double?,
      temp: fields[10] as double?,
      feelsLike: fields[11] as double?,
      tempMin: fields[12] as double?,
      tempMax: fields[13] as double?,
      pressure: fields[14] as double?,
      humidity: fields[15] as double?,
      seaLevel: fields[16] as double?,
      grndLevel: fields[17] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveWeatherModel obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.city)
      ..writeByte(1)
      ..write(obj.lat)
      ..writeByte(2)
      ..write(obj.lon)
      ..writeByte(3)
      ..write(obj.icon)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.sunrise)
      ..writeByte(6)
      ..write(obj.sunset)
      ..writeByte(7)
      ..write(obj.speed)
      ..writeByte(8)
      ..write(obj.deg)
      ..writeByte(9)
      ..write(obj.gust)
      ..writeByte(10)
      ..write(obj.temp)
      ..writeByte(11)
      ..write(obj.feelsLike)
      ..writeByte(12)
      ..write(obj.tempMin)
      ..writeByte(13)
      ..write(obj.tempMax)
      ..writeByte(14)
      ..write(obj.pressure)
      ..writeByte(15)
      ..write(obj.humidity)
      ..writeByte(16)
      ..write(obj.seaLevel)
      ..writeByte(17)
      ..write(obj.grndLevel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveWeatherModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
