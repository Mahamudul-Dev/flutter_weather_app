import 'package:bloc/bloc.dart';
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
        try {
          final currentWeather =
              await repository.serializeCurrentWeather(event.lat, event.lon);
          final forcastWeather =
              await repository.serializeForcastWeather(event.lat, event.lon);
          if (currentWeather != null && forcastWeather != null) {
            emit(WeatherDataLoaded(
                currentWeather.weather!.first,
                currentWeather.wind!,
                currentWeather.main!,
                currentWeather.sys!,
                forcastWeather.list!));
          } else {
            emit(const WeatherDataLoadFailed(
                'Failed to get weather information.'));
          }
        } catch (e) {
          debugPrint(e.toString());
          emit(const WeatherDataLoadFailed(
              'Failed to get weather information.'));
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
    } else if (dateTime.year == now.year) {
      // If the timestamp represents an hour in the current day
      String hour =
          DateFormat('h').format(dateTime); // Get the hour in 12-hour format
      // String minute = DateFormat('mm').format(dateTime); // Get the minute
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
      return '$weekDay $hour $period';
    }
  }
}
