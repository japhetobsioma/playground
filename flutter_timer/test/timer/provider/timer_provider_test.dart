import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_timer/timer/provider/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  group('TimerProvider', () {
    test(
        'initial state is '
        'TimerState(duration: 60, status: TimerStatus.initial)', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final state = container.read(timerProvider);
      expect(
        state,
        const TimerState(
          status: TimerStatus.initial,
          duration: 60,
        ),
      );
    });

    group('start()', () {
      test('should start the timer', () async {
        final container = ProviderContainer(
          overrides: [
            timerProvider.overrideWith(
              () => TimerNotifier(
                overrideState: const TimerState(
                  status: TimerStatus.initial,
                  duration: 3,
                ),
              ),
            )
          ],
        );
        addTearDown(container.dispose);
        final states = <TimerState>[];

        container.listen(
          timerProvider,
          (_, next) => states.add(next),
          fireImmediately: true,
        );

        container.read(timerProvider.notifier).start();

        await Future<void>.delayed(const Duration(seconds: 3));

        await expectLater(states, [
          const TimerState(
            status: TimerStatus.initial,
            duration: 3,
          ),
          const TimerState(
            status: TimerStatus.runInProgress,
            duration: 3,
          ),
          const TimerState(
            status: TimerStatus.runInProgress,
            duration: 2,
          ),
          const TimerState(
            status: TimerStatus.runInProgress,
            duration: 1,
          ),
          const TimerState(
            status: TimerStatus.runComplete,
            duration: 0,
          ),
        ]);
      });
    });
  });
}
