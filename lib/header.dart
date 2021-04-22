import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'pages.dart';
import 'main.dart';

class Header extends StatelessWidget {
  final title;
  final isHome;
  Header(this.title, this.isHome);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 30, left: 10),
        child: Row(children: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(_createRoute());
              },
              child: Icon(
                isHome
                    ? FlutterIcons.menu_mdi
                    : FlutterIcons.ios_arrow_back_ion,
                size: 45,
              )),
          Text(
            title,
            style: TextStyle(fontSize: 20),
          )
        ]));
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          isHome ? Pages() : Home(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = isHome ? Offset(-1.0, 0.0) : Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.linear;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
