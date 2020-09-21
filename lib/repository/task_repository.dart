import 'package:inditask/doa/doa.dart';
import 'package:inditask/models/task.dart';
import 'package:inditask/repository/task_repo.dart';

class TaskRepository {
  // final tasksDoa = TasksDao();
  // @override
  // Future<List<Task>> loadTodos() {
  //   tasksDoa.getTaskList();
  // }

  // @override
  // Future saveTodos(List<Task> todos) {
  //   // TODO: implement saveTodos
  //   throw UnimplementedError();
  // }

  final tasksDao = TasksDao();
  Future<List<Task>> getAllTasks() => tasksDao.getTaskList();
  Future insertTask(Task task) => tasksDao.insertTask(task);
  Future updateTask(Task task) => tasksDao.updateTask(task);

}
