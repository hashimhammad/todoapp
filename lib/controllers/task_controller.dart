import '../models/task_model.dart';
import '../services/task_storage.dart';

class TaskController {
  List<Task> tasks = [];

  Future<void> loadTasks() async {
    tasks = await TaskStorage.loadTasks();
  }

  Future<void> saveTasks() async {
    await TaskStorage.saveTasks(tasks);
  }

  void addTask(String title) {
    tasks.add(Task(title: title));
  }

  void toggleTask(int index) {
    tasks[index].isDone = !tasks[index].isDone;
  }

  void deleteTask(int index) {
    tasks.removeAt(index);
  }
}
