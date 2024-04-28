import 'dart:convert';
import 'dart:io';

import '../data/models/models.dart';
import '../network/network.dart';

class WeatherRepository {
  final WeatherNetwork network;
  WeatherRepository(this.network);

  Future<CurrentWeatherResponseModel?> serializeCurrentWeather(
      double lat, double lon) async {
    try {
      final response = await network.getCurrentWeather(lat, lon);
      if (response.statusCode == HttpStatus.ok) {
        final weather = CurrentWeatherResponseModel.fromJson(jsonDecode(jsonEncode(response.data)));
        return weather;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<WeatherForcastResponseModel?> serializeForcastWeather(
      double lat, double lon) async {
    try {
      final response = await network.getForcastWeather(lat, lon);
      if (response.statusCode == HttpStatus.ok) {
        final weather = WeatherForcastResponseModel.fromJson(jsonDecode(jsonEncode(response.data)));
        return weather;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
