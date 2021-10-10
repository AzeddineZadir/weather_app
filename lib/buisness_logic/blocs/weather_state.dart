part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherNotSearched extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoadedCorrectely extends WeatherState {
  WeatherModel weather;

  WeatherLoadedCorrectely(this.weather);
}

class WeatherLodingEr extends WeatherState {}
