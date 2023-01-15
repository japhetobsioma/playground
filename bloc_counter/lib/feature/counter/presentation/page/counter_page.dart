import 'package:bloc_counter/feature/counter/presentation/bloc/counter_bloc.dart';
import 'package:bloc_counter/feature/counter/presentation/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: BlocListener<CounterBloc, int>(
        listener: (context, state) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$state')),
          );
        },
        child: const CounterScaffold(
          counterText: CounterText(),
          incrementButton: CounterIncrementButton(),
          decrementButton: CounterDecrementButton(),
        ),
      ),
    );
  }
}
