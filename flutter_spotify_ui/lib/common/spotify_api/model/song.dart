import 'package:freezed_annotation/freezed_annotation.dart';

part 'song.freezed.dart';
part 'song.g.dart';

@freezed
class Song with _$Song {
  factory Song({
    required String id,
    required String title,
    required String artist,
    required String album,
    required String duration,
  }) = _Song;

  factory Song.fromJson(Map<String, Object?> json) => _$SongFromJson(json);
}

@freezed
class PlaylistsSongs with _$PlaylistsSongs {
  factory PlaylistsSongs({
    @JsonKey(name: 'Song') required Song song,
  }) = _PlaylistsSongs;

  factory PlaylistsSongs.fromJson(Map<String, Object?> json) =>
      _$PlaylistsSongsFromJson(json);
}
