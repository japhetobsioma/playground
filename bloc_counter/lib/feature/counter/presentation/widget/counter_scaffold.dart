import 'package:flutter/material.dart';

class CounterScaffold extends StatelessWidget {
  const CounterScaffold({
    super.key,
    required this.counterText,
    required this.incrementButton,
    required this.decrementButton,
  });

  final Widget counterText;
  final Widget incrementButton;
  final Widget decrementButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: counterText,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [incrementButton, decrementButton],
      ),
    );
  }
}
