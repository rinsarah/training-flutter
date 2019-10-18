import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_apps/pages/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.indigo,
      statusBarBrightness: Brightness.light,
    ));
    return MaterialApp(
      title: 'Todo Apps',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.indigo,
        accentColor: Colors.orange,
      ),
      home: LoginPage(),
    );
  }
}