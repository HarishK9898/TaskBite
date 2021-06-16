import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:task_app/style.dart';
import 'package:task_app/Tasks/task.dart';
import 'Pages/TaskPage.dart';
import 'Data/Database.dart';
import 'package:uuid/uuid.dart';

void main() => runApp(Home());

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var tasks = [];
  var pages = [];

  var curr_page;
  var curr_Name = "";

  var default_new_task = true;
  var default_new_page = true;

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
  int index_val = 0;
  var uuid = Uuid();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: AnimatedIndexedStack(index: index_val, children: [
      Column(children: [
        Container(
            margin: EdgeInsets.only(top: 30, left: 5),
            child: Row(children: [
              GestureDetector(
                  onTap: () {
                    setState(() {
                      index_val = 1;
                      if (curr_page != null) {
                        curr_page.tasks = tasks;
                      }
                    });
                  },
                  child: Icon(
                    FlutterIcons.menu_mdi,
                    size: 45,
                  )),
              Text(
                curr_Name,
                style: HeaderStyle,
              )
            ])),
        Expanded(
            child: ListView(children: [
          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: tasks.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                onDismissed: (DismissDirection direction) {
                  setState(() {
                    tasks.removeAt(index);
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
                child: tasks[index],
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
                                        tasks.add(Task(Task_Data(
                                            id: uuid.v1(), name: text)));
                                        default_new_task = !default_new_task;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        counterText: "",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        hintText: "New Task",
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0)))),
                            Icon(FlutterIcons.ios_close_circle_outline_ion)
                          ]))))
        ]))
      ]),
      Column(children: [
        Container(
            margin: EdgeInsets.only(top: 30, left: 5),
            child: Row(children: [
              GestureDetector(
                  onTap: () {
                    setState(() {
                      index_val = 0;
                    });
                  },
                  child: Icon(
                    FlutterIcons.ios_arrow_back_ion,
                    size: 45,
                  )),
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
            itemCount: pages.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    setState(() {
                      index_val = 0;
                      curr_page = pages[index];
                      curr_Name = curr_page.name;
                      tasks = curr_page.tasks;
                    });
                  },
                  child: Dismissible(
                    onDismissed: (DismissDirection direction) {
                      setState(() {
                        pages.removeAt(index);
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
                    child: pages[index],
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
                                    onSubmitted: (text) {
                                      setState(() {
                                        pages.add(
                                            TaskPage(text, iconList[val], []));
                                        default_new_page = !default_new_page;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        counterText: "",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        hintText: "New Page",
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0)))),
                            Container(
                                margin: EdgeInsets.only(left: 5),
                                child: Icon(
                                    FlutterIcons.ios_close_circle_outline_ion))
                          ]))))
        ]))
      ])
    ])));
  }
}

class AnimatedIndexedStack extends StatefulWidget {
  final int index;
  final List<Widget> children;

  const AnimatedIndexedStack({
    Key key,
    this.index,
    this.children,
  }) : super(key: key);

  @override
  _AnimatedIndexedStackState createState() => _AnimatedIndexedStackState();
}

class _AnimatedIndexedStackState extends State<AnimatedIndexedStack>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  int _index;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );

    _index = widget.index;
    _controller.forward();
    super.initState();
  }

  @override
  void didUpdateWidget(AnimatedIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.index != _index) {
      _controller.reverse().then((_) {
        setState(() => _index = widget.index);
        _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _controller.value,
          child: Transform.scale(
            scale: 1.015 - (_controller.value * 0.015),
            child: child,
          ),
        );
      },
      child: IndexedStack(
        index: _index,
        children: widget.children,
      ),
    );
  }
}
