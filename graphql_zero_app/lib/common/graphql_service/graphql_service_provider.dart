import 'package:dio/dio.dart';
import 'package:gql_dio_link/gql_dio_link.dart';
import 'package:graphql/client.dart';
import 'package:graphql_zero_app/common/graphql_service/graphql_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GraphQLServiceNotifier extends Notifier<GraphQLClient> {
  @override
  GraphQLClient build() {
    const endpoint = 'https://graphqlzero.almansi.me/api';
    final cancelToken = ref.watch(cancelTokenProvider);
    final dioClient = Dio()
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            options.cancelToken = cancelToken;
            return handler.next(options);
          },
        ),
      );
    final dioLink = DioLink(endpoint, client: dioClient);

    return GraphQLClient(
      link: dioLink,
      cache: GraphQLCache(),
      defaultPolicies: DefaultPolicies(
        query: Policies(fetch: FetchPolicy.noCache),
        mutate: Policies(fetch: FetchPolicy.noCache),
      ),
    );
  }
}

final graphqlServiceProvider =
    NotifierProvider<GraphQLServiceNotifier, GraphQLClient>(
  GraphQLServiceNotifier.new,
  dependencies: [cancelTokenProvider],
);
