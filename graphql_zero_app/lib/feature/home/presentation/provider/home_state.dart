// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:graphql_zero_app/common/model/model.dart';

@immutable
class HomeState {
  const HomeState(this.posts);

  final List<Post> posts;

  HomeState copyWith({List<Post>? posts}) {
    return HomeState(posts ?? this.posts);
  }

  @override
  bool operator ==(covariant HomeState other) {
    if (identical(this, other)) return true;

    return listEquals(other.posts, posts);
  }

  @override
  int get hashCode => posts.hashCode;
}
