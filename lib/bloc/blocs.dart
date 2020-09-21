import 'package:flutter/material.dart';
import 'package:inditask/bloc/task_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Blocs {
  static List<BlocProvider> allBlocs() {
    return [
      BlocProvider<TaskBloc>(
        create: (BuildContext context) => TaskBloc(),
      )
    ];
  }
}
