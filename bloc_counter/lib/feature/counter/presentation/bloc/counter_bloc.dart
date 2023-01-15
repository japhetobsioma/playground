import 'package:bloc_counter/feature/counter/presentation/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrementPressed>(increment);
    on<CounterDecrementPressed>(decrement);
  }

  void increment(CounterIncrementPressed event, Emitter<int> emit) {
    emit(state + 1);
  }

  void decrement(CounterDecrementPressed event, Emitter<int> emit) {
    emit(state - 1);
  }
}
