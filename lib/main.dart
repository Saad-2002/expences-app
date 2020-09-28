import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'Widgets/mainScreen.dart';
import 'dart:io';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoApp(
            theme: CupertinoThemeData(
              textTheme: CupertinoTextThemeData(
                  textStyle: TextStyle(fontFamily: 'OleoScript')),
              primaryColor: Colors.teal,
            ),
          )
        : MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.teal,
              fontFamily: 'OleoScript',
            ),
            home: MainScreen(),
          );
  }
}
