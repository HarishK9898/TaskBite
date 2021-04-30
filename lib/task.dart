import 'package:flutter/material.dart';
import 'package:task_app/date_field.dart';
import "icon_expand.dart";

import 'style.dart';
import 'custom_expansion_tile.dart';
import 'time_field.dart';

class Task extends StatefulWidget {
  final String name;
  ValueNotifier valueNotifier = ValueNotifier(TimeField());
  TimeField timeField = TimeField();
  DateField dateField = DateField();

  Task(this.name);
  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 15),
        child: Container(
            child: CustomExpansionTile(
          title: Stack(children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 7),
                    child: Text(
                      widget.name,
                      style: TaskTextStyle,
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [this.widget.timeField.exp]),
                ]),
          ]),
          children: [
            Container(
                child: Row(children: [
              Container(
                margin: EdgeInsets.only(bottom: 10, top: 10),
                child: Text(
                  "Date",
                  style: TextStyle(fontFamily: "Less Sans"),
                ),
              ),
              new Spacer(),
              this.widget.dateField,
            ])),
            Container(
                child: Row(children: [
              Container(
                margin: EdgeInsets.only(bottom: 10, top: 10),
                child: Text(
                  "Time",
                  style: TextStyle(fontFamily: "Less Sans"),
                ),
              ),
              new Spacer(),
              this.widget.timeField,
            ]))
          ],
        )));
  }
}
