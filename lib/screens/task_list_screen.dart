import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [
    Task(
      id: 'Order-1043',
      title: 'Arrange Pickup',
      subtitle: 'Sandhya',
      assignee: 'Sandhya',
      startDate: DateTime.now().subtract(const Duration(hours: 10)),
      status: TaskStatus.started,
      isHighPriority: true,
    ),
    Task(
      id: 'Entity-2559',
      title: 'Adhoc Task',
      subtitle: 'Arman',
      assignee: 'Arman',
      startDate: DateTime.now().subtract(const Duration(hours: 16)),
      status: TaskStatus.started,
    ),
    Task(
      id: 'Order-1020',
      title: 'Collect Payment',
      subtitle: 'Sandhya',
      assignee: 'Sandhya',
      startDate: DateTime.now().subtract(const Duration(hours: 17)),
      status: TaskStatus.started,
      isHighPriority: true,
    ),
    Task(
      id: 'Order-194',
      title: 'Arrange Delivery',
      subtitle: 'Prashant',
      assignee: 'Prashant',
      startDate: DateTime.now().subtract(const Duration(days: 10)),
      status: TaskStatus.completed,
    ),
    Task(
      id: 'Entity-2184',
      title: 'Share Company Profile',
      subtitle: 'Asif Khan K',
      assignee: 'Asif Khan K',
      startDate: DateTime.now().subtract(const Duration(days: 8)),
      status: TaskStatus.completed,
    ),
    Task(
      id: 'Enquiry-3563',
      title: 'Convert Enquiry',
      subtitle: 'Prashant',
      assignee: 'Prashant',
      startDate: DateTime.now().add(const Duration(days: 2)),
      status: TaskStatus.notStarted,
    ),
    Task(
      id: 'Order-176',
      title: 'Arrange Pickup',
      subtitle: 'Prashant',
      assignee: 'Prashant',
      startDate: DateTime.now().add(const Duration(days: 1)),
      status: TaskStatus.notStarted,
      isHighPriority: true,
    ),
  ];

  void _startTask(Task task) {
    setState(() {
      task.status = TaskStatus.started;
      print('Task "${task.id}" has been STARTED.');
    });
  }

  void _completeTask(Task task) {
    setState(() {
      task.status = TaskStatus.completed;
      print('Task "${task.id}" has been COMPLETED.');
    });
  }

  void _editDate(Task task) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: task.startDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.teal,
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.teal,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: child!,
          ),
        );
      },
    );

    if (picked != null) {
      setState(() {
        task.startDate = picked;
        print('Task "${task.id}" start date changed to: ${DateFormat('yyyy-MM-dd').format(picked)}');
      });
    }
  }

  Color _getBorderColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.notStarted:
        return Colors.grey.shade400;
      case TaskStatus.started:
        return Colors.orange.shade400;
      case TaskStatus.completed:
        return Colors.green.shade400;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: _getBorderColor(task.status), width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(
                task.id,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: task.id.contains('Order')
                      ? Colors.blue
                      : task.id.contains('Entity')
                      ? Colors.indigo
                      : Colors.deepPurple,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task.title),
                  Row(
                    children: [
                      Text(
                        task.subtitle,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      if (task.isHighPriority)
                        const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            'High Priority',
                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        )
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (task.status != TaskStatus.completed)
                        InkWell(
                          onTap: () => _editDate(task),
                          child: Row(
                            children: [
                              Text(
                                'Start: ${DateFormat('MMM d').format(task.startDate)}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(width: 6),
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.grey.shade300,
                                child: const Icon(Icons.edit_calendar, size: 16, color: Colors.black87),
                              ),
                              if (task.status == TaskStatus.notStarted) ...[
                                const SizedBox(width: 6),
                                CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.grey.shade300,
                                  child: const Icon(Icons.edit, size: 16, color: Colors.black87),
                                ),
                              ]
                            ],
                          ),
                        ),
                      if (task.status == TaskStatus.completed)
                        Text(
                          'Completed: ${DateFormat('MMM d').format(task.startDate)}',
                          style: const TextStyle(color: Colors.green),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  if (task.status == TaskStatus.notStarted)
                    TextButton(
                      onPressed: () => _startTask(task),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.play_arrow),
                          SizedBox(width: 6),
                          Text('Start Task'),
                        ],
                      ),
                    )
                  else if (task.status == TaskStatus.started)
                    TextButton(
                      onPressed: () => _completeTask(task),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.done),
                          SizedBox(width: 6),
                          Text('Mark as complete'),
                        ],
                      ),
                    ),
                  if (task.status != TaskStatus.completed)
                    Text(
                      task.startDate.isAfter(DateTime.now())
                          ? 'Due in ${task.startDate.difference(DateTime.now()).inDays} days'
                          : 'Overdue - ${task.timeDifference.inHours}h ${task.timeDifference.inMinutes.remainder(60)}m',
                      style: TextStyle(color: task.startDate.isAfter(DateTime.now()) ? Colors.orange : Colors.red),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
