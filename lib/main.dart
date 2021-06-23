import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:task_app/Pages/pageList.dart';
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

  TaskPage curr_page;

  int index_val = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: AnimatedIndexedStack(index: index_val, children: [
      retrieved
          ? PageList(
              taskList: tasks,
              pageList: pages,
              changeIndex: _updateIndex,
              updatePage: _updatePage,
            )
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
                    List<Task> retrieved_tasks = pageData.data[0];
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
                    return PageList(
                      taskList: tasks,
                      pageList: pages,
                      changeIndex: _updateIndex,
                      updatePage: _updatePage,
                    );
                }
                return Container();
              }),
      TaskList(
        taskList: tasks,
        changeIndex: _updateIndex,
        currPage: curr_page,
      ),
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
