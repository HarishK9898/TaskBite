import 'package:flutter/material.dart';
import 'package:task_app/task_list.dart';
import 'header.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Column(children: [
      Header("Home", true),
      SingleChildScrollView(
          child:
              ConstrainedBox(constraints: BoxConstraints(), child: TaskList()))
    ])));
  }
}
