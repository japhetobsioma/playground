abstract class CounterEvent {}

class CounterIncrementPressed extends CounterEvent {
  @override
  String toString() => 'Increment';
}

class CounterDecrementPressed extends CounterEvent {
  @override
  String toString() => 'Decrement';
}
