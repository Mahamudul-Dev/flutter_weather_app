import 'package:hive/hive.dart';
part '../generated/hive_weather_model.g.dart';

@HiveType(typeId: 0)
class HiveWeatherModel extends HiveObject {
  @HiveField(0)
  String? city;
  @HiveField(1)
  double? lat;
  @HiveField(2)
  double? lon;
  @HiveField(3)
  String? icon;
  @HiveField(4)
  String? description;
  @HiveField(5)
  double? sunrise;
  @HiveField(6)
  double? sunset;
  @HiveField(7)
  double? speed;
  @HiveField(8)
  double? deg;
  @HiveField(9)
  double? gust;
  @HiveField(10)
  double? temp;
  @HiveField(11)
  double? feelsLike;
  @HiveField(12)
  double? tempMin;
  @HiveField(13)
  double? tempMax;
  @HiveField(14)
  double? pressure;
  @HiveField(15)
  double? humidity;
  @HiveField(16)
  double? seaLevel;
  @HiveField(17)
  double? grndLevel;

  HiveWeatherModel({
    this.city,
    this.lat,
    this.lon,
    this.icon,
    this.description,
    this.sunrise,
    this.sunset,
    this.speed,
    this.deg,
    this.gust,
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.grndLevel,
  });
}
