import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:task_app/style.dart';
import 'task.dart';

class TaskList extends StatefulWidget {
  TaskList({Key key}) : super(key: key);

  @override
  TaskListState createState() {
    return TaskListState();
  }
}

class TaskListState extends State<TaskList> {
  final items = [Task("Harish"), Task("sup")];
  var default_new = true;
  var new_text = "";
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
            background: Container(
              padding: EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              child: Icon(
                FlutterIcons.ios_checkmark_circle_ion,
                size: 30,
              ),
              color: Colors.green,
            ),
            child: items[index],
            key: UniqueKey(),
            direction: DismissDirection.horizontal,
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
                            child: Text("New Task", style: TaskTextStyle))
                      ]))
                  : Container(
                      margin: EdgeInsets.only(top: 30, bottom: 30),
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Row(children: [
                        Expanded(
                            child: TextField(
                                keyboardType: TextInputType.text,
                                onSubmitted: (text) {
                                  setState(() {
                                    items.add(Task(text));
                                    default_new = !default_new;
                                  });
                                },
                                decoration: InputDecoration(
                                    counterText: "",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    hintText: "New Task",
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 0)))),
                        Icon(FlutterIcons.ios_close_circle_outline_ion)
                      ]))))
    ]));
  }
}
