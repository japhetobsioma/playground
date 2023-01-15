import 'package:bloc_counter/app.dart';
import 'package:bloc_counter/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = AppBlocObserver();

  runApp(const App());
}
