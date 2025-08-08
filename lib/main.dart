import 'package:flutter/material.dart';
import 'screens/task_list_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task List',
      home: const TaskListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
