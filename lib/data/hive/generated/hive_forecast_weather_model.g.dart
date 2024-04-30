// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../hive_models/hive_forecast_weather_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveForecastWeatherModelAdapter
    extends TypeAdapter<HiveForecastWeatherModel> {
  @override
  final int typeId = 1;

  @override
  HiveForecastWeatherModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveForecastWeatherModel(
      datetime: fields[0] as double?,
      icon: fields[1] as String?,
      temp: fields[2] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveForecastWeatherModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.datetime)
      ..writeByte(1)
      ..write(obj.icon)
      ..writeByte(2)
      ..write(obj.temp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveForecastWeatherModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveForecastWeatherListModelAdapter
    extends TypeAdapter<HiveForecastWeatherListModel> {
  @override
  final int typeId = 2;

  @override
  HiveForecastWeatherListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveForecastWeatherListModel(
      country: fields[0] as String?,
      sunrise: fields[1] as double?,
      sunset: fields[2] as double?,
      weatherList: (fields[3] as List?)?.cast<HiveForecastWeatherModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, HiveForecastWeatherListModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.country)
      ..writeByte(1)
      ..write(obj.sunrise)
      ..writeByte(2)
      ..write(obj.sunset)
      ..writeByte(3)
      ..write(obj.weatherList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveForecastWeatherListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
