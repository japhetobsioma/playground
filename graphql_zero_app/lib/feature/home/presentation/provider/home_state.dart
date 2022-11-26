import 'package:flutter/foundation.dart';
import 'package:graphql_zero_app/feature/home/domain/entity/entity.dart';

@immutable
class HomeState {
  const HomeState(this.posts);

  final List<Post> posts;

  @override
  bool operator ==(covariant HomeState other) {
    if (identical(this, other)) return true;

    return listEquals(other.posts, posts);
  }

  @override
  int get hashCode => posts.hashCode;
}
