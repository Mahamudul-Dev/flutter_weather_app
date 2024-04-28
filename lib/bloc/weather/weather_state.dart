part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherInitial extends WeatherState {}

final class WeatherDataLoaded extends WeatherState {
  final WindModel currentWind;
  final MainWeatherModel currentsMainWeather;
  final WeatherModel currentWeather;
  final SysModel sys;
  final List<WeatherElement> nextFiveDaysWeather;
  const WeatherDataLoaded(this.currentWeather, this.currentWind, this.currentsMainWeather, this.sys, this.nextFiveDaysWeather);
  @override
  List<Object> get props => [currentWeather, currentsMainWeather, currentWind, sys];
}

final class WeatherDataLoadFailed extends WeatherState {
  final String message;
  const WeatherDataLoadFailed(this.message);
  @override
  List<Object> get props => [message];
}
