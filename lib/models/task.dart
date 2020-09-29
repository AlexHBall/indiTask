import 'package:inditask/doa/doa.dart';
import 'package:intl/intl.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Task extends Equatable {
  DateFormat daysFormat = DateFormat("yyyy-MM-dd H:m:s");
  int _id;
  String _description;
  String _dueDate;
  int _cost;
  int __alarm;
  int _completed = 0;

  Task(this._description, this._dueDate, this._cost, this.__alarm);
  Task.withId(this._id, this._description, this._dueDate, this.__alarm);

  int get id => _id;
  String get description => _description;
  int get cost => _cost;
  int get alarm => __alarm;

  set task(String newTask) {
    this._description = newTask;
  }

  set date(DateTime newDate) {
    this._dueDate = daysFormat.format(newDate);
  }

  DateTime getDate() {
    DateTime date = daysFormat.parse(_dueDate);
    return date;
  }

  String getDateString() {
    return _dueDate;
  }

  set description(String description) {
    this._description = description;
  }

  set cost(int cost) {
    this._cost = cost;
  }

  set alarm(int alarmStatus) {
    this.__alarm = alarmStatus;
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
    map['hasAlarm'] = __alarm;
    map['softDelete'] = _completed;
    return map;
  }

  Task.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._description = map['description'];
    this._dueDate = map['dueDate'];
    this._cost = map['cost'];
    this.__alarm = map['hasAlarm'];
    this._completed = map['softDelete'];
  }

  @override
  String toString() {
    return "Task ID [$_id] Desc [$_description] date [$_dueDate] cost [$_cost] alarm [$__alarm] comp [$_completed]";
  }

  @override
  List<Object> get props => [_id, _description, _dueDate, _cost];
}
