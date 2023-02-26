import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_error_handler/app.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}
