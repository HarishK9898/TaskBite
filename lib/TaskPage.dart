import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'style.dart';

class TaskPage extends StatefulWidget {
  final name;
  final icon;
  TaskPage(this.name, this.icon);
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 30, left: 15),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Icon(
              this.widget.icon,
              size: 35,
            ),
            Container(
                margin: EdgeInsets.only(left: 15, top: 10),
                child: Text(
                  this.widget.name,
                  style: HeaderStyle,
                ))
          ],
        ));
  }
}
