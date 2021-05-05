import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vacation_manager/pages/home_page.dart';
import 'package:vacation_manager/pages/login_page.dart';
import 'dart:async';

import 'package:vacation_manager/utils/shared_preferences.dart';

class LauncherPage extends StatefulWidget {
  @override
  _LauncherPageState createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {



  @override
  void initState() {
    super.initState();

    Future.delayed(new Duration(seconds: 3), () async {
      initApp();

    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return new Scaffold(
      body: new Container(
        width: width,
        height: height,
        decoration: new BoxDecoration(
            color: Color.fromRGBO(49, 112, 154, 1)
        ),
        child: Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.all(36.0),
                child: Image.asset("assets/images/logo.png"),
              ),
              SizedBox(
                height: 12,
              ),
              buildLauncherText(),
              SizedBox(
                height: 32.0,
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget buildLauncherText() {
    return Column(
      children: [
        Text(
          "Vacation App",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "Powered by Nestech",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }


  void initApp(){

    if(SharedPrefs().getToken() != null){

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
              (Route<dynamic> route) => false);
    }else{
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginPage()),
              (Route<dynamic> route) => false);
    }
  }

}
