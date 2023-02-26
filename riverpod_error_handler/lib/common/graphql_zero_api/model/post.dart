import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  factory Post({
    required String id,
    required String title,
    required String body,
  }) = _Post;

  factory Post.fromJson(Map<String, Object?> json) => _$PostFromJson(json);
}

@freezed
class Posts with _$Posts {
  factory Posts({
    required List<Post> data,
  }) = _Posts;

  factory Posts.fromJson(Map<String, Object?> json) => _$PostsFromJson(json);
}
