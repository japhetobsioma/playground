import 'package:flutter/material.dart';
import 'package:graphql_zero_app/app.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}