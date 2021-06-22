import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:task_app/Data/Database.dart';
import 'package:task_app/Pages/page.dart';
import 'package:task_app/Tasks/task.dart';
import 'package:uuid/uuid.dart';

import '../style.dart';

class TaskList extends StatefulWidget {
  List<Task> taskList;
  TaskPage currPage;
  VoidCallback changeIndex;
  TaskList({Key key, this.taskList, this.changeIndex, this.currPage})
      : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  var default_new_task = true;
  var uuid = Uuid();
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          margin: EdgeInsets.only(top: 30, left: 5),
          child: Row(children: [
            GestureDetector(
                onTap: () {
                  setState(() {
                    widget.changeIndex();
                    if (widget.currPage != null) {
                      widget.currPage.tasks = widget.taskList;
                    }
                  });
                },
                child: Icon(
                  FlutterIcons.menu_mdi,
                  size: 45,
                )),
            Text(
              widget.currPage != null ? widget.currPage.page.name : "",
              style: HeaderStyle,
            )
          ])),
      Expanded(
          child: ListView(children: [
        ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: widget.taskList.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              onDismissed: (DismissDirection direction) {
                setState(() {
                  DBProvider.db.deleteTask(widget.taskList[index].task_data.id);
                  widget.taskList.removeAt(index);
                  //remove from widget.taskList here
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
              child: widget.taskList[index],
              key: UniqueKey(),
              direction: DismissDirection.horizontal,
            );
          },
        ),
        GestureDetector(
            onTap: () {
              setState(() {
                default_new_task = !default_new_task;
              });
            },
            child: Container(
                child: default_new_task
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
                                      var task_data = Task_Data(
                                          id: uuid.v1(),
                                          name: text,
                                          pageID: widget.currPage == null
                                              ? "generic"
                                              : widget.currPage.page.id);
                                      widget.taskList.add(Task(task_data));
                                      //insert into widget.taskList here
                                      default_new_task = !default_new_task;
                                      DBProvider.db.insertTask(task_data);
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
      ]))
    ]);
  }
}
