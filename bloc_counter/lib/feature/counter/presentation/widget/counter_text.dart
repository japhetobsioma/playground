import 'package:bloc_counter/feature/counter/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterText extends StatelessWidget {
  const CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CounterBloc>().state;

    return Center(
      child: Text(
        '$state',
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}
