import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'style.dart';

class TaskPage extends StatefulWidget {
  final name;
  TaskPage(this.name);
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Icon(
              FlutterIcons.home_ent,
              size: 35,
            ),
            Container(
                margin: EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  this.widget.name,
                  style: HeaderStyle,
                ))
          ],
        ));
  }
}
