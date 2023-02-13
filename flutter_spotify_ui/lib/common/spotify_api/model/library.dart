import 'package:freezed_annotation/freezed_annotation.dart';

part 'library.freezed.dart';
part 'library.g.dart';

@freezed
class Library with _$Library {
  const factory Library({
    required String id,
    required String title,
  }) = _Library;

  factory Library.fromJson(Map<String, dynamic> json) =>
      _$LibraryFromJson(json);
}

@freezed
class AllLibraries with _$AllLibraries {
  const factory AllLibraries({required List<Library> allLibraries}) =
      _AllLibraries;

  factory AllLibraries.fromJson(Map<String, dynamic> json) =>
      _$AllLibrariesFromJson(json);
}
