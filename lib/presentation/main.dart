import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/buisness_logic/blocs/weather_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/data/models/weather_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(),
      child: MaterialApp(
          title: 'Weather App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: WeatherApp()),
    );
  }
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    var myController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(8),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Container(
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: 56,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: TextField(
                            controller: myController,
                            decoration: InputDecoration(
                              fillColor: Colors.lightBlue,
                              border: OutlineInputBorder(),
                              labelText: "city",
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: SizedBox(
                      height: 40,
                      child: MaterialButton(
                          child: Text(
                            "Search",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.lightBlueAccent,
                          onPressed: () {
                            weatherBloc
                                .add(FeatchWeatherEvent(myController.text));
                            /* print(myController.text);*/
                          }),
                    )),
                  ],
                ),
              ),
              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherLoadedCorrectely) {
                    return Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white,
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color: Colors.lightBlue[200]),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        myController.text,
                                        style: TextStyle(
                                          fontSize: 45,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                          DateFormat('EEEE').format(DateTime
                                                  .fromMillisecondsSinceEpoch(
                                                      state.weather.current.dt *
                                                          1000)) +
                                              " " +
                                              DateFormat.yMMMd().format(DateTime
                                                  .fromMillisecondsSinceEpoch(
                                                      state.weather.current.dt *
                                                          1000)),
                                          style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.black,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 340,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.lightBlue[200]),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: getIcon(
                                      state.weather.current.weather[0].main,
                                      160),
                                ),
                                Expanded(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        state.weather.daily[0].temp.day
                                                .toString() +
                                            " c°",
                                        style: TextStyle(
                                            fontSize: 35,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        "   " +
                                            state.weather.daily[0].weather[0]
                                                .main,
                                        style: TextStyle(
                                            fontSize: 35,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                )),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Text(state.weather.current.windSpeed
                                              .toString()),
                                          Icon(FontAwesomeIcons.wind,
                                              color: Colors.black)
                                        ],
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          Text(state.weather.daily[0].humidity
                                              .toString()),
                                          Icon(FontAwesomeIcons
                                              .solidGrinBeamSweat)
                                        ],
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          Text(state.weather.daily[0].temp.max
                                              .toString()),
                                          Icon(FontAwesomeIcons.temperatureLow)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(child: Text("7-DAY WEATHER FORECAST")),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            height: 160,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    buildWeatherCard(state.weather, index),
                                separatorBuilder: (context, _) => SizedBox(
                                      width: 12,
                                    ),
                                itemCount: 5),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: Container(
                          color: Colors.white,
                          height: 400,
                          child: Text(
                            " Search a city",
                            style: TextStyle(fontSize: 50),
                          )),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Icon getIcon(String weatherDescription, double sz) {
    switch (weatherDescription) {
      case "Clear":
        return Icon(
          FontAwesomeIcons.sun,
          color: Colors.white,
          size: sz,
        );
      case "Clouds":
        return Icon(
          FontAwesomeIcons.cloud,
          color: Colors.white,
          size: sz,
        );
      case "Rain":
        return Icon(
          FontAwesomeIcons.cloudRain,
          color: Colors.white,
          size: sz,
        );
      case "Snow":
        return Icon(
          FontAwesomeIcons.snowman,
          color: Colors.white,
          size: sz,
        );
    }
    return Icon(Icons.add);
  }

  buildWeatherCard(WeatherModel weatherModel, int index) {
    return Container(
      width: 130,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.lightBlue[200]),
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
            ),
            Text(
              DateFormat('EEEE').format(DateTime.fromMillisecondsSinceEpoch(
                  weatherModel.daily[index].dt * 1000)),
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Expanded(
                  child: getIcon(weatherModel.daily[index].weather[0].main, 30),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "" + weatherModel.daily[index].temp.min.toString(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "" + weatherModel.daily[index].temp.max.toString(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "" + weatherModel.daily[index].humidity.toString(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "" + weatherModel.daily[index].windSpeed.toString(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
