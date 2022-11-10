import 'package:flutter/material.dart';
import 'package:flutter_timer/app.dart';
import 'package:flutter_timer/app_observer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      observers: [AppObserver()],
      child: App(),
    ),
  );
}
