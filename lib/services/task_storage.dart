import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/task_model.dart';

class TaskStorage {
  static const _key = 'todo_tasks';

  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> encodedTasks =
        tasks.map((task) => jsonEncode(task.toJson())).toList();
    await prefs.setStringList(_key, encodedTasks);
  }

  static Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskList = prefs.getStringList(_key) ?? [];
    return taskList
        .map((taskStr) => Task.fromJson(jsonDecode(taskStr)))
        .toList();
  }
}
