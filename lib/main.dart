import 'package:flutter/material.dart';
import './Pages/HomePage.dart';

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
          title: TextStyle(fontSize: 20)
        )
      ),
      home: HomePage()
    );
  }
}
