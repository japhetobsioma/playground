import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const names = ['Foo', 'Bar', 'Baz'];

T getRandomElement<T>(Iterable<T> list) {
  return list.elementAt(Random().nextInt(list.length));
}

class NamesCubit extends Cubit<String?> {
  NamesCubit() : super(null);

  void pickRandomNames() => emit(getRandomElement(names));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final NamesCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = NamesCubit();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: StreamBuilder<String?>(
          stream: cubit.stream,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.done:
                return const Text('Pick random names');
              case ConnectionState.active:
                return Text(snapshot.data ?? '');
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: cubit.pickRandomNames,
        child: const Icon(Icons.shuffle),
      ),
    );
  }
}
