import 'package:graphql/client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'graphql_client.g.dart';

@Riverpod(keepAlive: true)
GraphQLClient graphqlClient(GraphqlClientRef ref) {
  return GraphQLClient(
    link: HttpLink('https://graphqlzero.almansi.me/api'),
    cache: GraphQLCache(),
    defaultPolicies: DefaultPolicies(
      query: Policies(fetch: FetchPolicy.noCache),
      mutate: Policies(fetch: FetchPolicy.noCache),
    ),
  );
}
