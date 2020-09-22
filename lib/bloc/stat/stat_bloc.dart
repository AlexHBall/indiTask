import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inditask/bloc/bloc.dart';
import 'package:inditask/models/models.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'stat_event.dart';
part 'stat_state.dart';

class StatBloc extends Bloc<StatEvent, StatState> {
  final taskBloc;
  StreamSubscription taskSubscription;

  StatBloc({@required this.taskBloc}) : super(StatsLoading()) {
    taskSubscription = taskBloc.listen((state) {
      if (state is TasksLoaded) {
        add(StatsUpdated(state.tasks));
      }
    });
  }
  @override
  Stream<StatState> mapEventToState(StatEvent event) async* {
    if (event is StatsUpdated) {
      //TODO: Get loss

      List<Task> tasks = event.tasks;
      int tasksEntered = tasks.toList().length;
      int totalTasksCompleted = tasks.where((task) => task.completed).toList().length;
      int percentageComplete = (totalTasksCompleted / tasksEntered).round();
      int totalPoints = tasks.toList().fold(0, (sum, item) => sum + item.cost);
      yield StatsLoadSuccess(tasksEntered, totalPoints,percentageComplete,7);
    }
  }

  @override
  Future<void> close() {
    taskSubscription.cancel();
    return super.close();
  }
}
