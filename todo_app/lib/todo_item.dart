class TodoItem {
  final int id;
  String description;
  bool isDone;

  TodoItem({required this.id, required this.description, this.isDone = false});

  static TodoItem fromMap(Map<String, Object?> map) {
    return TodoItem(
        id: map['id'] as int,
        description: map['description'] as String,
        isDone: map['isDone'] == 1);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'description': description, 'isDone': isDone};
  }

  @override
  String toString() {
    return 'TodoItem(id: $id, description: $description, isDone: $isDone)';
  }
}
