part of 'stat_bloc.dart';

@immutable
abstract class StatState extends Equatable {
  const StatState();

  @override
  List<Object> get props => [];
}

class StatsLoading extends StatState {}

class StatsLoadSuccess extends StatState {
  //TODO: Expand this to include all the stats required
  final int numActive;
  final int numCompleted;

  const StatsLoadSuccess(this.numActive, this.numCompleted);

  @override
  List<Object> get props => [numActive, numCompleted];

  @override
  String toString() {
    return 'StatsLoadSuccess { numActive: $numActive, numCompleted: $numCompleted }';
  }
}

//TODO: Add error state