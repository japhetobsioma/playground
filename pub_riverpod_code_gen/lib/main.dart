import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pub_riverpod_code_gen/app.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}
