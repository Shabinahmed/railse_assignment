import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';
import 'dashedlines.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Task> tasks = [
    Task(id: 'Order-1043', title: 'Arrange Pickup', subtitle: 'Sandhya', assignee: 'Sandhya', startDate: DateTime.now().subtract(const Duration(hours: 10)), status: TaskStatus.started, isHighPriority: true),
    Task(id: 'Entity-2559', title: 'Adhoc Task', subtitle: 'Arman', assignee: 'Arman', startDate: DateTime.now().subtract(const Duration(hours: 16)), status: TaskStatus.started),
    Task(id: 'Order-1020', title: 'Collect Payment', subtitle: 'Sandhya', assignee: 'Sandhya', startDate: DateTime.now().subtract(const Duration(hours: 17)), status: TaskStatus.started, isHighPriority: true),
    Task(id: 'Order-194', title: 'Arrange Delivery', subtitle: 'Prashant', assignee: 'Prashant', startDate: DateTime(2025, 8, 20), status: TaskStatus.completed),
    Task(id: 'Entity-2184', title: 'Share Company Profile', subtitle: 'Asif Khan K', assignee: 'Asif Khan K', startDate: DateTime(2025, 8, 22), status: TaskStatus.completed),
    Task(id: 'Entity-472', title: 'Add Followup', subtitle: 'Avik', assignee: 'Avik', startDate: DateTime(2025, 8, 25), status: TaskStatus.completed),
    Task(id: 'Enquiry-3563', title: 'Convert Enquiry', subtitle: 'Prashant', assignee: 'Prashant', startDate: DateTime(2025, 8, 28), status: TaskStatus.notStarted),
    Task(id: 'Order-176', title: 'Arrange Pickup', subtitle: 'Prashant', assignee: 'Prashant', startDate: DateTime(2025, 9, 1), status: TaskStatus.notStarted, isHighPriority: true),
  ];

  void _startTask(Task task) {
    setState(() => task.status = TaskStatus.started);
  }

  void _completeTask(Task task) {
    setState(() => task.status = TaskStatus.completed);
  }

  void _editDate(Task task) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: task.startDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => task.startDate = picked);
    }
  }

  Color _getBorderColor(String id) {
    if (id.contains('Order')) return Colors.blue;
    if (id.contains('Entity')) return Colors.indigo;
    return Colors.deepPurple;
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Scaffold(
      appBar: AppBar(title: const Text('Task List'),
      centerTitle: true,),
      body: ListView.separated(

        itemCount: tasks.length,
        separatorBuilder: (context, index) => const Divider(
          color: Colors.grey,
          thickness: 0.5, // Barik si line
          height: 1,
          indent: 20,
          endIndent: 20,
        ),
        itemBuilder: (context, index) {
          final task = tasks[index];
          final isOverdue = task.status == TaskStatus.started && task.startDate.isBefore(now);
          final isDueTomorrow = task.status == TaskStatus.notStarted && task.startDate.difference(now).inDays == 1;
          final isDueIn2Days = task.status == TaskStatus.notStarted && task.startDate.difference(now).inDays == 2;

          return Container(
            color: Colors.white,
            // padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // LEFT VERTICAL STRIP
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: task.status == TaskStatus.notStarted
                      ? const DashedVerticalLine(height: 90)
                      : Container(
                    width: 4,
                    height: 90,
                    color: task.status == TaskStatus.completed
                        ? Colors.green
                        : _getBorderColor(task.id),
                  ),
                ),

                // CONTENT AREA
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LEFT SIDE
                      Expanded(
                        child: Opacity(
                          opacity: task.status == TaskStatus.completed ? 0.5 : 1.0,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  task.id,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF003366),
                                    decoration: TextDecoration.underline,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  task.title,
                                  style: const TextStyle(fontSize: 15),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Text(
                                      task.subtitle,
                                      style: const TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                    if (task.isHighPriority)
                                      const Padding(
                                        padding: EdgeInsets.only(left: 6),
                                        child: Text(
                                          'High Priority',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold, ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // RIGHT SIDE
                      Padding(
                        padding: const EdgeInsets.only(top: 4, right: 8), // Optional: tweak top padding
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (task.status == TaskStatus.completed)
                              Padding(
                                padding: const EdgeInsets.only(right: 9),
                                child: Text(
                                  'Completed: ${DateFormat('MMM d').format(task.startDate)}',
                                  style: const TextStyle(color: Colors.green),
                                ),
                              )
                            else if (isOverdue)
                              Padding(
                                padding: const EdgeInsets.only(right: 9),
                                child: Text(
                                  'Overdue - ${now.difference(task.startDate).inHours}h ${now.difference(task.startDate).inMinutes.remainder(60)}m',
                                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                                ),
                              ),

                            const SizedBox(height: 4),

                            if (task.status == TaskStatus.notStarted)
                              Padding(
                                padding: const EdgeInsets.only(right: 9),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      isDueTomorrow ? 'Due Tomorrow' : 'Due in 2 days',
                                      style: const TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    InkWell(
                                      onTap: () => _editDate(task),
                                      child: const Icon(Icons.edit_calendar_sharp, size: 16, color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),

                            const SizedBox(height: 4),

                            Padding(
                              padding: const EdgeInsets.only(right: 9),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Start: ${DateFormat('MMM d').format(task.startDate)}',
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  const SizedBox(width: 6),
                                  InkWell(
                                    onTap: () => _editDate(task),
                                    child: const Icon(Icons.edit_calendar, size: 16, color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 6),

                            if (task.status == TaskStatus.notStarted)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: TextButton.icon(
                                    onPressed: () => _startTask(task),
                                    icon: const Icon(Icons.play_arrow),
                                    label: const Text(
                                      'Start Task',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              )
                            else if (task.status == TaskStatus.started)
                              Align(
                                alignment: Alignment.topRight,
                                child: TextButton.icon(
                                  onPressed: () => _completeTask(task),
                                  icon: const Icon(Icons.check),
                                  label: const Text(
                                    'Mark as complete',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.green, fontSize: 14),
                                  ),
                                ),
                              ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
