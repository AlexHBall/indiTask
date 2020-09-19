import 'package:flutter/material.dart';

class Tasks extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TaskWidget();
  }
}

class TaskWidget extends State<Tasks> {
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Code'),
      ),
      body: Center(child: Text('You have pressed the BUTTON $_count times.')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _count++),
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
    );
  }
}
