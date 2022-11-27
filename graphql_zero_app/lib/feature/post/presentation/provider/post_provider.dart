import 'dart:async';

import 'package:graphql_zero_app/common/graphql_service/graphql_service.dart';
import 'package:graphql_zero_app/feature/post/dependency_injection/dependency_injection.dart';
import 'package:graphql_zero_app/feature/post/presentation/provider/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostNotifier extends AutoDisposeAsyncNotifier<PostState> {
  PostNotifier(this.id);

  final String id;

  @override
  FutureOr<PostState> build() async {
    final cancelToken = ref.read(cancelTokenProvider);
    ref.onDispose(
      () {
        cancelToken.cancel();
        ref.invalidate(cancelTokenProvider);
      },
    );

    final getPostById = ref.read(getPostByIdUseCaseDI);
    final result = await getPostById(id);

    return PostState(result);
  }
}

final postProvider = AutoDisposeAsyncNotifierProvider<PostNotifier, PostState>(
  () => PostNotifier(''),
);
