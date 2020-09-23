import 'package:flutter/material.dart';
import 'package:inditask/bloc/stat/stat_bloc.dart';
import 'package:inditask/bloc/tab/tab_bloc.dart';
import 'package:inditask/bloc/task/task_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Blocs {
  static List<BlocProvider> allBlocs() {
    return [
      BlocProvider<TaskBloc>(
        // ignore: missing_required_param
        create: (BuildContext context) => TaskBloc(),
      ),
      BlocProvider<TabBloc>(
        create: (context) => TabBloc(),
        child: Container(),
      )
    ];
  }
}
