import 'package:flutter/material.dart';
import 'package:flutter_weather/feature/weather/page/weather_page.dart';
import 'package:flutter_weather/feature/weather/weather.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherPage(),
    );
  }
}
