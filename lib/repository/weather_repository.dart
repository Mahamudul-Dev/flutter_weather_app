import 'dart:convert';
import 'dart:io';

import '../data/models/models.dart';
import '../network/network.dart';

class WeatherRepository {
  final WeatherNetwork network;
  WeatherRepository(this.network);

  Future<CurrentWeatherResponseModel?> serializeCurrentWeather(
      double? lat, double? lon, String? city) async {
    try {
      if (lat != null && lon != null) {
        final response = await network.getCurrentWeatherByLatLon(lat, lon);
        if (response.statusCode == HttpStatus.ok) {
          final weather = CurrentWeatherResponseModel.fromJson(
              jsonDecode(jsonEncode(response.data)));
          return weather;
        } else {
          return null;
        }
      } else {
        final response = await network.getCurrentWeatherByCity(city!);
        if (response.statusCode == HttpStatus.ok) {
          final weather = CurrentWeatherResponseModel.fromJson(
              jsonDecode(jsonEncode(response.data)));
          return weather;
        } else {
          return null;
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<WeatherForcastResponseModel?> serializeForcastWeather(
      double? lat, double? lon, String? city) async {
    try {
      if (lat != null && lon != null) {
        final response = await network.getForcastWeatherByLatLon(lat, lon);
        if (response.statusCode == HttpStatus.ok) {
          final weather = WeatherForcastResponseModel.fromJson(
              jsonDecode(jsonEncode(response.data)));
          return weather;
        } else {
          return null;
        }
      } else {
        final response = await network.getForcastWeatherByCity(city!);
        if (response.statusCode == HttpStatus.ok) {
          final weather = WeatherForcastResponseModel.fromJson(
              jsonDecode(jsonEncode(response.data)));
          return weather;
        } else {
          return null;
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
