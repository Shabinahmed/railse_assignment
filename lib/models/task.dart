enum TaskStatus { notStarted, started, completed }

class Task {
  final String id;
  final String title;
  final String subtitle;
  final String assignee;
  final bool isHighPriority;
  DateTime startDate;
  TaskStatus status;

  Task({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.assignee,
    required this.startDate,
    this.status = TaskStatus.notStarted,
    this.isHighPriority = false,
  });

  Duration get timeDifference => DateTime.now().difference(startDate);

  bool get isOverdue => startDate.isBefore(DateTime.now()) && status != TaskStatus.completed;

  bool get isDueTomorrow =>
      startDate.difference(DateTime.now()).inDays == 1 &&
          status == TaskStatus.notStarted;

  bool get isDueIn2Days =>
      startDate.difference(DateTime.now()).inDays == 2 &&
          status == TaskStatus.notStarted;

}
