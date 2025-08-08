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

  bool get isOverdue =>
      status != TaskStatus.completed &&
          startDate.isBefore(DateTime.now().subtract(const Duration(hours: 24)));

  Duration get timeDifference => DateTime.now().difference(startDate);
}
