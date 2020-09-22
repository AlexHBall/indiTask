import 'dart:async';

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
    print('loading all tasks');
    try {
      final todos = await this.taskRepo.getAllTasks();
      yield TasksLoaded(todos);
    } catch (_) {
      yield TaskError("h");
    }
  }

  Stream<TaskState> _mapTasksAddedToState(AddTaskEvent event) async* {
    print("trying to add and state $state");
    if (state is TasksLoaded) {
      print('saving');
      final List<Task> updatedTodos = List.from((state as TasksLoaded).tasks)
        ..add(event.task);
      _saveTask(event.task);
      yield TasksLoaded(updatedTodos);
    } else if (state is NoTasks) {
      _saveTask(event.task);
      yield TaskLoading();
    }
  }

  Stream<TaskState> _mapTaskEditedToState(EditTaskEvent event) async* {
    if (state is TasksLoaded) {
      print('trying to change id $event.editedTask.id');
      final List<Task> updatedTasks = (state as TasksLoaded).tasks.map((task) {
        return task.id == event.editedTask.id ? event.editedTask : task;
      }).toList();
      yield TasksLoaded(updatedTasks);
      _updateTask(event.editedTask);
    }
  }

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    print('got Event $event');
    if (event is LoadTasksEvent) {
      yield* _mapTasksLoadedToState();
    } else if (event is AddTaskEvent) {
      yield* _mapTasksAddedToState(event);
    } else if (event is EditTaskEvent) {
      yield* _mapTaskEditedToState(event);
    }
  }
}
