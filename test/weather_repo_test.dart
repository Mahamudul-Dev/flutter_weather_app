import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather/data/models/models.dart';
import 'package:flutter_weather/data/utils/utils.dart';
import 'package:flutter_weather/network/network.dart';
import 'package:flutter_weather/repository/repository.dart';

void main() {
  late final WeatherRepository weatherRepo;
  late final WeatherNetwork weatherNetwork;

  setUp(() {
    weatherNetwork = WeatherNetwork(dio: Dio(BaseOptions(baseUrl: Config.BASE)));
    weatherRepo = WeatherRepository(weatherNetwork);
  });
  group('Weather Repository Tests - ', () {
    test('return a current weather status based on lat & lon if the function exicutes successfully', () async {
      expect(await weatherRepo.getCurrentWeather(23.8041, 90.4152, null, false), isA<CurrentWeatherResponseModel>());
    });

    test('return a current weather status based on city name if the function exicutes successfully', () async {
      expect(await weatherRepo.getCurrentWeather(null, null, 'Dhaka', false), isA<CurrentWeatherResponseModel>());
    });

    test('return a forecast weather status based on lat & lon if the function exicutes successfully', () async {
      expect(await weatherRepo.getForcastWeather(23.8041, 90.4152, null, false), isA<WeatherForcastResponseModel>());
    });

    test('return a forecast weather status based on city name if the function exicutes successfully', () async {
      expect(await weatherRepo.getForcastWeather(null, null, 'Dhaka', false), isA<WeatherForcastResponseModel>());
    });
  });
}
