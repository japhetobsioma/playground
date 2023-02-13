import 'package:flutter_spotify_ui/core/spotify_api/model/song.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'playlist.freezed.dart';
part 'playlist.g.dart';

@freezed
class Playlist with _$Playlist {
  @JsonSerializable(explicitToJson: true)
  factory Playlist({
    required String id,
    required String name,
    required String description,
    required String creator,
    required String duration,
    required String followers,
    @JsonKey(name: 'PlaylistsSongs')
        required List<PlaylistsSongs> playlistsSongs,
  }) = _Playlist;

  factory Playlist.fromJson(Map<String, Object?> json) =>
      _$PlaylistFromJson(json);
}

@freezed
class AllPlaylists with _$AllPlaylists {
  @JsonSerializable(explicitToJson: true)
  factory AllPlaylists({
    required List<Playlist> allPlaylists,
  }) = _AllPlaylists;

  factory AllPlaylists.fromJson(Map<String, Object?> json) =>
      _$AllPlaylistsFromJson(json);
}
