import 'package:flutter/material.dart';
import 'package:inditask/bloc/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inditask/ui/tasks.dart';
import 'package:inditask/utils/utils.dart';
import 'package:inditask/ui/home.dart';

void main() {
  runApp(ThisApp());
}

class ThisApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: basicTheme(),
      home: MultiBlocProvider(
        providers: Blocs.allBlocs(),
        child: Home(),
      ),
      routes: {
        "/tasks": (context) => InitialScreen(),
      },
    );
  }
}
