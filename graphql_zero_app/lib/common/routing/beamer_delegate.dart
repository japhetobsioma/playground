import 'package:beamer/beamer.dart';
import 'package:graphql_zero_app/common/routing/routing.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final beamerDelegateProvider = Provider((ref) {
  final locationBuilder = ref.watch(locationBuilderProvider);

  return BeamerDelegate(
    initialPath: HomeLocation.route,
    locationBuilder: locationBuilder,
  );
});
