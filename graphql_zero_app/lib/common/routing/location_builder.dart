import 'package:beamer/beamer.dart';
import 'package:graphql_zero_app/common/routing/routing.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final locationBuilderProvider = Provider((ref) {
  return BeamerLocationBuilder(
    beamLocations: [
      HomeLocation(),
      PostLocation(),
    ],
  );
});
