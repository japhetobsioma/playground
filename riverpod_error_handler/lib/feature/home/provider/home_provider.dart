import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_error_handler/feature/home/provider/home_state.dart';
import 'package:riverpod_error_handler/feature/home/repository/home_repository.dart';

part 'home_provider.g.dart';

@riverpod
class HomeNotifier extends _$HomeNotifier {
  HomeRepository get _repository => ref.read(homeRepositoryProvider);

  @override
  FutureOr<HomeState> build() async {
    await Future<void>.delayed(const Duration(seconds: 3));
    final posts = await _repository.getPosts();
    return HomeState(posts: posts);
  }
}
