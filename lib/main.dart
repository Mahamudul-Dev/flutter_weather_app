import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';
import 'data/hive/hive_db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveDB.init();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: []);
  runApp(const FlutterWeatherApp());
}