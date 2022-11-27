import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:graphql_zero_app/common/routing/routing.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routerDelegate = ref.watch(beamerDelegateProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: BeamerParser(),
      routerDelegate: routerDelegate,
    );
  }
}
