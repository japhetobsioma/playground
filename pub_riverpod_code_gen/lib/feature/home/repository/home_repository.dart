import 'package:dio/dio.dart';
import 'package:pub_riverpod_code_gen/common/pub_api/model/package.dart';
import 'package:pub_riverpod_code_gen/common/pub_api/pub_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_repository.g.dart';

class HomeRepository {
  HomeRepository({required PubApi api}) : _api = api;

  final PubApi _api;

  Future<List<Package>> fetchPackages({
    required int page,
    CancelToken? cancelToken,
  }) async {
    return _api.getPackages(page: page, cancelToken: cancelToken);
  }
}

@Riverpod(keepAlive: true)
HomeRepository homeRepository(HomeRepositoryRef ref) {
  final api = ref.watch(pubApiProvider);
  return HomeRepository(api: api);
}
