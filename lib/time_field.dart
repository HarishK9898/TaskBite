import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class TimeField extends StatefulWidget {
  @override
  _TimeFieldState createState() => _TimeFieldState();
}

class _TimeFieldState extends State<TimeField> {
  String dropdownValue = "AM";
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
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          onChanged: (text) {
                            if (text.length == 1) {
                              _node.nextFocus();
                            }
                          },
                          decoration: InputDecoration(
                            counterText: "",
                            hintStyle: TextStyle(color: Colors.grey),
                            hintText: 'h',
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                          ))),
                  Container(
                      margin: EdgeInsets.only(left: 2, right: 2),
                      child: Text(':')),
                  IntrinsicWidth(
                      child: TextField(
                          maxLength: 2,
                          keyboardType: TextInputType.number,
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
                      margin: EdgeInsets.only(left: 5),
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(FlutterIcons.ios_arrow_down_ion),
                        iconSize: 10,
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 0,
                          color: Colors.black,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: <String>['AM', 'PM']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )),
                ]))));
  }
}
