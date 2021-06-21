import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:task_app/DateTime/date_field.dart';
import '../DateTime/icon_expand.dart';

import '../style.dart';
import '../DateTime/custom_expansion_tile.dart';
import '../DateTime/time_field.dart';
import '../Data/Database.dart';

class Task extends StatefulWidget {
  Task_Data task_data;
  Task(this.task_data);
  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  _updateDate(String text) {
    setState(() {
      widget.task_data.date = text;
      DBProvider.db.insertTask(widget.task_data);
    });
  }

  _updateTime(String text) {
    setState(() {
      widget.task_data.time = text;
      DBProvider.db.insertTask(widget.task_data);
    });
  }

  @override
  Widget build(BuildContext context) {
    TimeField timeField =
        TimeField(time: widget.task_data.time, parentAction: _updateTime);
    DateField dateField =
        DateField(date: widget.task_data.date, parentAction: _updateDate);
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
                    widget.task_data.time != null
                        ? IconExpand(
                            text: widget.task_data.time,
                            icon: Icon(
                              FlutterIcons.clock_mco,
                              size: 30.0,
                            ))
                        : Container(),
                    widget.task_data.date != null
                        ? IconExpand(
                            text: widget.task_data.date,
                            icon: Icon(
                              FlutterIcons.date_range_mdi,
                              color: Colors.black,
                              size: 30.0,
                            ))
                        : Container()
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
              dateField,
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
              timeField,
            ]))
          ],
        )));
  }
}
