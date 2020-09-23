part of 'stat_bloc.dart';

@immutable
abstract class StatState extends Equatable {
  const StatState();

  @override
  List<Object> get props => [];
}

class StatsLoading extends StatState {
  @override
  String toString() => 'StatsLoading';
}

class StatsLoaded extends StatState {
  final int tasksEntered;
  final int totalPoints;
  final int percentageComplete;
  final int percentageLoss;

  const StatsLoaded(this.tasksEntered, this.totalPoints,this.percentageComplete,this.percentageLoss);

  @override
  List<Object> get props => [tasksEntered, totalPoints,percentageComplete,percentageLoss];

  @override
  String toString() {
    return 'StatsLoadSuccess { numActive: $tasksEntered, numCompleted: $totalPoints }';
  }
}

//TODO: Add error state