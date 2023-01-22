import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:space_exploration/feature/home/provider/provider.dart';

class TaskList extends ConsumerWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final length = ref.watch(homeProvider.select((value) => value.length));

    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ProviderScope(child: _TaskItem(index: index));
      },
      itemCount: length,
    );
  }
}

class _TaskItem extends ConsumerWidget {
  const _TaskItem({required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(homeProvider.select((value) => value[index]));
    final notifier = ref.read(homeProvider.notifier);

    return Row(
      children: [
        Checkbox(
          value: task.completed,
          onChanged: (_) => notifier.toggleTask(task),
        ),
        Text(task.label),
      ],
    );
  }
}
