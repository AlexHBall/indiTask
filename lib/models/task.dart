import 'package:intl/intl.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

DateFormat daysFormat = DateFormat("yyyy-MM-dd H:m:s");

// ignore: mustbeimmutable
class Task extends Equatable {
  String id;
  String description;
  String dueDate;
  int cost;
  int alarm;
  int alarmId = -1;
  int completed = 0;

  Task(this.description, this.dueDate, this.cost, this.alarm)
      : this.id = Uuid().v4();

  @override
  List<Object> get props =>
      [id, description, dueDate, cost, alarm, alarmId, completed];

  DateTime getDate() {
    DateTime date = daysFormat.parse(dueDate);
    return date;
  }

  static String convert(DateTime date) {
    return daysFormat.format(date);
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['description'] = description;
    map['dueDate'] = dueDate;
    map['cost'] = cost;
    map['hasAlarm'] = alarm;
    map['alarmId'] = alarmId;
    map['softDelete'] = completed;
    return map;
  }

  Task.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.description = map['description'];
    this.dueDate = map['dueDate'];
    this.cost = map['cost'];
    this.alarm = map['hasAlarm'];
    this.alarmId = map['alarmId'];
    this.completed = map['softDelete'];
  }

  @override
  String toString() {
    return "Task ID [$id] Desc [$description] date [$dueDate] cost [$cost] alarm [$alarm] comp [$completed]";
  }
}
