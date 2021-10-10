import 'dart:convert';

import 'package:weather_app/data/data_provider/weather_api.dart';
import 'package:weather_app/data/models/city.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherRepository {
  final WeatherApi openWeatherAPI;
  late City myCity;
  WeatherRepository(this.openWeatherAPI);

  Future<WeatherModel> getCityWeather(String ville) async {
    http.Response geoReponse = await openWeatherAPI.getLatLog(ville);
    if (geoReponse.statusCode == 200) {
      if (geoReponse.body.length == 2) throw Exception('Failed to load geoLoc');
      print(geoReponse.body.length);
      myCity = City.fromJson(jsonDecode(geoReponse.body)[0]);
    } else {
      throw Exception('no location');
    }
    http.Response response =
        await openWeatherAPI.getWeather(myCity.lat, myCity.lon);
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('no weather');
    }
  }
}
