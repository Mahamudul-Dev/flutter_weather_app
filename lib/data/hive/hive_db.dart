
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'dart:async';

import 'hive_models/hive_forecast_weather_model.dart';
import 'hive_models/hive_location_model.dart';
import 'hive_models/hive_weather_model.dart';

class HiveDB {
  static final HiveDB _instance = HiveDB._internal();

  factory HiveDB() {
    return _instance;
  }

  HiveDB._internal();

  static Future<void> init() async {
    final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    
    // Register Hive adapters
    Hive.registerAdapter(HiveWeatherModelAdapter());
    Hive.registerAdapter(HiveForecastWeatherListModelAdapter());
    Hive.registerAdapter(HiveForecastWeatherModelAdapter());
    Hive.registerAdapter(HiveLocationModelAdapter());
  }

  static Future<Box<T>> openBox<T>(String boxName) async {
    return await Hive.openBox<T>(boxName);
  }

  static Future<void> close() async {
    await Hive.close();
  }
}
