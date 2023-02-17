import 'package:pub_riverpod_code_gen/common/helper/cancel_token.dart';
import 'package:pub_riverpod_code_gen/common/pub_api/model/package.dart';
import 'package:pub_riverpod_code_gen/feature/home/provider/home_state.dart';
import 'package:pub_riverpod_code_gen/feature/home/repository/home_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_provider.g.dart';

@Riverpod()
class HomeNotifier extends _$HomeNotifier {
  HomeRepository get _repository => ref.read(homeRepositoryProvider);

  @override
  FutureOr<HomeState> build() async {
    final initialState = HomeState(search: '', packages: []);

    final cancelToken = ref.cancelToken();
    final packages = await _repository.fetchPackages(
      page: 1,
      cancelToken: cancelToken,
    );

    return initialState.copyWith(packages: packages);
  }

  Future<void> setSearch(String value) async {
    await update((state) => state.copyWith(search: value));
  }
}

@Riverpod()
Future<List<Package>> homePackages(HomePackagesRef ref) async {
  final value = await ref.watch(
    homeNotifierProvider.selectAsync((data) => data.packages),
  );

  return value;
}
