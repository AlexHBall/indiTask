part of 'stat_bloc.dart';

@immutable
abstract class StatEvent extends Equatable {
  const StatEvent();
}

class StatsUpdated extends StatEvent {
  final List<Task> tasks;

  const StatsUpdated(this.tasks);

  @override
  List<Object> get props => [tasks];

  @override
  String toString() => 'StatsUpdated { tasks: $tasks }';
}
