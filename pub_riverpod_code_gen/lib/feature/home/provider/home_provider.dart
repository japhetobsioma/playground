import 'package:pub_riverpod_code_gen/common/helper/cancel_token.dart';
import 'package:pub_riverpod_code_gen/feature/home/provider/home_state.dart';
import 'package:pub_riverpod_code_gen/feature/home/repository/home_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_provider.g.dart';

@riverpod
class HomeNotifier extends _$HomeNotifier {
  HomeRepository get _repository => ref.read(homeRepositoryProvider);

  @override
  FutureOr<HomeState> build({required int page}) async {
    final initialState = HomeState(search: '', packages: []);

    final cancelToken = ref.cancelToken();
    final packages = await _repository.fetchPackages(
      page: page,
      cancelToken: cancelToken,
    );

    return initialState.copyWith(packages: packages);
  }
}
