import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_async_notifier/counter_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('Building MyApp');

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('Building MyHomePage');

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('You have pushed the button this many times:'),
            CounterText(),
          ],
        ),
      ),
      floatingActionButton: const IncrementButton(),
    );
  }
}

class IncrementButton extends ConsumerWidget {
  const IncrementButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('Building IncrementButton');
    final state = ref.watch(counterProvider);

    return state.maybeWhen(
      data: (_) => FloatingActionButton(
        onPressed: () async => ref.invalidate(counterProvider),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      orElse: () => const SizedBox.shrink(),
    );
  }
}

class CounterText extends ConsumerWidget {
  const CounterText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('Building CounterText');
    final state = ref.watch(counterProvider);

    return Text(
      state.when(
        skipLoadingOnRefresh: false,
        data: (data) => '$data',
        error: (_, __) => 'Error',
        loading: () => 'Loading',
      ),
      style: Theme.of(context).textTheme.headline4,
    );
  }
}
