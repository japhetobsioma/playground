import 'package:meta/meta.dart';

@immutable
class Comment {
  const Comment({required this.id, required this.name, required this.body});

  final String id;
  final String name;
  final String body;

  Comment copyWith({
    String? id,
    String? name,
    String? body,
  }) {
    return Comment(
      id: id ?? this.id,
      name: name ?? this.name,
      body: body ?? this.body,
    );
  }

  @override
  bool operator ==(covariant Comment other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.body == body;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ body.hashCode;
}
