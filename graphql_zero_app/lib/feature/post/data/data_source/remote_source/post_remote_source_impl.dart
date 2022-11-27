import 'package:graphql/client.dart';
import 'package:graphql_zero_app/common/model/post_model.dart';
import 'package:graphql_zero_app/feature/post/data/data_source/remote_source/remote_source.dart';

class PostRemoteSourceImpl implements PostRemoteSource {
  const PostRemoteSourceImpl(GraphQLClient client) : _client = client;

  final GraphQLClient _client;

  @override
  Future<PostModel> getPostById(String id) async {
    const query = r'''
      query getPostById($id: ID!) {
        post(id: $id) {
          id
          title
          body
          comments {
            data {
              id
              name
              body
            }
          }
        }
      }
    ''';

    final options = QueryOptions(document: gql(query), variables: {'id': id});

    final result = await _client.query(options);

    if (result.hasException) throw Exception();

    final post = result.data?['post'] as Map<String, dynamic>;

    return PostModel.fromJson(post);
  }
}
