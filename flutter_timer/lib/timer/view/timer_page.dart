import 'package:flutter/material.dart';
import 'package:flutter_timer/timer/provider/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Timer')),
      body: Stack(
        children: [
          const _Background(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 100),
                child: Center(child: _TimerText()),
              ),
              _Actions(),
            ],
          )
        ],
      ),
    );
  }
}

class _TimerText extends ConsumerWidget {
  const _TimerText();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final duration = ref.watch(timerProvider.select((e) => e.duration));

    final minutesString =
        ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsString = (duration % 60).toString().padLeft(2, '0');

    return Text(
      '$minutesString:$secondsString',
      style: Theme.of(context).textTheme.headline1,
    );
  }
}

class _Actions extends ConsumerWidget {
  const _Actions();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(timerProvider.select((e) => e.status));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: () {
        switch (status) {
          case TimerStatus.initial:
            return [
              FloatingActionButton(
                child: const Icon(Icons.play_arrow),
                onPressed: () => ref.read(timerProvider.notifier).start(),
              ),
            ];
          case TimerStatus.runInProgress:
            return [
              FloatingActionButton(
                child: const Icon(Icons.pause),
                onPressed: () => ref.read(timerProvider.notifier).pause(),
              ),
              FloatingActionButton(
                child: const Icon(Icons.replay),
                onPressed: () => ref.read(timerProvider.notifier).reset(),
              ),
            ];
          case TimerStatus.runPause:
            return [
              FloatingActionButton(
                child: const Icon(Icons.play_arrow),
                onPressed: () => ref.read(timerProvider.notifier).resume(),
              ),
              FloatingActionButton(
                child: const Icon(Icons.replay),
                onPressed: () => ref.read(timerProvider.notifier).reset(),
              ),
            ];
          case TimerStatus.runComplete:
            return [
              FloatingActionButton(
                child: const Icon(Icons.replay),
                onPressed: () => ref.read(timerProvider.notifier).reset(),
              ),
            ];
        }
      }(),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.blue.shade500],
          ),
        ),
      ),
    );
  }
}
