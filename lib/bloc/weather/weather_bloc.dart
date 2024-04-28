import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

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
          final forcastWeather = await repository.serializeForcastWeather(
              event.lat, event.lon);
          if (currentWeather != null && forcastWeather != null) {
            emit(WeatherDataLoaded(currentWeather.weather!.first, currentWeather.wind!, currentWeather.main!, currentWeather.sys!, forcastWeather.list!));
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
}
