import 'package:hive/hive.dart';

part '../generated/hive_forecast_weather_model.g.dart';

@HiveType(typeId: 1)
class HiveForecastWeatherModel extends HiveObject {
  @HiveField(0)
  final double? datetime;
  @HiveField(1)
  final String? icon;
  @HiveField(2)
  final double? temp;
  HiveForecastWeatherModel({
    this.datetime,
    this.icon,
    this.temp,
  });
}

@HiveType(typeId: 2)
class HiveForecastWeatherListModel extends HiveObject {

  @HiveField(0)
  final String? country;
  @HiveField(1)
  final double? sunrise;
  @HiveField(2)
  final double? sunset;
  @HiveField(3)
  List<HiveForecastWeatherModel>? weatherList;

  HiveForecastWeatherListModel({
    this.country,
    this.sunrise,
    this.sunset,
    this.weatherList,
  });
}
