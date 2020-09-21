part of 'task_bloc.dart';

@immutable
abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class LoadTasksEvent extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final Task task;

  const AddTaskEvent(this.task);

  @override
  List<Object> get props => [task];

  @override
  String toString() => 'TaskAdded { task: $task }';
}

class EditTaskEvent extends TaskEvent {
  final Task editedTask;

  const EditTaskEvent(this.editedTask);

  @override
  List<Object> get props => [editedTask];

  @override
  String toString() => 'TaskUpdated { task: $task }';
}
