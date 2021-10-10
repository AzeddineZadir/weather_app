import 'package:http/http.dart' as http;

class WeatherApi {
  Future<http.Response> getWeather(double lat, double long) async {
    print(
        "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$long&exclude=hourly,minutely&appid=26bd6e2dffae5933f9d77dfdbfff28cd&cnt=5&units=metric");
    http.Response response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$long&exclude=hourly,minutely&appid=26bd6e2dffae5933f9d77dfdbfff28cd&cnt=5&units=metric"));
    return response;
  }

  Future<http.Response> getLatLog(String city) async {
    http.Response response = await http.get(Uri.parse(
        "http://api.openweathermap.org/geo/1.0/direct?q=$city&limit=5&appid=26bd6e2dffae5933f9d77dfdbfff28cd&cnt=5&units=metric"));

    return response;
  }
}
