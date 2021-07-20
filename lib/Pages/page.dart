import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:task_app/Tasks/task.dart';
import '../style.dart';
import '../Data/Database.dart';

class TaskPage extends StatefulWidget {
  Page_Data page;
  bool static_icon = true;
  bool static_name = true;
  bool isStatic;
  List<Task> tasks = []; //array of tasks related to this specific page
  TaskPage(this.page, this.tasks, this.isStatic);
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  static const iconList = [
    FlutterIcons.ios_home_ion,
    FlutterIcons.ios_book_ion,
    FlutterIcons.shopping_cart_mdi,
    FlutterIcons.work_mdi,
    FlutterIcons.running_faw5s,
    FlutterIcons.controller_classic_mco,
    FlutterIcons.food_fork_drink_mco
  ];
  static const droplist = [
    DropdownMenuItem(
      child: Icon(
        FlutterIcons.ios_home_ion,
      ),
      value: 0,
    ),
    DropdownMenuItem(
      child: Icon(
        FlutterIcons.ios_book_ion,
      ),
      value: 1,
    ),
    DropdownMenuItem(
      child: Icon(
        FlutterIcons.shopping_cart_mdi,
      ),
      value: 2,
    ),
    DropdownMenuItem(
        child: Icon(
          FlutterIcons.work_mdi,
        ),
        value: 3),
    DropdownMenuItem(child: Icon(FlutterIcons.running_faw5s), value: 4),
    DropdownMenuItem(
        child: Icon(FlutterIcons.controller_classic_mco), value: 5),
    DropdownMenuItem(child: Icon(FlutterIcons.food_fork_drink_mco), value: 6)
  ];
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 30, left: 25),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            GestureDetector(
                onDoubleTap: () {
                  setState(() {
                    widget.static_icon = false;
                    FocusScope.of(context).unfocus();
                  });
                },
                child: widget.static_icon
                    ? Icon(
                        iconList[widget.page.iconval],
                        size: 35,
                      )
                    : Focus(
                        onFocusChange: (hasfocus) {
                          if (!hasfocus) {
                            setState(() {
                              widget.static_icon = true;
                            });
                          }
                        },
                        child: DropdownButton(
                            autofocus: true,
                            value: widget.page.iconval,
                            items: droplist,
                            onChanged: (value) {
                              setState(() {
                                widget.page.iconval = value;
                                DBProvider.db.insertPage(widget.page);
                                widget.static_icon = true;
                              });
                            }))),
            Flexible(
                child: Container(
                    padding: EdgeInsets.only(left: 15, top: 0),
                    child: GestureDetector(
                        onDoubleTap: () {
                          setState(() {
                            widget.static_name = false;
                            FocusScope.of(context).unfocus();
                          });
                        },
                        child: Container(
                            width: 300,
                            child: widget.static_name
                                ? Text(
                                    widget.page.name,
                                    style: HeaderStyle,
                                  )
                                : Focus(
                                    onFocusChange: (hasfocus) {
                                      if (!hasfocus) {
                                        setState(() {
                                          widget.static_name = true;
                                        });
                                      }
                                    },
                                    child: TextField(
                                        onSubmitted: (text) {
                                          if (text.length > 0) {
                                            setState(() {
                                              widget.page.name = text;
                                              DBProvider.db
                                                  .insertPage(widget.page);
                                              widget.static_name = true;
                                            });
                                          } else {
                                            setState(() {
                                              widget.static_name = true;
                                            });
                                          }
                                        },
                                        autofocus: true,
                                        focusNode: focusNode,
                                        controller: TextEditingController(
                                            text: widget.page.name),
                                        decoration: InputDecoration(
                                            counterText: "",
                                            isDense: true,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 0))))))))
          ],
        ));
  }
}
