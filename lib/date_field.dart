import 'package:flutter/material.dart';

class DateField extends StatefulWidget {
  String date = "";
  @override
  _DateFieldState createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  final FocusScopeNode _node = FocusScopeNode();
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
            margin: EdgeInsets.only(bottom: 20, top: 20, right: 10),
            child: FocusScope(
                node: _node,
                child: Row(children: [
                  IntrinsicWidth(
                      child: TextField(
                          maxLength: 2,
                          onChanged: (text) {
                            if (text.length == 2) {
                              _node.nextFocus();
                            }
                          },
                          decoration: InputDecoration(
                            counterText: "",
                            hintStyle: TextStyle(color: Colors.grey),
                            hintText: 'dd',
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                          ))),
                  Container(
                      margin: EdgeInsets.only(left: 2, right: 2),
                      child: Text('/')),
                  IntrinsicWidth(
                      child: TextField(
                          maxLength: 2,
                          onChanged: (text) {
                            if (text.length == 2) {
                              _node.nextFocus();
                            }
                          },
                          decoration: InputDecoration(
                              counterText: "",
                              hintStyle: TextStyle(color: Colors.grey),
                              hintText: "mm",
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 0)))),
                  Container(
                      margin: EdgeInsets.only(left: 2, right: 2),
                      child: Text('/')),
                  IntrinsicWidth(
                      child: TextField(
                          maxLength: 4,
                          onChanged: (text) {
                            if (text.length == 4) {}
                          },
                          decoration: InputDecoration(
                              counterText: "",
                              hintStyle: TextStyle(color: Colors.grey),
                              hintText: 'yyyy',
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 0))))
                ]))));
  }
}
