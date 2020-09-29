import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final String taskTable = 'Task_table';
final String colId = 'id';
final String colDescription = 'description';
final String colDate = 'dueDate';
final String colScore = 'cost';
final String colAlarm = 'hasAlarm';
final String colAlarmId = 'alarmId';
final String colSoftDelete = "softDelete";

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();
  Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "tasks.db");
    var database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    print("DBPath $path");
    return database;
  }

  //This is optional, and only used for changing DB schema migrations
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $taskTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colDescription TEXT, '
        '$colDate TEXT, $colScore INTEGER, $colAlarm INT, $colAlarmId INT, $colSoftDelete INTEGER)');
  }
}
