import 'package:flutter/material.dart';
import 'package:vacation_manager/constant/constant.dart';
import 'package:vacation_manager/networking/api.dart';
import 'package:vacation_manager/networking/response.dart';
import 'package:vacation_manager/utils/shared_preferences.dart';

class LoginRepo {
  Future<Response> signIn(
      String email, String password, BuildContext context) async {
    Map<String, dynamic> body = {
      'email': email,
      'password': password,
    };
    String url = 'auth/login';
    Response response = await Api.postUnAuthorized(url, body, context);
    print('response.statusCode ${response.statusCode}');
    return parsedSignResponseFromJson(response);
  }

  Future<Response> parsedSignResponseFromJson(Response response) async{
    try{
      if(response.statusCode== SUCCESSCODE)
        {
          print(response.object);
          String token = response.object["access_token"];
          SharedPrefs().saveToken(token);
          return Response(SUCCESSCODE, "Login Success");


        }
      else{
        return Response(ERROREXCEPTIONCODE, ERROREXCEPTION);
      }
    }
    catch(e){
      return Response(ERROREXCEPTIONCODE, ERROREXCEPTION);
    }


  }

}