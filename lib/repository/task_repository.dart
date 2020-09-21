import 'package:inditask/doa/doa.dart';
import 'package:inditask/models/task.dart';

class TaskRepository {
  final tasksDao = TasksDao();
  Future<List<Task>> getAllTasks() => tasksDao.getTaskList();
  Future insertTask(Task task) => tasksDao.insertTask(task);
  Future updateTask(Task task) => tasksDao.updateTask(task);

}
