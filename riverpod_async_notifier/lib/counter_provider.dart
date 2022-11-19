import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class CounterNotifier extends AutoDisposeAsyncNotifier<int> {
  @override
  FutureOr<int> build() async {
    final repository = ref.read(counterRepositoryProvider);
    return await repository.getCounter();
  }

  Future<void> increment() async {
    final repository = ref.read(counterRepositoryProvider);
    final newState = state.requireValue + 1;

    final result = await AsyncValue.guard(
      () async => repository.saveCounter(newState),
    );

    if (result is AsyncError) {
      state = AsyncError(result.error!, result.stackTrace!);
    } else {
      await update((data) => result.requireValue);
    }
  }
}

final counterProvider = AutoDisposeAsyncNotifierProvider<CounterNotifier, int>(
  CounterNotifier.new,
  name: 'CounterProvider',
);

class CounterRepository {
  const CounterRepository();

  Future<int> getCounter() async {
    return Future<int>.delayed(const Duration(seconds: 2), () => 10);
  }

  Future<int> saveCounter(int counter) async {
    // await Future<void>.delayed(const Duration(seconds: 2));
    throw Exception('Test');
  }
}

final counterRepositoryProvider = Provider((_) => const CounterRepository());
