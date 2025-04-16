import 'package:flutter/material.dart';
import '../controllers/task_controller.dart';
import '../models/task_model.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TaskController _controller = TaskController();
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.loadTasks().then((_) => setState(() {}));
  }

  void _addTask() {
    if (_textController.text.trim().isEmpty) return;
    setState(() {
      _controller.addTask(_textController.text.trim());
      _textController.clear();
    });
    _controller.saveTasks();
  }

  void _toggleTask(int index) {
    setState(() {
      _controller.toggleTask(index);
    });
    _controller.saveTasks();
  }

  void _deleteTask(int index) {
    setState(() {
      _controller.deleteTask(index);
    });
    _controller.saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = _controller.tasks;

    return Scaffold(
      appBar: AppBar(title: const Text('To-Do List')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      labelText: 'Add new task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addTask,
                  child: const Icon(Icons.add),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (_, index) {
                final task = tasks[index];
                return ListTile(
                  leading: Checkbox(
                    value: task.isDone,
                    onChanged: (_) => _toggleTask(index),
                  ),
                  title: Text(
                    task.title,
                    style: TextStyle(
                        decoration:
                            task.isDone ? TextDecoration.lineThrough : null),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteTask(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
