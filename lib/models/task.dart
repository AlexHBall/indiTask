import 'package:intl/intl.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Task extends Equatable {
  DateFormat daysFormat = DateFormat("MM-dd-yyyy");
  int _id;
  String _description;
  String _dueDate;
  int _cost;
  int _hasAlarm;
  int _completed = 0;

  Task(this._description, this._dueDate, this._cost, this._hasAlarm);
  Task.withId(this._id, this._description, this._dueDate, this._hasAlarm);

  int get id => _id;
  String get description => _description;
  String get date => _dueDate;
  int get cost => _cost;
  int get alarm => _hasAlarm;

  set task(String newTask) {
    this._description = newTask;
  }

  set date(String newDate) {
    this._dueDate = date;
  }

  set description(String description) {
    this._description = description;
  }

  set cost(int cost) {
    this._cost = cost;
  }

  set hasAlarm(int alarmStatus) {
    this._hasAlarm = alarmStatus;
  }

  set setCompleted(int deleted) {
    if (deleted == 0 || deleted == 1) {
      this._completed = deleted;
    }
  }

  get completed {
    return this._completed;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['description'] = _description;
    map['dueDate'] = _dueDate;
    map['cost'] = _cost;
    map['hasAlarm'] = _hasAlarm;
    map['softDelete'] = _completed;
    return map;
  }

  Task.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._description = map['description'];
    this._dueDate = map['dueDate'];
    this._cost = map['cost'];
    this._hasAlarm = map['hasAlarm'];
    this._completed = map['softDelete'];
  }

  DateTime getDateTime() {
    return daysFormat.parse(date);
  }

  @override
  String toString() {
    return "Task with ID [$_id] Description [$_description] date [$_dueDate] cost [$_cost] and alarm [$_hasAlarm]";
  }

  @override
  List<Object> get props => [_id, _description, _dueDate, _cost];
}
