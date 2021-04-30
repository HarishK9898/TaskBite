import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'TaskPage.dart';
import 'style.dart';
import 'task.dart';

class PageList extends StatefulWidget {
  PageList({Key key}) : super(key: key);

  @override
  PageListState createState() {
    return PageListState();
  }
}

class PageListState extends State<PageList> {
  final items = [];
  var default_new = true;
  static const droplist = [
    DropdownMenuItem(
      child: Icon(FlutterIcons.ios_home_ion),
      value: 0,
    ),
    DropdownMenuItem(
      child: Icon(FlutterIcons.ios_book_ion),
      value: 1,
    ),
    DropdownMenuItem(
      child: Icon(FlutterIcons.ios_musical_note_ion),
      value: 2,
    ),
    DropdownMenuItem(child: Icon(FlutterIcons.ios_alarm_ion), value: 3)
  ];
  static const iconList = [
    FlutterIcons.ios_home_ion,
    FlutterIcons.ios_book_ion,
    FlutterIcons.ios_musical_note_ion,
    FlutterIcons.ios_alarm_ion
  ];
  var dropdownValue = Icon(
    Icons.android,
    semanticLabel: "android",
  );
  int val = 0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView(children: [
      ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            onDismissed: (DismissDirection direction) {
              setState(() {
                items.removeAt(index);
              });
            },
            secondaryBackground: Container(
              padding: EdgeInsets.only(right: 20),
              alignment: Alignment.centerRight,
              child: Icon(
                FlutterIcons.ios_close_circle_ion,
                size: 30,
              ),
              color: Colors.red,
            ),
            background: Container(),
            child: items[index],
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
          );
        },
      ),
      GestureDetector(
          onTap: () {
            setState(() {
              default_new = !default_new;
            });
          },
          child: Container(
              child: default_new
                  ? Container(
                      margin: EdgeInsets.only(top: 30, bottom: 30),
                      child: Stack(children: [
                        Container(
                            margin: EdgeInsets.only(left: 40),
                            child: Icon(
                              FlutterIcons.ios_add_ion,
                              size: 30,
                            )),
                        Container(
                            margin: EdgeInsets.only(top: 8),
                            alignment: Alignment.center,
                            child: Text("New Page", style: TaskTextStyle))
                      ]))
                  : Container(
                      margin: EdgeInsets.only(top: 30, bottom: 30),
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Row(children: [
                        Container(
                            margin: EdgeInsets.only(right: 20, bottom: 10),
                            child: DropdownButton(
                                value: val,
                                items: droplist,
                                onChanged: (value) {
                                  setState(() {
                                    val = value;
                                  });
                                })),
                        Expanded(
                            child: TextField(
                                keyboardType: TextInputType.text,
                                onSubmitted: (text) {
                                  setState(() {
                                    items.add(TaskPage(text, iconList[val]));
                                    default_new = !default_new;
                                  });
                                },
                                decoration: InputDecoration(
                                    counterText: "",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    hintText: "New Page",
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 0)))),
                      ]))))
    ]));
  }
}
