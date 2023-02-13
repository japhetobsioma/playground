import 'package:flutter_spotify_ui/feature/home/provider/home_state.dart';
import 'package:flutter_spotify_ui/feature/home/repository/home_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_provider.g.dart';

@Riverpod(dependencies: [homeRepository])
class HomeNotifier extends _$HomeNotifier {
  HomeRepository get _repository => ref.read(homeRepositoryProvider);

  @override
  FutureOr<HomeState> build({required int page}) async {
    final yourLibrary = await _repository.getAllLibraries();
    final playlists = await _repository.getAllPlaylists();
    final currentPlaylist = await _repository.getPlaylist(id: '6');

    return HomeState(
      yourLibrary: yourLibrary,
      playlists: playlists,
      currentPlaylist: currentPlaylist,
    );
  }
}
