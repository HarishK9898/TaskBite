import 'package:flutter/material.dart';
import 'package:task_app/header.dart';
import 'package:task_app/page_list.dart';
import 'TaskPage.dart';

class Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Column(
      children: [Header("Pages", false), PageList()],
    )));
  }
}
