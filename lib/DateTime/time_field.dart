import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:task_app/DateTime/icon_expand.dart';

class TimeField extends StatefulWidget {
  @override
  _timeFieldState createState() => _timeFieldState();
  IconExpand exp = IconExpand(
      ValueNotifier(""),
      Icon(
        FlutterIcons.clock_mco,
        size: 30.0,
      ));
  TimeOfDay _time;
  bool isAM = true;
}

class _timeFieldState extends State<TimeField> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.only(right: 15),
      alignment: Alignment.centerRight,
      child: GestureDetector(
        child: Text(
          this.widget._time == null
              ? "Pick a Time"
              : "${this.widget._time.hour % 12 == 0 ? 12 : this.widget._time.hour % 12} : ${this.widget._time.minute < 10 ? "0" + this.widget._time.minute.toString() : this.widget._time.minute} ${this.widget.isAM ? "AM" : "PM"} ",
          style: TextStyle(fontFamily: "Less Sans"),
        ),
        onTap: () {
          showTimePicker(
            context: context,
            initialTime:
                this.widget._time == null ? TimeOfDay.now() : this.widget._time,
          ).then((time) {
            setState(() {
              this.widget._time = time;
              this.widget.isAM = this.widget._time.hour / 12 <= 1;
              this.widget.exp.text.value =
                  "${this.widget._time.hour % 12 == 0 ? 12 : this.widget._time.hour % 12} : ${this.widget._time.minute < 10 ? "0" + this.widget._time.minute.toString() : this.widget._time.minute} ${this.widget.isAM ? "AM" : "PM"} ";
            });
          });
        },
      ),
    ));
  }
}
