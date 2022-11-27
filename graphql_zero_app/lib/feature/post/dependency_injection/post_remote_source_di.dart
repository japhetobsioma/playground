import 'package:graphql_zero_app/common/graphql_service/graphql_service.dart';
import 'package:graphql_zero_app/feature/post/data/data_source/remote_source/remote_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final postRemoteSourceDI = Provider.autoDispose(
  (ref) {
    final client = ref.watch(graphqlServiceProvider);
    return PostRemoteSourceImpl(client);
  },
  dependencies: [graphqlServiceProvider],
);
