import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:task_app/Data/Database.dart';
import 'package:task_app/Pages/page.dart';
import 'package:task_app/Tasks/task.dart';
import 'package:uuid/uuid.dart';

import '../style.dart';

class PageList extends StatefulWidget {
  List<Task> taskList;
  List<TaskPage> pageList;
  VoidCallback changeIndex;
  ValueSetter<TaskPage> updatePage;
  TaskPage alltasks;
  PageList(
      {Key key,
      this.taskList,
      this.pageList,
      this.changeIndex,
      this.updatePage})
      : super(key: key);

  @override
  _PageListState createState() => _PageListState();
}

class _PageListState extends State<PageList> {
  var default_new_page = true;
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
  int val = 0;
  var uuid = Uuid();
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          margin: EdgeInsets.only(top: 40, left: 20, bottom: 10),
          child: Row(children: [
            Text(
              "Pages",
              style: HeaderStyle,
            )
          ])),
      Expanded(
          child: ListView(children: [
        ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: widget.pageList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () {
                  setState(() {
                    widget.changeIndex();
                    widget.updatePage(widget.pageList[index]);
                  });
                },
                child: Dismissible(
                  onDismissed: (DismissDirection direction) {
                    setState(() {
                      DBProvider.db.deletePage(widget.pageList[index].page.id);
                      widget.pageList[index].tasks.forEach((element) {
                        AwesomeNotifications()
                            .cancel(element.task_data.id.hashCode);
                        DBProvider.db.deleteTask(element.task_data.id);
                      });
                      widget.pageList.removeAt(index);
                      //remove from widget.pageList and tasks here
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
                  child: widget.pageList[index],
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                ));
          },
        ),
        GestureDetector(
            onTap: () {
              setState(() {
                default_new_page = !default_new_page;
              });
            },
            child: Container(
                child: default_new_page
                    ? Container(
                        margin: EdgeInsets.only(top: 10, bottom: 30),
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
                        margin: EdgeInsets.only(top: 10, bottom: 30),
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Row(children: [
                          Container(
                              margin: EdgeInsets.only(right: 5, bottom: 10),
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
                                  autofocus: true,
                                  onSubmitted: (text) {
                                    setState(() {
                                      if (text.length > 0) {
                                        var page_data = Page_Data(
                                            iconval: val,
                                            name: text,
                                            id: uuid.v1());
                                        widget.pageList.add(
                                            TaskPage(page_data, [], false));
                                        //insert into widget.pageList here
                                        DBProvider.db.insertPage(page_data);
                                        default_new_page = !default_new_page;
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                      counterText: "",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      hintText: "New Page",
                                      isDense: true,
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 0)))),
                          Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Icon(
                                  FlutterIcons.ios_close_circle_outline_ion))
                        ]))))
      ]))
    ]);
  }
}
