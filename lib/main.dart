import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart' as Constants;
import 'views/mainPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Spori',
      theme: Constants.myTheme,
      home: MyHomePage(),
    );
  }
}

