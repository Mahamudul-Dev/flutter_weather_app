import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import '../../data/models/models.dart';
import '../../repository/repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository repository;
  WeatherBloc(this.repository) : super(WeatherInitial()) {
    on<FetchWeatherData>(
      (event, emit) async {
        final connectivityResult = await (Connectivity().checkConnectivity());

        if (connectivityResult.contains(ConnectivityResult.none)) {
          // User is offline, try to fetch weather from offline
          try {
            final currentWeather = await repository.getOfflineCurrentWeather();
            final forcastWeather = await repository.getOfflineForecastWeather();

            if (currentWeather != null) {
              final offlineWeatherData = WeatherModel(
                  description: currentWeather.description,
                  icon: currentWeather.icon);
              final offlineWindData = WindModel(
                  speed: currentWeather.speed,
                  deg: currentWeather.deg,
                  gust: currentWeather.gust);
              final offlineMainWeatherData = MainWeatherModel(
                  temp: currentWeather.temp,
                  feelsLike: currentWeather.feelsLike,
                  tempMin: currentWeather.tempMin,
                  tempMax: currentWeather.tempMax,
                  pressure: currentWeather.pressure,
                  humidity: currentWeather.humidity,
                  seaLevel: currentWeather.seaLevel,
                  grndLevel: currentWeather.grndLevel);
              final offlineSys = SysModel(
                  sunrise: currentWeather.sunrise,
                  sunset: currentWeather.sunset);

              final List<WeatherElement> offlineWeatherForecast = forcastWeather
                      ?.weatherList
                      ?.map((e) => WeatherElement(
                          dt: e.datetime,
                          main: Main(temp: e.temp),
                          weather: [Weather(icon: e.icon)]))
                      .toList() ??
                  [];

              emit(WeatherDataLoaded(offlineWeatherData, offlineWindData,
                  offlineMainWeatherData, offlineSys, offlineWeatherForecast));
            } else {
              emit(const WeatherDataLoadFailed(
                  'Failed to get weather information.\nCheck your connectivity!'));
            }
          } catch (e) {
            emit(const WeatherDataLoadFailed(
                'Failed to get weather information.'));
          }
        } else {
          try {
            final currentWeather = await repository.getCurrentWeather(
                event.lat, event.lon, event.city, true);
            final forcastWeather = await repository.getForcastWeather(
                event.lat, event.lon, event.city, true);
            if (currentWeather != null && forcastWeather != null) {
              emit(WeatherDataLoaded(
                  currentWeather.weather!.first,
                  currentWeather.wind!,
                  currentWeather.main!,
                  currentWeather.sys!,
                  forcastWeather.list!));
            } else {
              emit(const WeatherDataLoadFailed(
                  'No weather data available for selected area.'));
            }
          } catch (e) {
            debugPrint(e.toString());
            emit(const WeatherDataLoadFailed(
                'Failed to get weather information.'));
          }
        }
      },
    );
  }

  String capitalizeString(String input) {
    List<String> words = input.split(' ');

    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] =
            words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
      }
    }

    return words.join(' ');
  }

  String formatTimestampToHumanReadable(int timestamp) {
    DateTime now = DateTime.now();
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    if (dateTime == now) {
      // If the timestamp represents the current time
      return 'Now';
    } else if (dateTime.day == now.day) {
      // If the timestamp represents an hour in the current day
      String hour =
          DateFormat('h').format(dateTime); // Get the hour in 12-hour format
      String period =
          DateFormat('a').format(dateTime); // Get the period (AM/PM)
      return '$hour $period';
    } else {
      // If the timestamp represents any other day
      String weekDay = DateFormat('E')
          .format(dateTime); // Get the day of the week (e.g., Mon, Tue)
      String hour =
          DateFormat('h').format(dateTime); // Get the hour in 12-hour format
      // String minute = DateFormat('mm').format(dateTime); // Get the minute
      String period =
          DateFormat('a').format(dateTime); // Get the period (AM/PM)
      return '$weekDay\n $hour $period';
    }
  }
}
