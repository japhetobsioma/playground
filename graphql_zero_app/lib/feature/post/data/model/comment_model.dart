import 'package:graphql_zero_app/feature/post/domain/entity/entity.dart';

class CommentModel extends Comment {
  const CommentModel({
    required super.id,
    required super.name,
    required super.body,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] as String,
      name: json['name'] as String,
      body: json['body'] as String,
    );
  }
}
