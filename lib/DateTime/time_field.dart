import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:task_app/Data/Database.dart';
import 'package:task_app/DateTime/icon_expand.dart';
import 'package:intl/intl.dart';

class TimeField extends StatefulWidget {
  String time;
  ValueChanged<String> parentAction;
  TimeField({Key key, this.time, this.parentAction}) : super(key: key);
  @override
  timeFieldState createState() => timeFieldState();
  IconExpand exp = IconExpand(
      text: "",
      icon: Icon(
        FlutterIcons.clock_mco,
        size: 30.0,
      ));
}

class timeFieldState extends State<TimeField> {
  String timeOfDayString(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    return DateFormat("h : mm a").format(dt);
  }

  TimeOfDay stringToTimeOfDay(String tod) {
    final format = DateFormat("h : mm a"); //"6:00 AM"
    return TimeOfDay.fromDateTime(format.parse(tod));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.only(right: 15),
      alignment: Alignment.centerRight,
      child: GestureDetector(
        child: Text(
          widget.time == null ? "Pick a Time" : "${widget.time} ",
          style: TextStyle(fontFamily: "Less Sans"),
        ),
        onTap: () {
          showTimePicker(
            builder: (context, child) {
              return Theme(
                data: ThemeData.light().copyWith(
                    colorScheme: ColorScheme.light(
                        primary: Colors.black87,
                        brightness: Brightness.dark,
                        surface: Colors.white,
                        onPrimary: Colors.white,
                        onSurface: Colors.black)),
                child: child,
              );
            },
            context: context,
            initialTime: widget.time == null
                ? TimeOfDay.now()
                : stringToTimeOfDay(widget.time),
          ).then((time) {
            setState(() {
              widget.time = timeOfDayString(time);
              widget.parentAction(widget.time);
              widget.exp.text = "${widget.time} ";
            });
          });
        },
      ),
    ));
  }
}
