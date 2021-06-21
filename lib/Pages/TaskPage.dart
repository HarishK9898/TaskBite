import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:task_app/Tasks/task.dart';
import '../style.dart';
import '../Data/Database.dart';

class TaskPage extends StatefulWidget {
  Page_Data page;
  List<Task> tasks = []; //array of tasks related to this specific page
  TaskPage(this.page, this.tasks);
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  static const iconList = [
    FlutterIcons.ios_home_ion,
    FlutterIcons.ios_book_ion,
    FlutterIcons.ios_musical_note_ion,
    FlutterIcons.ios_alarm_ion
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 30, left: 15),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Icon(
              iconList[widget.page.iconval],
              size: 35,
            ),
            Container(
                margin: EdgeInsets.only(left: 15, top: 10),
                child: Text(
                  widget.page.name,
                  style: HeaderStyle,
                ))
          ],
        ));
  }
}
