import 'package:flutter/material.dart';
import './containers/Controller.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'YouPlayer',
        theme: ThemeData(
            primaryColor: Color.fromRGBO(250, 0, 0, 1),
            accentColor: Colors.white,
            textTheme: TextTheme(
                title: TextStyle(fontSize: 17),
                body1: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                body2: TextStyle(fontSize: 15),
                display1: TextStyle(fontSize: 13, color: Colors.red))),
        home: Controller());
  }
}
