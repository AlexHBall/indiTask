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
      //TOOD: Change how these work to get the correct stats
      int numActive =
          event.tasks.where((todo) => !todo.softDelete).toList().length;
      int numCompleted =
          event.tasks.where((todo) => todo.softDelete).toList().length;
      yield StatsLoadSuccess(numActive, numCompleted);
    }
  }

  @override
  Future<void> close() {
    taskSubscription.cancel();
    return super.close();
  }
}
