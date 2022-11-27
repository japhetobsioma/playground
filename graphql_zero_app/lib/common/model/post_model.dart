import 'package:graphql_zero_app/common/model/model.dart';
import 'package:graphql_zero_app/feature/post/data/model/comment_model.dart';

class PostModel extends Post {
  const PostModel({
    required super.id,
    required super.title,
    required super.body,
    required super.user,
    required super.comments,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    final user = () {
      if (json['user'] == null) {
        return const UserModel(id: '', name: '', username: '');
      }
      final userJson = json['user'] as Map<String, dynamic>;
      return UserModel.fromJson(userJson);
    }();

    final comments = () {
      if (json['comments'] == null) return <CommentModel>[];
      final commentsJson = json['comments'] as Map<String, dynamic>;
      final commentsData = commentsJson['data'] as List<dynamic>;
      final commentsMap = commentsData.cast<Map<String, dynamic>>();
      return List<CommentModel>.from(commentsMap.map(CommentModel.fromJson));
    }();

    return PostModel(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      user: user,
      comments: comments,
    );
  }
}
