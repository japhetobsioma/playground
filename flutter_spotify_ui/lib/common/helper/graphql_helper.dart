import 'package:graphql/client.dart';

Future<T> graphqlHelper<T>({
  required GraphQLClient client,
  String? query,
  String? mutation,
  Map<String, dynamic>? variables,
  required T Function(Map<String, dynamic> data) resultParser,
}) async {
  assert(
    query == null || mutation == null,
    'Cannot provide both a [query] and a [mutation]',
  );

  if (query != null) {
    final options = QueryOptions(
      document: gql(query),
      variables: variables ?? const {},
    );

    final result = await client.query(options);
    if (result.hasException) throw Exception(result.exception);

    final data = result.data;
    if (data == null) throw Exception('Result data is null');

    return resultParser(data);
  } else if (mutation != null) {
    final options = MutationOptions(
      document: gql(mutation),
      variables: variables ?? const {},
    );

    final result = await client.mutate(options);
    if (result.hasException) throw Exception(result.exception);

    final data = result.data;
    if (data == null) throw Exception('Result data is null');

    return resultParser(data);
  }

  throw Exception('[query] and [mutation] are null');
}
