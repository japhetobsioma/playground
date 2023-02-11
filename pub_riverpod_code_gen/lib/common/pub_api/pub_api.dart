import 'package:dio/dio.dart';
import 'package:pub_riverpod_code_gen/common/pub_api/model/package.dart';
import 'package:pub_riverpod_code_gen/common/pub_api/model/pub_package_reponse.dart';
import 'package:pub_riverpod_code_gen/common/rest_client/rest_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pub_api.g.dart';

class PubApi {
  const PubApi({required Dio client}) : _client = client;

  final Dio _client;

  static const _scheme = 'https';
  static const _host = 'pub.dartlang.org';

  Future<List<Package>> getPackages({
    required int page,
    CancelToken? cancelToken,
  }) async {
    final uri = Uri(
      scheme: _scheme,
      host: _host,
      path: 'api/packages',
      queryParameters: {'page': '$page'},
    );

    final response = await _client.getUri<Map<String, dynamic>>(
      uri,
      cancelToken: cancelToken,
    );

    final packagesResponse = PubPackageReponse.fromJson(response.data!);

    return packagesResponse.packages;
  }
}

@Riverpod(keepAlive: true)
PubApi pubApi(PubApiRef ref) {
  final client = ref.watch(restClientProvider);
  return PubApi(client: client);
}
