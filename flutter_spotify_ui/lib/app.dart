import 'package:flutter/material.dart';
import 'package:flutter_spotify_ui/common/theme/dark_theme_data.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Spotify UI',
      debugShowCheckedModeBanner: false,
      darkTheme: darkThemeData,
    );
  }
}
