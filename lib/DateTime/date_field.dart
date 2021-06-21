import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:task_app/Data/Database.dart';
import 'icon_expand.dart';

class DateField extends StatefulWidget {
  String date;
  ValueChanged<String> parentAction;
  DateField({Key key, this.date, this.parentAction}) : super(key: key);
  IconExpand exp = IconExpand(
      text: "",
      icon: Icon(
        FlutterIcons.date_range_mdi,
        color: Colors.black,
        size: 30.0,
      ));
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
          widget.date == null ? "Pick a Date" : "${widget.date}",
          style: TextStyle(fontFamily: "Less Sans"),
        ),
        onTap: () {
          showDatePicker(
                  context: context,
                  initialDate: widget.date == null
                      ? DateTime.now()
                      : DateFormat("dd / MM / yyyy").parse(widget.date),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030))
              .then((date) {
            setState(() {
              widget.date = DateFormat('dd / MM / yyyy').format(date);
              widget.parentAction(widget.date);
              this.widget.exp.text = "${widget.date}";
            });
          });
        },
      ),
    ));
  }
}
