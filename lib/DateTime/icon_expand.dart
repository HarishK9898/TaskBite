import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class IconExpand extends StatefulWidget {
  String text;
  Icon icon;
  IconExpand({Key key, this.text, this.icon}) : super(key: key);
  @override
  _IconExpandState createState() => _IconExpandState();
}

class _IconExpandState extends State<IconExpand> with TickerProviderStateMixin {
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
            print(widget.text);
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
                  margin: show && widget.text.length > 0
                      ? EdgeInsets.only(right: 10)
                      : EdgeInsets.only(right: 0),
                  child: this.widget.icon),
              AnimatedSize(
                  vsync: this,
                  duration: Duration(milliseconds: 150),
                  curve: Curves.fastOutSlowIn,
                  child: show
                      ? Text(widget.text)
                      : Container(
                          width: 0,
                        ))
            ])));
  }
}
