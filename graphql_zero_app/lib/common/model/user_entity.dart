import 'package:meta/meta.dart';

@immutable
class User {
  const User({required this.id, required this.name, required this.username});

  final String id;
  final String name;
  final String username;

  User copyWith({
    String? id,
    String? name,
    String? username,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
    );
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.username == username;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ username.hashCode;
}
