import 'package:flutter/material.dart';
import 'package:space_exploration/feature/home/page/page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage(), title: 'Exploration');
  }
}
