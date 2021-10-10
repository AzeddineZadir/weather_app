part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class FeatchWeatherEvent extends WeatherEvent {
  final _city;

  FeatchWeatherEvent(this._city);
}

class ResetWeatherEvent extends WeatherEvent {}

class ResetWeather extends WeatherEvent {}
