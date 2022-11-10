import 'package:flutter/material.dart';
import 'package:flutter_timer/timer/provider/provider.dart';

@immutable
class TimerState {
  const TimerState({
    required this.event,
    required this.status,
    required this.duration,
  });

  final TimerEvent event;
  final TimerStatus status;
  final int duration;

  TimerState copyWith({
    TimerEvent? event,
    TimerStatus? status,
    int? duration,
  }) {
    return TimerState(
      event: event ?? this.event,
      status: status ?? this.status,
      duration: duration ?? this.duration,
    );
  }

  @override
  bool operator ==(covariant TimerState other) {
    if (identical(this, other)) return true;

    return other.event == event &&
        other.status == status &&
        other.duration == duration;
  }

  @override
  int get hashCode => event.hashCode ^ status.hashCode ^ duration.hashCode;

  @override
  String toString() {
    return 'TimerState(event: $event, status: $status, duration: $duration)';
  }
}
