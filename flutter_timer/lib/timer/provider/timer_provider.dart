import 'dart:async';

import 'package:flutter_timer/timer/provider/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TimerNotifier extends AutoDisposeNotifier<TimerState> {
  TimerNotifier({
    TimerState? overrideState,
  }) : _overrideState = overrideState;

  final TimerState? _overrideState;
  StreamSubscription<int>? _tickerSubscription;

  final TimerState _initialState = const TimerState(
    duration: 60,
    status: TimerStatus.initial,
  );

  late final int _duration = _overrideState?.duration ?? _initialState.duration;

  @override
  TimerState build() {
    ref.onDispose(() => _tickerSubscription?.cancel());

    return _overrideState ?? _initialState;
  }

  Stream<int> _tick() {
    final streamPeriodic = Stream.periodic(
      const Duration(seconds: 1),
      (x) => _duration - x - 1,
    );

    return streamPeriodic.take(_duration);
  }

  void start() {
    state = state.copyWith(
      status: TimerStatus.runInProgress,
    );

    _tickerSubscription?.cancel();
    _tickerSubscription = _tick().listen((duration) {
      if (duration > 0) {
        state = state.copyWith(
          status: TimerStatus.runInProgress,
          duration: duration,
        );
      } else {
        state = state.copyWith(
          status: TimerStatus.runComplete,
          duration: duration,
        );
      }
    });
  }

  void pause() {
    if (state.status == TimerStatus.runInProgress) {
      _tickerSubscription?.pause();
      state = state.copyWith(status: TimerStatus.runPause);
    }
  }

  void resume() {
    if (state.status == TimerStatus.runPause) {
      _tickerSubscription?.resume();
      state = state.copyWith(status: TimerStatus.runInProgress);
    }
  }

  void reset() {
    _tickerSubscription?.cancel();
    state = state.copyWith(status: TimerStatus.initial, duration: _duration);
  }
}

final timerProvider = AutoDisposeNotifierProvider<TimerNotifier, TimerState>(
  TimerNotifier.new,
  name: 'TimerProvider',
);
