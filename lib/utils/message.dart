import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class MessageUtils{
  final BuildContext context;
  MessageUtils(this.context);

  void showMessage({String message}) async {
    Scaffold.of(context).showSnackBar(new SnackBar(
      backgroundColor: Color.fromRGBO(49, 154, 143, 1),
      content: new Text(
        message,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.center,
      ),
    ));
  }

  void showToast({String message}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }


  void showToastLong({String message}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }


  void showToastColor({String message, Color backgroundColor, Color textColor}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0,
    );
  }



  static String nullCheckTest(String txt){
    return txt != null ? txt : '';
  }



}