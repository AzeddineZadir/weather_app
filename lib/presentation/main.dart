import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Weather App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: WeatherApp());
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
    return SafeArea(
      child: Scaffold(
        body: Container(
            margin: EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  children: const [
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.lightBlue,
                        border: OutlineInputBorder(),
                        labelText: "Montpellier",
                        prefixIcon: Icon(Icons.search),
                      ),
                    ))
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.white10,
                        child: Column(
                          children: [
                            Text(
                              "Montpellier",
                              style: TextStyle(fontSize: 35),
                            ),
                            Text("samedi 02/02/2020",
                                style: TextStyle(fontSize: 25)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.grey,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Icon(
                              FontAwesomeIcons.sun,
                              size: 160,
                            ),
                          ),
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("sdsdsds ", style: TextStyle(fontSize: 25)),
                              Text("73", style: TextStyle(fontSize: 25)),
                            ],
                          )),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text("1.6"),
                                    Icon(FontAwesomeIcons.wind)
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    Text("1.6"),
                                    Icon(FontAwesomeIcons.wind)
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    Text("1.6"),
                                    Icon(FontAwesomeIcons.wind)
                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(child: Text("7-days")),
                        ],
                      ),
                    )),
                Expanded(
                  child: Container(
                    color: Colors.amber,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    "sunday",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Icon(FontAwesomeIcons.cloud)),
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
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    "sunday",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Icon(FontAwesomeIcons.cloud)),
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
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    "sunday",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Icon(FontAwesomeIcons.cloud)),
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
                )
              ],
            )),
      ),
    );
  }
}
