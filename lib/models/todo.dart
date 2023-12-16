class Todo {
  final String iD;
  final String todoTitle;
  final String? todoSubtitle;
  final DateTime? createdAt;
  final bool isDone;

  Todo({
    required this.iD,
    required this.todoTitle,
    this.todoSubtitle,
    this.createdAt,
    this.isDone = false,
  });

  Todo copyWith({
    String? iD,
    String? todoTitle,
    String? todoSubtitle,
    DateTime? createdAt,
    bool? isDone,
  }) {
    return Todo(
      iD: iD ?? this.iD,
      todoTitle: todoTitle ?? this.todoTitle,
      todoSubtitle: todoSubtitle ?? this.todoSubtitle,
      createdAt: createdAt ?? this.createdAt,
      isDone: isDone ?? this.isDone,
    );
  }
}
