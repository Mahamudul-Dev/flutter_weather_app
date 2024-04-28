// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class Config {
  static const String APP_NAME = 'Flutter Weather App';

  // APIS
  static const String OPEN_WEATHER_APP_ID = '2ff751a73ce57e00edc9e4c129a00b88'; // THIS KEY IS AVAILABLE IN OPEN WEATHER MAP
  static const String BASE = 'https://api.openweathermap.org';
  static const String CURRENT_WEATHER = '/data/2.5/weather';
  static const String FORCAST_WEATHER = '/data/2.5/forecast';


  static const double APP_DESIGN_HEIGHT = 838;
  static const double APP_DESIGN_WIDTH = 375;

  // colors
  static const Color BG_BLUE_LIGHT = Color(0xff97ABFF);
  static const Color BG_BLUE_DARK = Color(0xff123597);
  static const Color DEFAULT_TEXT_COLOR_LIGHT = Color.fromARGB(255, 245, 247, 255);
}