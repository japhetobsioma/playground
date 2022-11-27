import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:graphql_zero_app/feature/home/presentation/page/page.dart';

class HomeLocation extends BeamLocation<BeamState> {
  static const route = '/home';

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BeamPage(
        key: ValueKey('home_location'),
        title: 'Home',
        name: 'Home',
        child: HomePage(),
      ),
    ];
  }

  @override
  List<Pattern> get pathPatterns => [route];
}
