import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class IconExpand extends StatefulWidget {
  @override
  _IconExpandState createState() => _IconExpandState();
}

class _IconExpandState extends State<IconExpand> {
  String text = "";
  bool show = false;
  @override
  initState() {
    super.initState();
    show = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            show = !show;
          });
        },
        child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: new Border.all(
                    color: Colors.black, width: 1.0, style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Row(children: [
              Container(
                  margin: show
                      ? EdgeInsets.only(right: 10)
                      : EdgeInsets.only(right: 0),
                  child: Icon(
                    FlutterIcons.date_range_mdi,
                    color: Colors.black,
                    size: 30.0,
                  )),
              show ? Text("17/04/2021") : Text("")
            ])));
  }
}
