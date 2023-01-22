import 'package:flutter/material.dart';
import 'package:space_exploration/feature/home/widget/widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Space Exploration Planner'),
      ),
      body: Column(
        children: const [
          Progress(),
          TaskList(),
        ],
      ),
    );
  }
}
