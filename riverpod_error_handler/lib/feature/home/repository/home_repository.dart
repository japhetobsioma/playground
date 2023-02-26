import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_error_handler/common/graphql_zero_api/graphql_zero_api.dart';
import 'package:riverpod_error_handler/common/graphql_zero_api/model/post.dart';

part 'home_repository.g.dart';

class HomeRepository {
  const HomeRepository({required GraphqlZeroApi api}) : _api = api;

  final GraphqlZeroApi _api;

  Future<List<Post>> getPosts() async => _api.getPosts();
}

@Riverpod(keepAlive: true)
HomeRepository homeRepository(HomeRepositoryRef ref) {
  final api = ref.watch(graphqlZeroApiProvider);
  return HomeRepository(api: api);
}
