import 'package:inditask/models/task.dart';
import 'package:inditask/repository/repository.dart';

import 'dart:async';

class TaskBloc {
  final _taskRepository = TaskRepository();

  final _taskController = StreamController<List<Task>>.broadcast();

  get myEntries => _taskController.stream;

  TaskBloc() {
    getEntries();
  }

  getEntries() async {
    _taskController.sink.add(await _taskRepository.getAllTasks());
  }

  addTask(Task task, String date) async {
    await _taskRepository.insertTask(task);
    getEntries();
  }

  dispose() {
    _taskController.close();
  }

  updateTask(Task task) async {
    await _taskRepository.updateTask(task);
  }
}
