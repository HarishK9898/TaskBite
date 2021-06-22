import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:task_app/Tasks/taskList.dart';
import 'package:task_app/style.dart';
import 'package:task_app/Tasks/task.dart';
import 'Pages/page.dart';
import 'Data/Database.dart';
import 'package:uuid/uuid.dart';

void main() => runApp(Home());

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<dynamic> task_data_list;
  Future<dynamic> page_data_list;
  @override
  void initState() {
    task_data_list = getTasks();
    page_data_list = getPages();
    super.initState();
  }

  _updateIndex() {
    setState(() {
      if (index_val == 0)
        index_val = 1;
      else
        index_val = 0;
    });
  }

  _updatePage(TaskPage page) {
    curr_page = page;
    curr_Name = curr_page.page.name;
    tasks = curr_page.tasks;
  }

  getPages() async {
    final data = await DBProvider.db.getPages();
    return data;
  }

  getTasks() async {
    final data = await DBProvider.db.getTasks();
    return data;
  }

  bool retrieved = false;

  List<Task> tasks = [];
  List<TaskPage> pages = [];

  List<Task> retrieved_tasks = [];

  TaskPage curr_page;
  var curr_Name = "";

  var default_new_task = true;
  var default_new_page = true;

  var curr_widget = Container(
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
      ]));

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
      TaskList(
        taskList: tasks,
        changeIndex: _updateIndex,
        currPage: curr_page,
      ),
      retrieved
          ? Column(children: [
              Container(
                  margin: EdgeInsets.only(top: 30, left: 5),
                  child: Row(children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            _updateIndex();
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
                            _updateIndex();
                            _updatePage(pages[index]);
                          });
                        },
                        child: Dismissible(
                          onDismissed: (DismissDirection direction) {
                            setState(() {
                              DBProvider.db.deletePage(pages[index].page.id);
                              pages[index].tasks.forEach((element) {
                                DBProvider.db.deleteTask(element.task_data.id);
                              });
                              pages.removeAt(index);
                              //remove from pages and tasks here
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
                                      child: Text("New Page",
                                          style: TaskTextStyle))
                                ]))
                            : Container(
                                margin: EdgeInsets.only(top: 10, bottom: 30),
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Row(children: [
                                  Container(
                                      margin:
                                          EdgeInsets.only(right: 5, bottom: 10),
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
                                              var page_data = Page_Data(
                                                  iconval: val,
                                                  name: text,
                                                  id: uuid.v1());
                                              pages
                                                  .add(TaskPage(page_data, []));
                                              //insert into pages here
                                              DBProvider.db
                                                  .insertPage(page_data);
                                              default_new_page =
                                                  !default_new_page;
                                            });
                                          },
                                          decoration: InputDecoration(
                                              counterText: "",
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              hintText: "New Page",
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 0)))),
                                  Container(
                                      margin: EdgeInsets.only(left: 5),
                                      child: Icon(FlutterIcons
                                          .ios_close_circle_outline_ion))
                                ]))))
              ]))
            ])
          : FutureBuilder(
              future: Future.wait([task_data_list, page_data_list]),
              builder: (_, pageData) {
                switch (pageData.connectionState) {
                  case ConnectionState.none:
                    return Container();
                  case ConnectionState.waiting:
                    return Container();
                  case ConnectionState.active:
                  case ConnectionState.done:
                    pages = pageData.data[1];
                    retrieved_tasks = pageData.data[0];
                    if (!retrieved) {
                      pages.forEach((page) {
                        retrieved_tasks.forEach((task) {
                          if (task.task_data.pageID == page.page.id &&
                              page.tasks.contains(task) == false) {
                            page.tasks.add(task);
                          }
                        });
                      });
                      retrieved = true;
                    }
                    return Column(children: [
                      Container(
                          margin: EdgeInsets.only(top: 30, left: 5),
                          child: Row(children: [
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _updateIndex();
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
                                    _updateIndex();
                                    curr_page = pages[index];
                                    curr_Name = curr_page.page.name;
                                    tasks = curr_page.tasks;
                                  });
                                },
                                child: Dismissible(
                                  onDismissed: (DismissDirection direction) {
                                    setState(() {
                                      DBProvider.db
                                          .deletePage(pages[index].page.id);
                                      pages[index].tasks.forEach((element) {
                                        DBProvider.db
                                            .deleteTask(element.task_data.id);
                                      });
                                      pages.removeAt(index);
                                      //remove from pages and tasks here
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
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 30),
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
                                              child: Text("New Page",
                                                  style: TaskTextStyle))
                                        ]))
                                    : Container(
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 30),
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Row(children: [
                                          Container(
                                              margin: EdgeInsets.only(
                                                  right: 5, bottom: 10),
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
                                                  keyboardType:
                                                      TextInputType.text,
                                                  onSubmitted: (text) {
                                                    setState(() {
                                                      var page_data = Page_Data(
                                                          iconval: val,
                                                          name: text,
                                                          id: uuid.v1());
                                                      pages.add(TaskPage(
                                                          page_data, []));
                                                      //insert into pages here
                                                      DBProvider.db.insertPage(
                                                          page_data);
                                                      default_new_page =
                                                          !default_new_page;
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                      counterText: "",
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      hintText: "New Page",
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 0)))),
                                          Container(
                                              margin: EdgeInsets.only(left: 5),
                                              child: Icon(FlutterIcons
                                                  .ios_close_circle_outline_ion))
                                        ]))))
                      ]))
                    ]);
                }
                return Container();
              })
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
