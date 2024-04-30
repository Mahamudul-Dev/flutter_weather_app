import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter_weather/data/hive/hive_models/hive_forecast_weather_model.dart';

import '../data/hive/hive_db.dart';
import '../data/hive/hive_models/hive_weather_model.dart';
import '../data/models/models.dart';
import '../network/network.dart';

class WeatherRepository {
  final WeatherNetwork network;
  WeatherRepository(this.network);

  Future<CurrentWeatherResponseModel?> getCurrentWeather(
    double? lat,
    double? lon,
    String? city,
    bool enableSave,
  ) async {
    CurrentWeatherResponseModel? weather;

    try {
      if (lat != null && lon != null) {
        final response = await network.requestCurrentWeatherByLatLon(lat, lon);
        if (response.statusCode == HttpStatus.ok) {
          weather = CurrentWeatherResponseModel.fromJson(
            jsonDecode(
              jsonEncode(response.data),
            ),
          );
        }
      } else {
        final response = await network.requestCurrentWeatherByCity(city!);
        if (response.statusCode == HttpStatus.ok) {
          weather = CurrentWeatherResponseModel.fromJson(
            jsonDecode(
              jsonEncode(response.data),
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Error [getCurrentWeather]: $e');
    }

    if (weather != null && enableSave) {
      await saveCurrentWeatherInfoOffline(weather);
    }

    return weather;
  }

  Future<WeatherForcastResponseModel?> getForcastWeather(
    double? lat,
    double? lon,
    String? city,
    bool enableSave,
  ) async {
    WeatherForcastResponseModel? weather;

    try {
      if (lat != null && lon != null) {
        final response = await network.requestForcastWeatherByLatLon(lat, lon);
        if (response.statusCode == HttpStatus.ok) {
          weather = WeatherForcastResponseModel.fromJson(
            jsonDecode(
              jsonEncode(response.data),
            ),
          );
        }
      } else {
        final response = await network.requestForcastWeatherByCity(city!);
        if (response.statusCode == HttpStatus.ok) {
          weather = WeatherForcastResponseModel.fromJson(
            jsonDecode(
              jsonEncode(response.data),
            ),
          );
        }
      }

      if (weather != null && enableSave) {
        await saveForecastWeatherInfoOffline(weather);
      }
    } catch (e) {
      throw Exception(e);
    }

    return weather;
  }

  Future<void> saveCurrentWeatherInfoOffline(
    CurrentWeatherResponseModel currentWeather,
  ) async {
    final offlineCurrentWeather = HiveWeatherModel(
        city: currentWeather.name,
        lat: currentWeather.coord?.lat,
        lon: currentWeather.coord?.lon,
        icon: currentWeather.weather?.first.icon,
        description: currentWeather.weather?.first.description,
        sunrise: currentWeather.sys?.sunrise,
        sunset: currentWeather.sys?.sunset,
        speed: currentWeather.wind?.speed,
        deg: currentWeather.wind?.deg,
        gust: currentWeather.wind?.gust,
        temp: currentWeather.main?.temp,
        feelsLike: currentWeather.main?.feelsLike,
        tempMin: currentWeather.main?.tempMin,
        tempMax: currentWeather.main?.tempMax,
        pressure: currentWeather.main?.pressure,
        humidity: currentWeather.main?.humidity,
        seaLevel: currentWeather.main?.seaLevel,
        grndLevel: currentWeather.main?.grndLevel);
    try {
      await HiveDB.openBox<HiveWeatherModel>('offlineCurrentWeather').then(
        (currentWeatherBox) {
          currentWeatherBox.clear().then(
            (value) {
              currentWeatherBox.add(offlineCurrentWeather).then(
                    (value) =>
                        debugPrint('Current Weather Data Saved, ID: $value'),
                  );
              currentWeatherBox.close();
            },
          );
        },
      );
    } catch (e) {
      debugPrint('Failed to save data. Error: $e');
    }
  }

  Future<void> saveForecastWeatherInfoOffline(
    WeatherForcastResponseModel weather,
  ) async {
    final ReceivePort receivePort = ReceivePort();

    await Isolate.spawn(
      processWeatherForecastsList,
      [
        receivePort.sendPort,
        weather.toJson(),
      ],
    );

    final HiveForecastWeatherListModel offlineForecastWeather =
        HiveForecastWeatherListModel(
            country: weather.city?.country,
            sunrise: weather.city?.sunrise,
            sunset: weather.city?.sunset);
    final List<HiveForecastWeatherModel> response = await receivePort.first;
    offlineForecastWeather.weatherList = response;

    await HiveDB.openBox<HiveForecastWeatherListModel>('forecastWeatherListBox')
        .then(
      (forecastWeatherListBox) {
        forecastWeatherListBox.clear().then(
          (value) {
            debugPrint('Weather List: ${offlineForecastWeather.weatherList?.length}');
            forecastWeatherListBox.add(offlineForecastWeather).then((value) {
              forecastWeatherListBox.close();
            });
          },
        );
      },
    );
  }

  Future<HiveWeatherModel?> getOfflineCurrentWeather() async {
    final HiveWeatherModel offlineWeather = HiveWeatherModel();
    try {
      final box =
          await HiveDB.openBox<HiveWeatherModel>('offlineCurrentWeather');
      debugPrint('Offline Current Weather Data Length: ${box.values.length}');
      if (box.isNotEmpty) {
        offlineWeather.city = box.values.first.city;
        offlineWeather.lat = box.values.first.lat;
        offlineWeather.lon = box.values.first.lon;
        offlineWeather.icon = box.values.first.icon;
        offlineWeather.description = box.values.first.description;
        offlineWeather.sunrise = box.values.first.sunrise;
        offlineWeather.sunset = box.values.first.sunset;
        offlineWeather.speed = box.values.first.speed;
        offlineWeather.deg = box.values.first.deg;
        offlineWeather.gust = box.values.first.gust;
        offlineWeather.temp = box.values.first.temp;
        offlineWeather.feelsLike = box.values.first.feelsLike;
        offlineWeather.tempMin = box.values.first.tempMin;
        offlineWeather.tempMax = box.values.first.tempMax;
        offlineWeather.pressure = box.values.first.pressure;
        offlineWeather.humidity = box.values.first.humidity;
        offlineWeather.seaLevel = box.values.first.seaLevel;
        offlineWeather.grndLevel = box.values.first.grndLevel;
      }
      debugPrint('Temp: ${offlineWeather.temp}');
      await box.close();
      return offlineWeather;
    } catch (e) {
      debugPrint('Error: $e');
      throw Exception(e);
    }
  }

  Future<HiveForecastWeatherListModel?> getOfflineForecastWeather() async {
    HiveForecastWeatherListModel? offlineWeatherForecast;
    try {
      await HiveDB.openBox<HiveForecastWeatherListModel>(
              'forecastWeatherListBox')
          .then((box) async {
        debugPrint('Offline Forecast Weather Data Length: ${box.values.first.weatherList?.length}');
        if (box.isNotEmpty) {
          offlineWeatherForecast = box.values.first;
        }
        await box.close();
      });

      return offlineWeatherForecast;
    } catch (e) {
      debugPrint('Error: $e');
      throw Exception(e);
    }
  }
}

processWeatherForecastsList(List<dynamic> args) async {
  final SendPort resultPort = args[0];
  final WeatherForcastResponseModel data =
      WeatherForcastResponseModel.fromJson(args[1]);

  try {
    List<HiveForecastWeatherModel> offlineForecastWeatherList = [];

    for (var weather in data.list!) {
      offlineForecastWeatherList.add(HiveForecastWeatherModel(
          datetime: weather.dt,
          icon: weather.weather?.first.icon,
          temp: weather.main?.temp));
    }

    Isolate.exit(resultPort, offlineForecastWeatherList);
  } catch (e) {
    debugPrint('Error while saving progress: $e');
    Isolate.exit(resultPort, null);
  }
}
