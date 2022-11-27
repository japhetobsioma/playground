import 'package:graphql_zero_app/common/model/model.dart';
import 'package:meta/meta.dart';

@immutable
class PostState {
  const PostState(this.post);

  final Post post;

  PostState copyWith({Post? post}) {
    return PostState(post ?? this.post);
  }

  @override
  bool operator ==(covariant PostState other) {
    if (identical(this, other)) return true;

    return other.post == post;
  }

  @override
  int get hashCode => post.hashCode;
}
