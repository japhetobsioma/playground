import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:space_exploration/feature/home/provider/provider.dart';

class HomeProvider extends Notifier<List<Task>> {
  @override
  List<Task> build() {
    return const [
      Task(id: 1, label: 'Load rocket with supplies'),
      Task(id: 2, label: 'Launch rocket'),
      Task(id: 3, label: 'Circle the home planet'),
      Task(id: 4, label: 'Head out to the first moon'),
      Task(id: 5, label: 'Launch moon lander #1'),
    ];
  }

  void addTask(Task task) => state = [...state, task];

  void toggleTask(Task task) {
    state = [
      for (final item in state) ...[
        if (item.id == task.id)
          item.copyWith(completed: !item.completed)
        else
          item,
      ],
    ];
  }
}

final homeProvider = NotifierProvider<HomeProvider, List<Task>>(
  HomeProvider.new,
);
