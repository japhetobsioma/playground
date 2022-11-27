import 'package:graphql_zero_app/common/model/model.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.username,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      username: json['username'] as String,
    );
  }
}
