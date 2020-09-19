import 'dart:async';
import 'package:inditask/models/task.dart';
import 'package:inditask/database/database.dart';
import 'package:intl/intl.dart';

DateFormat dateFormat = DateFormat("MM-dd-yyyy");
final String taskTable = 'Task_table';
final String colId = 'id';
final String colDescription = 'description';
final String colDate = 'date';
final String colScore = 'score';
final String colAlarm = 'alarm';
final String colSoftDelete = "softDelete";

class TasksDao {
  String today = dateFormat.format(DateTime.now());

  final dbProvider = DatabaseProvider.dbProvider;

  Future<List<Map<String, dynamic>>> getTaskMapList() async {
    final db = await dbProvider.database;
    var result = await db.query(taskTable, orderBy: '$colDate ASC');
    return result;
  }

  Future<int> insertTask(Task entry) async {
    final db = await dbProvider.database;
    var result = await db.insert(taskTable, entry.toMap());
    return result;
  }

  Future<int> updateTask(Task entry) async {
    final db = await dbProvider.database;
    int result = await db.update(taskTable, entry.toMap(),
        where: "id = ?", whereArgs: [entry.id]);
    return result;
  }

  Future<List<Task>> getTaskList() async {
    var taskMapList = await getTaskMapList(); // Get 'Map List' from database
    int count =
        taskMapList.length; // Count the number of map entries in db table

    List<Task> taskList = List<Task>();
    // For loop to create a 'Entry List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      taskList.add(Task.fromMapObject(taskMapList[i]));
    }
    return taskList;
  }
}
