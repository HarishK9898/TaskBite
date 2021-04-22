import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'TaskPage.dart';
import 'task.dart';

class PageList extends StatefulWidget {
  PageList({Key key}) : super(key: key);

  @override
  PageListState createState() {
    return PageListState();
  }
}

class PageListState extends State<PageList> {
  final items = [TaskPage("Home"), TaskPage("University")];

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 10),
        child: ListView.builder(
          shrinkWrap: true,
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
        ));
  }
}
