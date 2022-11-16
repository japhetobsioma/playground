import 'package:flutter/material.dart';
import 'package:flutter_timer/timer/provider/provider.dart';

@immutable
class TimerState {
  const TimerState({
    required this.duration,
    required this.status,
  });

  final int duration;
  final TimerStatus status;

  TimerState copyWith({
    int? duration,
    TimerStatus? status,
  }) {
    return TimerState(
      duration: duration ?? this.duration,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(covariant TimerState other) {
    if (identical(this, other)) return true;

    return other.duration == duration && other.status == status;
  }

  @override
  int get hashCode => duration.hashCode ^ status.hashCode;

  @override
  String toString() => 'TimerState(duration: $duration, status: $status)';
}
