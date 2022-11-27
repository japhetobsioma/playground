import 'package:flutter/foundation.dart';
import 'package:graphql_zero_app/common/model/model.dart';
import 'package:graphql_zero_app/feature/post/domain/entity/entity.dart';

@immutable
class Post {
  const Post({
    required this.id,
    required this.title,
    required this.body,
    required this.user,
    required this.comments,
  });

  final String id;
  final String title;
  final String body;
  final User user;
  final List<Comment> comments;

  Post copyWith({
    String? id,
    String? title,
    String? body,
    User? user,
    List<Comment>? comments,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      user: user ?? this.user,
      comments: comments ?? this.comments,
    );
  }

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.body == body &&
        other.user == user &&
        listEquals(other.comments, comments);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        body.hashCode ^
        user.hashCode ^
        comments.hashCode;
  }
}
