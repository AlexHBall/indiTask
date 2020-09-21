part of 'task_bloc.dart';

@immutable
abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

// no tasks yet
class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class NoTasks extends TaskState {}

class TasksLoaded extends TaskState {
  final List<Task> tasks;

  const TasksLoaded([this.tasks = const []]);

  @override
  List<Object> get props => [tasks];

  @override
  String toString() => 'TasksLoadSuccess { tasks: $tasks }';
}

class TaskError extends TaskState {
  final String message;
  TaskError(this.message);
}
