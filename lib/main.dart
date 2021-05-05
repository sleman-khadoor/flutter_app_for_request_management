import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vacation_manager/models/vacation.dart';
import 'package:vacation_manager/pages/home_page.dart';
import 'package:vacation_manager/pages/launcher_page.dart';
import 'package:vacation_manager/pages/login_page.dart';
import 'package:vacation_manager/pages/vacation_details_page.dart';
import 'package:vacation_manager/utils/shared_preferences.dart';

void main() => runApp(
    MyApp()
);

class MyApp extends StatefulWidget{
  _MyAppState createState()=>new _MyAppState();
}

class _MyAppState extends State {
  // This widget is the root of your application.
  Widget build(BuildContext context) {
    SharedPrefs.init();
    return new MaterialApp(
        title: "VacationApp",
        debugShowCheckedModeBanner: false,
        home: LauncherPage()
    );
  }
}