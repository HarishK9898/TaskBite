import 'package:flutter/material.dart';
import 'package:task_app/DateTime/date_field.dart';
import '../DateTime/icon_expand.dart';

import '../style.dart';
import '../DateTime/custom_expansion_tile.dart';
import '../DateTime/time_field.dart';
import '../Data/Database.dart';

class Task extends StatefulWidget {
  TimeField timeField = TimeField();
  DateField dateField = DateField();
  Task_Data task_data;
  Task(this.task_data);
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
                      widget.task_data.name,
                      style: TaskTextStyle,
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    this.widget.timeField.exp,
                    this.widget.dateField.exp
                  ]),
                ]),
          ]),
          children: [
            Container(
                child: Row(children: [
              Container(
                margin: EdgeInsets.only(bottom: 15, top: 15),
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
                margin: EdgeInsets.only(bottom: 15, top: 15),
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
