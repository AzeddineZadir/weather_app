import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/data/data_provider/weather_api.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/data/repositories/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepository weatherRep = WeatherRepository(WeatherApi());
  WeatherBloc() : super(WeatherNotSearched()) {}

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FeatchWeatherEvent) {
      /*  yield WeatherLoading();*/

      try {
        print("in the bloc");

        WeatherModel weatherModel =
            await weatherRep.getCityWeather(event._city);

        print("after  the bloc");
        print(weatherModel.current.weather[0].main);
        yield WeatherLoadedCorrectely(weatherModel);
      } catch (e) {
        yield WeatherLodingEr();
        print(e);
      }
    } else {
      yield WeatherNotSearched();
    }
  }
}
