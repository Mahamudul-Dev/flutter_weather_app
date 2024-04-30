import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../data/utils/utils.dart';

class WeatherNetwork {
  final Dio dio;
  WeatherNetwork({
    required this.dio,
  });

  Future<Response> requestCurrentWeatherByLatLon(double lat, double lon) async {
    try {
      final response = await dio.request(Config.CURRENT_WEATHER,
      queryParameters: {'lat':lat.toString(), 'lon':lon.toString(), 'appId':Config.OPEN_WEATHER_APP_ID},
      );
      debugPrint(jsonEncode(response.data));
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }


  Future<Response> requestCurrentWeatherByCity(String city) async {
    try {
      final response = await dio.request(Config.CURRENT_WEATHER,
      queryParameters: {'q':city, 'appId':Config.OPEN_WEATHER_APP_ID},
      );
      debugPrint(jsonEncode(response.data));
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }


  Future<Response> requestForcastWeatherByLatLon(double lat, double lon) async {
    try {
      final response = await dio.request(Config.FORCAST_WEATHER,
       queryParameters: {'lat':lat.toString(), 'lon':lon.toString(), 'appId':Config.OPEN_WEATHER_APP_ID},
       );
      debugPrint(jsonEncode(response.data));
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> requestForcastWeatherByCity(String city) async {
    try {
      final response = await dio.request(Config.FORCAST_WEATHER,
       queryParameters: {'q':city, 'appId':Config.OPEN_WEATHER_APP_ID},
       );
      debugPrint(jsonEncode(response.data));
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
