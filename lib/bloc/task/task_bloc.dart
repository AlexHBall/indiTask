import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:inditask/models/task.dart';
import 'package:inditask/repository/task_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskRepository taskRepo = TaskRepository();
  TaskBloc({@required this.taskRepo}) : super(TaskLoading());

  Future _saveTask(Task task) {
    return taskRepo.insertTask(task);
  }

  Future _updateTask(Task task) {
    return taskRepo.updateTask(task);
  }

  Stream<TaskState> _mapTasksLoadedToState() async* {
    try {
      final todos = await this.taskRepo.getAllTasks();
      yield TasksLoaded(todos);
    } catch (_) {
      yield TaskError("h");
    }
  }

  Stream<TaskState> _mapTasksAddedToState(AddTaskEvent event) async* {
    if (state is TasksLoaded) {
      _saveTask(event.task);
      final List<Task> updatedTodos = List.from((state as TasksLoaded).tasks)
        ..add(event.task);

      yield TasksLoaded(updatedTodos);
    } else if (state is NoTasks) {
      await _saveTask(event.task);
      yield TaskLoading();
    }
  }

  Stream<TaskState> _mapTaskEditedToState(EditTaskEvent event) async* {
    yield TaskLoading();
    if (state is TasksLoaded) {
      final List<Task> updatedTasks = (state as TasksLoaded).tasks.map((task) {
        return task.id == event.editedTask.id ? event.editedTask : task;
      }).toList();
      await _updateTask(event.editedTask);
      yield TasksLoaded(updatedTasks);
    }
  }

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    log('TaskBloc got event $event');
    if (event is LoadTasksEvent) {
      yield* _mapTasksLoadedToState();
    } else if (event is AddTaskEvent) {
      yield* _mapTasksAddedToState(event);
    } else if (event is EditTaskEvent) {
      yield* _mapTaskEditedToState(event);
    }
  }
}
