import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';

Future<T> graphqlHelper<T>({
  required GraphQLClient client,
  required T Function(Map<String, dynamic> data) parseFunction,
  String? query,
  String? mutation,
  Map<String, dynamic>? variables,
  Map<String, dynamic>? Function()? mockData,
}) async {
  assert(
    query == null || mutation == null,
    'Cannot provide both a [query] and a [mutation]',
  );

  if (mockData != null && kDebugMode) {
    final mock = mockData();
    final mockResult = mock?['data'] as Map<String, dynamic>?;
    return parseFunction(mockResult ?? {});
  }

  if (query != null) {
    final options = QueryOptions<T>(
      document: gql(query),
      parserFn: (data) => parseFunction(data),
      variables: variables ?? const {},
    );

    final result = await client.query(options);
    if (result.hasException) throw result.exception!;

    final data = result.parsedData;
    if (data == null) throw Exception('Result data is null');

    return data;
  } else if (mutation != null) {
    final options = MutationOptions(
      document: gql(mutation),
      parserFn: (data) => parseFunction(data),
      variables: variables ?? const {},
    );

    final result = await client.mutate(options);
    if (result.hasException) throw result.exception!;

    final data = result.parsedData;
    if (data == null) throw Exception('Result data is null');

    return data;
  }

  throw Exception('[query] and [mutation] are null');
}
