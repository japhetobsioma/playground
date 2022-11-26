import 'package:graphql_zero_app/common/graphql_service/graphql_service.dart';
import 'package:graphql_zero_app/feature/home/data/date_source/remote_source/remote_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeRemoteSourceDI = Provider((ref) {
  final client = ref.watch(graphqlServiceProvider);
  return HomeRemoteSourceImpl(client);
});
