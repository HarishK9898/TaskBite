import 'package:flutter/material.dart';
import 'image_banner.dart';
import 'text_section.dart';
import 'style.dart';
import 'icon_expand.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('Home'),
            ),
            body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Stack(children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Task name"),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [IconExpand()])
                    ]),
                Container(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_right,
                        color: Colors.black, size: 50.0))
              ])
            ])));
  }
}
