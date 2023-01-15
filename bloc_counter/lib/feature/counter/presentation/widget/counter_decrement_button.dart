import 'package:bloc_counter/feature/counter/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterDecrementButton extends StatelessWidget {
  const CounterDecrementButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: FloatingActionButton(
        child: const Icon(Icons.remove),
        onPressed: () {
          context.read<CounterBloc>().add(CounterDecrementPressed());
        },
      ),
    );
  }
}
