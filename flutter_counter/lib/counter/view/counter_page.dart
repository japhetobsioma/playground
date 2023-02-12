import 'package:flutter/material.dart';
import 'package:flutter_counter/counter/provider/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CounterPage extends ConsumerWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: const Center(
        child: _CounterText(),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            key: const Key('counterPage_increment_floatingActionButton'),
            child: const Icon(Icons.add),
            onPressed: () => ref.read(counterProvider.notifier).increment(),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            key: const Key('counterPage_decrement_floatingActionButton'),
            child: const Icon(Icons.remove),
            onPressed: () => ref.read(counterProvider.notifier).decrement(),
          ),
        ],
      ),
    );
  }
}

class _CounterText extends ConsumerWidget {
  const _CounterText();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(counterProvider);

    return Text(
      '$state',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
