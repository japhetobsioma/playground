import 'package:flutter_spotify_ui/core/spotify_api/model/library.dart';
import 'package:flutter_spotify_ui/core/spotify_api/model/playlist.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    required List<Library> yourLibrary,
    required List<Playlist> playlists,
    required Playlist currentPlaylist,
  }) = _HomeState;
}
