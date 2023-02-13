import 'package:flutter_spotify_ui/core/spotify_api/model/library.dart';
import 'package:flutter_spotify_ui/core/spotify_api/model/playlist.dart';
import 'package:flutter_spotify_ui/core/spotify_api/spotify_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_repository.g.dart';

class HomeRepository {
  const HomeRepository({required SpotifyApi api}) : _api = api;

  final SpotifyApi _api;

  Future<List<Library>> getAllLibraries() async => _api.getAllLibraries();

  Future<List<Playlist>> getAllPlaylists() async => _api.getAllPlaylists();

  Future<Playlist> getPlaylist({required String id}) async {
    return _api.getPlaylist(id: id);
  }
}

@Riverpod(keepAlive: true, dependencies: [spotifyApi])
HomeRepository homeRepository(HomeRepositoryRef ref) {
  final api = ref.watch(spotifyApiProvider);
  return HomeRepository(api: api);
}
