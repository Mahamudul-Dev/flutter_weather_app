part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}


final class FetchWeatherData extends WeatherEvent {
  final double? lat;
  final double? lon;
  final String? city;

  const FetchWeatherData(this.lat, this.lon, this.city);

}