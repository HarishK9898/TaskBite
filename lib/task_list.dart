import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'task.dart';

class TaskList extends StatefulWidget {
  TaskList({Key key}) : super(key: key);

  @override
  TaskListState createState() {
    return TaskListState();
  }
}

class TaskListState extends State<TaskList> {
  final items = [Task("Harish"), Task("sup")];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          onDismissed: (DismissDirection direction) {
            setState(() {
              items.removeAt(index);
            });
          },
          secondaryBackground: Container(
            padding: EdgeInsets.only(right: 20),
            alignment: Alignment.centerRight,
            child: Icon(
              FlutterIcons.ios_close_circle_ion,
              size: 30,
            ),
            color: Colors.red,
          ),
          background: Container(
            padding: EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            child: Icon(
              FlutterIcons.ios_checkmark_circle_ion,
              size: 30,
            ),
            color: Colors.green,
          ),
          child: items[index],
          key: UniqueKey(),
          direction: DismissDirection.horizontal,
        );
      },
    ));
  }
}
