import 'package:flutter/material.dart';
import 'package:task_app/header.dart';

class Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: Header("Pages", false)));
  }
}
