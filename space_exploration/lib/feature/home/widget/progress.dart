import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:space_exploration/feature/home/provider/provider.dart';

class Progress extends StatelessWidget {
  const Progress({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text('You are this far away from exploring the whole universe:'),
        _ProgressIndicator(),
      ],
    );
  }
}

class _ProgressIndicator extends ConsumerWidget {
  const _ProgressIndicator();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksProgress = ref.watch(
      homeProvider.select(
        (value) => value.where((e) => e.completed).length / value.length,
      ),
    );

    return LinearProgressIndicator(value: tasksProgress);
  }
}
