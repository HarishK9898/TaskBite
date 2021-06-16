import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'icon_expand.dart';

class DateField extends StatefulWidget {
  String date = "";
  IconExpand exp = IconExpand(
      ValueNotifier(""),
      Icon(
        FlutterIcons.date_range_mdi,
        color: Colors.black,
        size: 30.0,
      ));
  DateTime _dateTime;
  @override
  _DateFieldState createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.only(right: 15),
      alignment: Alignment.centerRight,
      child: GestureDetector(
        child: Text(
          widget._dateTime == null
              ? "Pick a Date"
              : "${widget._dateTime.month} / ${widget._dateTime.day} / ${widget._dateTime.year}",
          style: TextStyle(fontFamily: "Less Sans"),
        ),
        onTap: () {
          showDatePicker(
                  context: context,
                  initialDate: widget._dateTime == null
                      ? DateTime.now()
                      : widget._dateTime,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030))
              .then((date) {
            setState(() {
              widget._dateTime = date;
              this.widget.exp.text.value =
                  "${widget._dateTime.month} / ${widget._dateTime.day} / ${widget._dateTime.year}";
            });
          });
        },
      ),
    ));
  }
}
