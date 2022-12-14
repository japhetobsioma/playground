import 'dart:async';

import 'package:graphql_zero_app/feature/home/dependency_injection/dependency_injection.dart';
import 'package:graphql_zero_app/feature/home/presentation/provider/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeNotifier extends AutoDisposeAsyncNotifier<HomeState> {
  @override
  FutureOr<HomeState> build() async {
    final getPosts = ref.read(getPostsUseCaseDI);
    final result = await getPosts();

    return HomeState(result);
  }
}

final homeProvider = AutoDisposeAsyncNotifierProvider<HomeNotifier, HomeState>(
  HomeNotifier.new,
);
