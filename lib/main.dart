import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart' as Constants;
import 'views/mainPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Spori',
      theme: ThemeData(
        primaryColor: Constants.primaryColor,
      ),
      home: MyHomePage(),
    );
  }
}

