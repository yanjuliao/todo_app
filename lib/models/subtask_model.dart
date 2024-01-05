class Subtask {
  final int id;
  final int taskId;
  final String title;
  bool isCompleted;

  Subtask({
    required this.id,
    required this.taskId,
    required this.title,
    required this.isCompleted,
  });

  Subtask copyWith({int? id, int? taskId, String? title, bool? isCompleted}) {
    return Subtask(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskId': taskId,
      'title': title,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }
}
