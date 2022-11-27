import 'package:flutter/material.dart';

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({super.key, required this.postList});

  final Widget postList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), centerTitle: false),
      body: postList,
    );
  }
}
