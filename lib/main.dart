import 'package:flutter/material.dart';
import 'image_banner.dart';
import 'text_section.dart';
import 'style.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ImageBanner("assets/images/kiyomizu-dera.jpg"),
              TextSection("summary", "something1"),
              TextSection("summary", "something1"),
              TextSection("summary", "something1"),
            ]),
      ),
      theme: ThemeData(
          appBarTheme:
              AppBarTheme(textTheme: TextTheme(title: AppBarTextStyle)),
          textTheme: TextTheme(title: TitleTextStyle, body1: Body1TextStyle)),
    );
  }
}
