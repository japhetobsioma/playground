import 'package:graphql_zero_app/feature/post/data/repository/repository.dart';
import 'package:graphql_zero_app/feature/post/dependency_injection/dependency_injection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final postRepositoryDI = Provider.autoDispose(
  (ref) {
    final remoteSource = ref.watch(postRemoteSourceDI);
    return PostRepositoryImpl(remoteSource);
  },
  dependencies: [postRemoteSourceDI],
);
