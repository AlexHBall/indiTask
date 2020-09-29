import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:inditask/models/models.dart';
import 'package:inditask/bloc/tab/tab_event.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  TabBloc() : super(AppTab.tasks);

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    log('tab got event $event');
    if (event is TabUpdated) {
      yield event.tab;
    }
  }
}