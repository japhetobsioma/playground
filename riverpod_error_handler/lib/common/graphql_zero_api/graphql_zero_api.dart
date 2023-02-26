import 'package:graphql/client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_error_handler/common/graphql_client/graphql_client.dart';
import 'package:riverpod_error_handler/common/graphql_zero_api/model/post.dart';
import 'package:riverpod_error_handler/common/helper/grapqhl_helper.dart';

part 'graphql_zero_api.g.dart';

class GraphqlZeroApi {
  const GraphqlZeroApi({required GraphQLClient client}) : _client = client;

  final GraphQLClient _client;

  Future<List<Post>> getPosts() async {
    return graphqlHelper(
      client: _client,
      query: '''
        query getPosts {
          posts {
            data {
              id
              title
              body
            }
          }
        }
      ''',
      parseFunction: (data) {
        final posts = data['posts'] as Map<String, dynamic>;
        return Posts.fromJson(posts).data;
      },
    );
  }
}

@Riverpod(keepAlive: true)
GraphqlZeroApi graphqlZeroApi(GraphqlZeroApiRef ref) {
  final client = ref.watch(graphqlClientProvider);
  return GraphqlZeroApi(client: client);
}
