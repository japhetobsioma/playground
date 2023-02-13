import 'package:flutter/material.dart';
import 'package:flutter_spotify_ui/core/theme/dark_theme_data.dart';
import 'package:flutter_spotify_ui/feature/home/view/page/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Spotify UI',
      debugShowCheckedModeBanner: false,
      darkTheme: darkThemeData,
      home: const HomePage(),
    );
  }
}
