import 'package:flutter/material.dart';

@immutable
class Task {
  const Task({
    required this.id,
    required this.label,
    this.completed = false,
  });

  final int id;
  final String label;
  final bool completed;

  Task copyWith({
    int? id,
    String? label,
    bool? completed,
  }) {
    return Task(
      id: id ?? this.id,
      label: label ?? this.label,
      completed: completed ?? this.completed,
    );
  }

  @override
  String toString() => 'Task(id: $id, label: $label, completed: $completed)';

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.label == label &&
        other.completed == completed;
  }

  @override
  int get hashCode => id.hashCode ^ label.hashCode ^ completed.hashCode;
}
