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
    final comments = json['comments'] as Map<String, dynamic>;
    final commentsData = comments['data'] as List<dynamic>;
    final commentsList = commentsData.cast<Map<String, dynamic>>();

    return PostModel(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      comments: List.from(commentsList.map(CommentModel.fromJson)),
    );
  }
}
