import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../data/utils/utils.dart';

class WeatherNetwork {
  final _dio = Dio(BaseOptions(baseUrl: Config.BASE));

  Future<Response> getCurrentWeatherByLatLon(double lat, double lon) async {
    try {
      final response = await _dio.get(Config.CURRENT_WEATHER,
      queryParameters: {'lat':lat.toString(), 'lon':lon.toString(), 'appId':Config.OPEN_WEATHER_APP_ID},
      );
      debugPrint(jsonEncode(response.data));
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }


  Future<Response> getCurrentWeatherByCity(String city) async {
    try {
      final response = await _dio.get(Config.CURRENT_WEATHER,
      queryParameters: {'q':city, 'appId':Config.OPEN_WEATHER_APP_ID},
      );
      debugPrint(jsonEncode(response.data));
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }


  Future<Response> getForcastWeatherByLatLon(double lat, double lon) async {
    try {
      final response = await _dio.get(Config.FORCAST_WEATHER,
       queryParameters: {'lat':lat.toString(), 'lon':lon.toString(), 'appId':Config.OPEN_WEATHER_APP_ID},
       );
      debugPrint(jsonEncode(response.data));
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> getForcastWeatherByCity(String city) async {
    try {
      final response = await _dio.get(Config.FORCAST_WEATHER,
       queryParameters: {'q':city, 'appId':Config.OPEN_WEATHER_APP_ID},
       );
      debugPrint(jsonEncode(response.data));
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}