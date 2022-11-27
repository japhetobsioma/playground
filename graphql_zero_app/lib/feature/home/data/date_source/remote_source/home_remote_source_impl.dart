import 'package:graphql/client.dart';
import 'package:graphql_zero_app/common/model/model.dart';
import 'package:graphql_zero_app/feature/home/data/date_source/remote_source/remote_source.dart';

class HomeRemoteSourceImpl implements HomeRemoteSource {
  const HomeRemoteSourceImpl(GraphQLClient client) : _client = client;

  final GraphQLClient _client;

  @override
  Future<List<PostModel>> getPosts() async {
    const query = '''
      query getPosts {
        posts {
          data {
            id
            title
            body
            user {
              id
              name
              username
            }
          }
        }
      }
    ''';

    final options = QueryOptions(document: gql(query));

    final result = await _client.query(options);

    if (result.hasException) throw Exception();

    final posts = result.data?['posts'] as Map<String, dynamic>;
    final data = posts['data'] as List<dynamic>;
    final castedData = data.cast<Map<String, dynamic>>();

    return List.from(castedData.map(PostModel.fromJson));
  }
}
