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
        primarySwatch: Colors.red,
        accentColor: Colors.white
      ),
      home: HomePage()
    );
  }
}
