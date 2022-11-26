import 'package:graphql_zero_app/feature/home/domain/entity/entity.dart';
import 'package:meta/meta.dart';

@immutable
class Post {
  const Post({
    required this.id,
    required this.title,
    required this.body,
    required this.user,
  });

  final String id;
  final String title;
  final String body;
  final User user;

  Post copyWith({
    String? id,
    String? title,
    String? body,
    User? user,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      user: user ?? this.user,
    );
  }

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.body == body &&
        other.user == user;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ body.hashCode ^ user.hashCode;
  }
}
