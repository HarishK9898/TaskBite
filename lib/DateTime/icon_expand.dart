import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class IconExpand extends StatefulWidget {
  ValueNotifier text;
  Icon icon;
  IconExpand(this.text, this.icon);
  @override
  _IconExpandState createState() => _IconExpandState();
}

class _IconExpandState extends State<IconExpand> {
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
            margin: EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
                border: new Border.all(
                    color: Colors.black, width: 2.0, style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Row(children: [
              Container(
                  margin: show && this.widget.text.value.toString().length > 0
                      ? EdgeInsets.only(right: 10)
                      : EdgeInsets.only(right: 0),
                  child: this.widget.icon),
              show
                  ? ValueListenableBuilder(
                      valueListenable: this.widget.text,
                      builder: (context, value, child) {
                        return Text(value);
                      },
                    )
                  : Container(
                      width: 0,
                    )
            ])));
  }
}
