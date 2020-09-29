import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:inditask/bloc/bloc.dart';
import 'package:inditask/models/models.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'stat_event.dart';
part 'stat_state.dart';

class StatBloc extends Bloc<StatEvent, StatState> {
  StreamSubscription taskSubscription;

  StatBloc({TaskBloc taskBloc})
      : assert(taskBloc != null),
        super(StatsLoading()) {
    void _onTaskStateChange(TaskState state) {
      print('I am listening for task state changes $state');
      if (state is TasksLoaded) {
        add(StatsUpdated(state.tasks));
      }
    }

    // Update with current Task Bloc state.
    _onTaskStateChange(taskBloc.state);
    taskSubscription = taskBloc.listen(_onTaskStateChange);
  }

  @override
  Stream<StatState> mapEventToState(StatEvent event) async* {
    if (event is StatsUpdated) {
      List<Task> tasks = event.tasks;
      if (tasks.length == 0) {
        yield StatsLoaded(0, 0, 0, 0);
      } else {
        int tasksEntered = tasks.toList().length;
        int totalTasksCompleted =
            tasks.where((task) => task.completed == 1).toList().length;
        int totalPoints =
            tasks.toList().fold(0, (sum, item) => sum + item.cost);
        int incompletePoints = tasks
            .where((task) => task.completed == 0)
            .fold(0, (sum, item) => sum + item.cost);

        int percentCompleted =
            ((totalTasksCompleted / tasksEntered) * 100).floor();
        int percentLoss = ((incompletePoints / totalPoints) * 100).floor();
        yield StatsLoaded(
            tasksEntered, totalPoints, percentCompleted, percentLoss);
      }
    }
  }

  @override
  Future<void> close() {
    taskSubscription.cancel();
    return super.close();
  }
}
