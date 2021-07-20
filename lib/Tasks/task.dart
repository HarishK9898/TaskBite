import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:task_app/DateTime/date_field.dart';
import '../DateTime/icon_expand.dart';

import '../style.dart';
import '../DateTime/custom_expansion_tile.dart';
import '../DateTime/time_field.dart';
import '../Data/Database.dart';

class Task extends StatefulWidget {
  DateTime scheduled_DateTime = null;
  ValueChanged<bool> parentAction;
  Task_Data task_data;
  bool static_name = true;
  Task(this.task_data);
  //Task(this.task_data);
  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  void initstate() {
    super.initState();
  }

  void update_static() {
    setState(() {
      widget.static_name = false;
    });
  }

  TimeOfDay stringToTimeOfDay(String tod) {
    final format = DateFormat("h : mm a"); //"6:00 AM"
    return TimeOfDay.fromDateTime(format.parse(tod));
  }

  _updateDate(String text) {
    setState(() {
      widget.task_data.date = text;
      DBProvider.db.insertTask(widget.task_data);
      AwesomeNotifications().cancel(widget.task_data.id.hashCode);
      DateTime date = DateFormat("dd / MM / yyyy").parse(widget.task_data.date);
      if (widget.task_data.time != null) {
        TimeOfDay time = stringToTimeOfDay(widget.task_data.time);
        widget.scheduled_DateTime =
            DateTime(date.year, date.month, date.day, time.hour, time.minute);
        Notify(widget.scheduled_DateTime, widget.task_data);
      } else {
        widget.scheduled_DateTime = date;
        Notify(widget.scheduled_DateTime, widget.task_data);
      }
    });
  }

  _updateTime(String text) {
    setState(() {
      widget.task_data.time = text;
      DBProvider.db.insertTask(widget.task_data);
      AwesomeNotifications().cancel(widget.task_data.id.hashCode);
      TimeOfDay time = stringToTimeOfDay(widget.task_data.time);
      if (widget.task_data.date != null) {
        DateTime date =
            DateFormat("dd / MM / yyyy").parse(widget.task_data.date);
        widget.scheduled_DateTime =
            DateTime(date.year, date.month, date.day, time.hour, time.minute);
        Notify(widget.scheduled_DateTime, widget.task_data);
      } else {
        DateTime curr_date = DateTime.now();
        print(curr_date.day);
        widget.scheduled_DateTime =
            DateTime(curr_date.year, curr_date.month, time.hour, time.minute);
        Notify(widget.scheduled_DateTime, widget.task_data);
      }
    });
  }

  FocusNode myFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    TimeField timeField =
        TimeField(time: widget.task_data.time, parentAction: _updateTime);
    DateField dateField =
        DateField(date: widget.task_data.date, parentAction: _updateDate);
    bool isComplete = false;
    return Container(
        margin: EdgeInsets.only(left: 15),
        child: Container(
            child: CustomExpansionTile(
          trailing: SizedBox.shrink(),
          title: Stack(children: [
            Row(children: [
              GestureDetector(
                  onTap: () {
                    setState(() {
                      Notify(DateTime.now(), widget.task_data);
                      var x = widget.task_data.isComplete;
                      widget.task_data.isComplete = x == 0 ? 1 : 0;
                      DBProvider.db.insertTask(widget.task_data);
                    });
                  },
                  child: Container(
                      margin: EdgeInsets.only(right: 15),
                      child: widget.task_data.isComplete == 0
                          ? Icon(FlutterIcons.check_box_outline_blank_mdi)
                          : Icon(FlutterIcons.check_box_mdi))),
              Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onDoubleTap: () {
                            setState(() {
                              widget.static_name = false;
                              FocusScope.of(context).unfocus();
                            });
                          },
                          child: Container(
                              margin: EdgeInsets.only(bottom: 7, top: 5),
                              child: widget.static_name
                                  ? Text(
                                      widget.task_data.name,
                                      style: TaskTextStyle,
                                    )
                                  : Focus(
                                      onFocusChange: (hasFocus) {
                                        print("focus changed");
                                        if (!hasFocus) {
                                          setState(() {
                                            widget.static_name = true;
                                          });
                                        }
                                      },
                                      child: TextField(
                                          autofocus: true,
                                          focusNode: myFocusNode,
                                          onSubmitted: (text) {
                                            if (text.length > 0) {
                                              setState(() {
                                                widget.task_data.name = text;
                                                DBProvider.db.insertTask(
                                                    widget.task_data);
                                                AwesomeNotifications().cancel(
                                                    widget
                                                        .task_data.id.hashCode);
                                                Notify(
                                                    widget.scheduled_DateTime,
                                                    widget.task_data);
                                                widget.static_name = true;
                                              });
                                            } else {
                                              setState(() {
                                                widget.static_name = true;
                                              });
                                            }
                                          },
                                          controller: TextEditingController(
                                              text: widget.task_data.name),
                                          decoration: InputDecoration(
                                              counterText: "",
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 0))),
                                    ))),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
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
              )
            ]),
          ]),
          children: [
            Container(
                child: Row(children: [
              Container(
                margin: EdgeInsets.only(bottom: 15, top: 15, left: 20),
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
                margin: EdgeInsets.only(bottom: 15, top: 15, left: 20),
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

void Notify(DateTime datetime, Task_Data task_data) async {
  String timezom = await AwesomeNotifications().getLocalTimeZoneIdentifier();
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: task_data.id.hashCode,
          channelKey: 'key1',
          title: task_data.name,
          body: "Nothing",
          notificationLayout: NotificationLayout.Default),
      schedule: NotificationCalendar.fromDate(date: datetime));
}
