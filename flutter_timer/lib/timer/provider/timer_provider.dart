import 'dart:async';

import 'package:flutter_timer/timer/provider/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TimerNotifier extends AutoDisposeNotifier<TimerState> {
  TimerNotifier({required Ticker ticker}) : _ticker = ticker;

  final Ticker _ticker;
  StreamSubscription<int>? _tickerSubscription;

  @override
  TimerState build() {
    ref.onDispose(() => _tickerSubscription?.cancel());

    return const TimerState(
      event: TimerEvent.initial,
      status: TimerStatus.initial,
      duration: 5,
    );
  }

  void start() {
    state = state.copyWith(
      event: TimerEvent.started,
      status: TimerStatus.runInProgress,
    );

    _tickerSubscription?.cancel();
    _tickerSubscription =
        _ticker.tick(ticks: state.duration).listen((duration) {
      if (duration > 0) {
        state = state.copyWith(
          event: TimerEvent.ticked,
          status: TimerStatus.runInProgress,
          duration: duration,
        );
      } else {
        state = state.copyWith(
          event: TimerEvent.ticked,
          status: TimerStatus.runComplete,
          duration: duration,
        );

        _tickerSubscription?.cancel();
      }
    });
  }

  void pause() {
    state = state.copyWith(event: TimerEvent.paused);

    if (state.status == TimerStatus.runInProgress) {
      _tickerSubscription?.pause();
      state = state.copyWith(status: TimerStatus.runPause);
    }
  }

  void resume() {
    state = state.copyWith(event: TimerEvent.resumed);

    if (state.status == TimerStatus.runPause) {
      _tickerSubscription?.resume();
      state = state.copyWith(status: TimerStatus.runInProgress);
    }
  }

  void reset() {
    state = state.copyWith(event: TimerEvent.reset);

    _tickerSubscription?.cancel();
    state = state.copyWith(status: TimerStatus.initial, duration: 5);
  }
}

final timerProvider = AutoDisposeNotifierProvider<TimerNotifier, TimerState>(
  () => TimerNotifier(ticker: Ticker()),
  name: 'TimerProvider',
);
