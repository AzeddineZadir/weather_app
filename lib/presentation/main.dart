import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/buisness_logic/blocs/weather_bloc.dart';
import 'package:intl/intl.dart';

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
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: myController,
                      decoration: InputDecoration(
                        fillColor: Colors.lightBlue,
                        border: OutlineInputBorder(),
                        labelText: "Montpellier",
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  Expanded(
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
                          })),
                ],
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
                                  color: Colors.white10,
                                  child: Column(
                                    children: [
                                      Text(
                                        myController.text,
                                        style: TextStyle(fontSize: 45),
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
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 340,
                            color: Colors.green,
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
                                        style: TextStyle(fontSize: 25)),
                                    Text(
                                        "   " +
                                            state.weather.daily[0].weather[0]
                                                .main,
                                        style: TextStyle(fontSize: 25)),
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
                                          Icon(FontAwesomeIcons.wind)
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
                            color: Colors.amber,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.teal,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                            DateFormat('EEEE').format(DateTime
                                                .fromMillisecondsSinceEpoch(
                                                    state.weather.daily[1].dt *
                                                        1000)),
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: getIcon(
                                                    state.weather.daily[1]
                                                        .weather[0].main,
                                                    30),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Text("" +
                                                        state.weather.daily[1]
                                                            .temp.min
                                                            .toString()),
                                                    Text("" +
                                                        state.weather.daily[1]
                                                            .temp.max
                                                            .toString()),
                                                    Text("" +
                                                        state.weather.daily[1]
                                                            .humidity
                                                            .toString()),
                                                    Text("" +
                                                        state.weather.daily[1]
                                                            .windSpeed
                                                            .toString()),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.teal,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                            DateFormat('EEEE').format(DateTime
                                                .fromMillisecondsSinceEpoch(
                                                    state.weather.daily[2].dt *
                                                        1000)),
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: getIcon(
                                                    state.weather.daily[2]
                                                        .weather[0].main,
                                                    30),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Text("71"),
                                                    Text("71"),
                                                    Text("71"),
                                                    Text("71"),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.teal,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                            DateFormat('EEEE').format(DateTime
                                                .fromMillisecondsSinceEpoch(
                                                    state.weather.daily[3].dt *
                                                        1000)),
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: getIcon(
                                                    state.weather.daily[3]
                                                        .weather[0].main,
                                                    30),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Text("71"),
                                                    Text("71"),
                                                    Text("71"),
                                                    Text("71"),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Text("");
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
          color: Colors.black,
          size: sz,
        );
      case "Clouds":
        return Icon(
          FontAwesomeIcons.cloud,
          color: Colors.black,
          size: sz,
        );
      case "Rain":
        return Icon(
          FontAwesomeIcons.cloudRain,
          color: Colors.black,
          size: sz,
        );
      case "Snow":
        return Icon(
          FontAwesomeIcons.snowman,
          color: Colors.black,
          size: sz,
        );
    }
    return Icon(Icons.add);
  }
}
