import 'package:vacation_manager/constant/constant.dart';
import 'package:vacation_manager/utils/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:vacation_manager/networking/response.dart';
class Api {
  static final _serverUrl = "https://ld.nestech.org";

  static get serverUrl => _serverUrl;

  static Future<Response> post(
      String url, Map<String, dynamic> body, context) async {
    try {

      http.Response response;
      String _url = '$serverUrl/api/$url';
      if (body == null) {
        response = await http.post(Uri.parse(_url), headers: {
          'Authorization': 'Bearer ' + SharedPrefs().getToken(),
        }).timeout(Duration(seconds: TIMEOUT));
      } else {
        response = await http
            .post(Uri.parse(_url),
            headers: {
              'Authorization': 'Bearer ' + SharedPrefs().getToken(),
            },
            body: json.encode(body))
            .timeout(Duration(seconds: TIMEOUT));
      }

      print('status code do Post ${response.statusCode}');
      print('body of do Post ${response.body}');
      var data = jsonDecode(response.body);
      if (response.statusCode == SUCCESSCODE) {
        return new Response(SUCCESSCODE, data);
      } else if (response.statusCode == 401 || response.statusCode == 403) {
//        logOut(context);
      } else {
        return new Response(response.statusCode, data);
      }
    } on TimeoutException catch (_) {
      return Response(ERRORTIMEOUTCODE, {"message": ERRORINTERNET});
    } catch (exception) {
      print(exception );
      return new Response(ERROREXCEPTIONCODE, {"message": ERROREXCEPTION});
    }
    return new Response(ERROREXCEPTIONCODE, {"message": ERROREXCEPTION});
  }

  static Future<Response> postUnAuthorized(
      String url, Map<String, dynamic> body, context) async {
    try {

      http.Response response;
      String _url = '$serverUrl/api/$url';
      if (body == null) {
        response = await http.post(Uri.parse(_url), headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
        }).timeout(Duration(seconds: TIMEOUT));
      } else {
        response = await http
            .post(Uri.parse(_url),
                headers: {
                  'content-type': 'application/json',
                  'accept': 'application/json',
                },
                body: json.encode(body))
            .timeout(Duration(seconds: TIMEOUT));
      }

      print('status code do Post ${response.statusCode}');
      print('body of do Post ${response.body}');
      var data = jsonDecode(response.body);
      print(response.statusCode);
      if (response.statusCode == SUCCESSCODE) {
        return new Response(SUCCESSCODE, data);
      } else if (response.statusCode == 401 || response.statusCode == 403) {
//        logOut(context);
      } else {
        return new Response(response.statusCode, data);
      }
    } on TimeoutException catch (_) {
      return Response(ERRORTIMEOUTCODE, {"message": ERRORINTERNET});
    } catch (exception) {
      print(exception );
      return new Response(ERROREXCEPTIONCODE, {"message": ERROREXCEPTION});
    }
    return new Response(ERROREXCEPTIONCODE, {"message": ERROREXCEPTION});
  }



  static Future<Response> put(
      String url, Map<String, dynamic> body, context) async {
    try {

      http.Response response;
      String _url = '$serverUrl/api/$url';
      if (body == null) {
        response = await http.put(Uri.parse(_url), headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
          'Authorization': 'Bearer ' + SharedPrefs().getToken(),
        }).timeout(Duration(seconds: TIMEOUT));
      } else {
        response = await http
            .put(Uri.parse(_url),
            headers: {
              'content-type': 'application/json',
              'accept': 'application/json',
              'Authorization': 'Bearer ' + SharedPrefs().getToken(),
            },
            body: json.encode(body))
            .timeout(Duration(seconds: TIMEOUT));
      }

      print('status code do Post ${response.statusCode}');
      print('body of do Post ${response.body}');
      var data = jsonDecode(response.body);
      if (response.statusCode == SUCCESSCODE) {
        return new Response(SUCCESSCODE, data);
      } else if (response.statusCode == 401 || response.statusCode == 403) {
//        logOut(context);
      } else {
        return new Response(response.statusCode, data);
      }
    } on TimeoutException catch (_) {
      return Response(ERRORTIMEOUTCODE, {"message": ERRORINTERNET});
    } catch (exception) {
      print(exception );
      return new Response(ERROREXCEPTIONCODE, {"message": ERROREXCEPTION});
    }
    return new Response(ERROREXCEPTIONCODE, {"message": ERROREXCEPTION});
  }



  static Future<Response> multipartRequestUnAuthenticated(String url, Map<String, String> body,
      String keyFilePath, String filePath, context) async {
    try {

      String _url = '$serverUrl/api/$url';
      var request = new http.MultipartRequest("POST", Uri.parse(_url));
      request.headers.putIfAbsent('content-type', () => 'application/json');
      request.headers.putIfAbsent('accept', () => 'application/json');

      if (filePath != null) {
        request.files
            .add(await http.MultipartFile.fromPath(keyFilePath, filePath));
      }

      if (body != null) {
        request.fields.addAll(body);
      }


      var response = await request.send();

      print('Multi Part Form ${response.statusCode}');
      var res = await http.Response.fromStream(response);
      var data = json.decode(res.body);
      print("data: $data");

      return new Response(response.statusCode, data);
    }on TimeoutException catch (_) {
      return Response(ERRORTIMEOUTCODE, {"message": ERRORINTERNET});
    } catch (exception) {
      print(exception );
      return new Response(ERROREXCEPTIONCODE, {"message": ERROREXCEPTION});
    }
  }


  static Future<Response> multipartRequest(String url, Map<String, String> body,
      String keyFilePath, String filePath, context) async {
    try {

      String _url = '$serverUrl/api/$url';
      var request = new http.MultipartRequest("POST", Uri.parse(_url));
      request.headers.putIfAbsent('content-type', () => 'application/json');
      request.headers.putIfAbsent('accept', () => 'application/json');
      request.headers.putIfAbsent('Authorization', () => 'Bearer ' + SharedPrefs().getToken());

      if (filePath != null) {
        request.files
            .add(await http.MultipartFile.fromPath(keyFilePath, filePath));
      }

      if (body != null) {
        request.fields.addAll(body);
      }


      var response = await request.send();

      print('Multi Part Form ${response.statusCode}');
      var res = await http.Response.fromStream(response);
      var data = json.decode(res.body);
      print("data: $data");

      return new Response(response.statusCode, data);
    } on TimeoutException catch (_) {
      return Response(ERRORTIMEOUTCODE, {"message": ERRORINTERNET});

    } catch (exception) {

      print(exception);
      return new Response(ERROREXCEPTIONCODE, {"message": ERROREXCEPTION});

    }
  }




  static Future<Response> getModel(String url, context) async {
    try {

      String _url = '$serverUrl/api/$url';
      http.Response response = await http.get(Uri.parse(_url), headers: {
        'Authorization': 'Bearer ' + SharedPrefs().getToken(),
        'content-type': 'application/json',
        'accept': 'application/json',
      }).timeout(Duration(seconds: TIMEOUT));

      print('status code get Model ${response.statusCode}');
      print('body of get Model ${response.body}');
      var data = jsonDecode(response.body);
      if (response.statusCode == SUCCESSCODE) {
        return new Response(SUCCESSCODE, data);

      } else if (response.statusCode == 401 || response.statusCode == 403) {
//        logOut(context);
      } else {
        return new Response(response.statusCode, data);
      }
    } on TimeoutException catch (_) {
      return Response(ERRORTIMEOUTCODE, {"message": ERRORINTERNET});
    } catch (exception) {
      print(exception );
      return new Response(ERROREXCEPTIONCODE, {"message": ERROREXCEPTION});
    }
    return new Response(ERROREXCEPTIONCODE, {"message": ERROREXCEPTION});
  }

  static Future<Response> delete(String url, context) async {
    try {

      String _url = '$serverUrl/api/$url';
      http.Response response = await http.delete(Uri.parse(_url), headers: {
        'Authorization': 'Bearer ' + SharedPrefs().getToken(),
        'content-type': 'application/json',
      'accept': 'application/json',
      }).timeout(Duration(seconds: TIMEOUT));

      print('status code delete ${response.statusCode}');
      print('body of delete ${response.body}');
      var data = jsonDecode(response.body);
      if (response.statusCode == SUCCESSCODE) {
        return new Response(SUCCESSCODE, data);
      } else if (response.statusCode == 401 || response.statusCode == 403) {
//        logOut(context);
      } else if (response.statusCode == ERRORSERVERCODE) {
        return new Response(ERRORSERVERCODE, data);
      } else {
        return new Response(response.statusCode, data);
      }
    } on TimeoutException catch (_) {
      return Response(ERRORTIMEOUTCODE, {"message": ERRORINTERNET});
    } catch (exception) {
      print(exception );
      return new Response(ERROREXCEPTIONCODE, {"message": ERROREXCEPTION});
    }
    return new Response(ERROREXCEPTIONCODE, {"message": ERROREXCEPTION});
  }

  static Future<Response> getListItems(
    String url,
    context,
  ) async {
    try {

      String _url = '$serverUrl/api/$url';
      http.Response response = await http.get(Uri.parse(_url), headers: {
        'Authorization': 'Bearer ' + SharedPrefs().getToken(),
        'content-type': 'application/json',
        'accept': 'application/json',
      }).timeout(Duration(seconds: TIMEOUT));

      print('status code get List items ${response.statusCode}');
      print('body of get List items ${response.body}');
      var data = jsonDecode(response.body);
      if (response.statusCode == SUCCESSCODE) {
        List list = data;
        return new Response(SUCCESSCODE, list);
      } else if (response.statusCode == 401 || response.statusCode == 403) {
//        logOut(context);
      } else {
        return new Response(response.statusCode, data);
      }
    } on TimeoutException catch (_) {
      return Response(ERRORTIMEOUTCODE, {"message": ERRORINTERNET});
    } catch (exception) {
      print(exception );
      return new Response(ERROREXCEPTIONCODE, {"message": ERROREXCEPTION});
    }
    return new Response(ERROREXCEPTIONCODE, {"message": ERROREXCEPTION});
  }



  static Future<Response> getListItems2(
      String url,
      context,
      ) async {
    try {

      String _url = '$serverUrl/api/$url';
      http.Response response = await http.get(Uri.parse(_url), headers: {
        'Authorization': 'Bearer ' + SharedPrefs().getToken(),
        'content-type': 'application/json',
        'accept': 'application/json',
      }).timeout(Duration(seconds: TIMEOUT));

      print('status code get List items ${response.statusCode}');
      print('body of get List items ${response.body}');
      var data = jsonDecode(response.body);
      if (response.statusCode == SUCCESSCODE) {
        return new Response(SUCCESSCODE, data);
      } else if (response.statusCode == 401 || response.statusCode == 403) {
//        logOut(context);
      } else {
        return new Response(response.statusCode, data);
      }
    } on TimeoutException catch (_) {
      return Response(ERRORTIMEOUTCODE, {"message": ERRORINTERNET});
    } catch (exception) {
      print(exception );
      return new Response(ERROREXCEPTIONCODE, {"message": ERROREXCEPTION});
    }
    return new Response(ERROREXCEPTIONCODE, {"message": ERROREXCEPTION});
  }

  static Future<Response> getListItemsUnAuthorized(
    String url,
    context,
  ) async {
    try {

      String _url = '$serverUrl/api/$url';
      http.Response response = await http
          .get(
        Uri.parse(_url),
          )
          .timeout(Duration(seconds: TIMEOUT));

      print('status code get List items ${response.statusCode}');
      print('body of get List items ${response.body}');
      var data = jsonDecode(response.body);
      if (response.statusCode == SUCCESSCODE) {
        List list = data;
        return new Response(SUCCESSCODE, list);
      } else if (response.statusCode == 401 || response.statusCode == 403) {
//        logOut(context);
      } else {
        return new Response(response.statusCode, data['message']);
      }
    } on TimeoutException catch (_) {
      return Response(ERRORTIMEOUTCODE, {"message": ERRORINTERNET});

    } catch (exception) {

      print(exception);
      return new Response(ERROREXCEPTIONCODE, {"message": ERROREXCEPTION});

    }
    return new Response(ERROREXCEPTIONCODE, {"message": ERROREXCEPTION});
  }



  static Future<Response> getModelUnAuthorized(String url, context) async {
    try {

      String _url = '$serverUrl/api/$url';
      http.Response response = await http.get(Uri.parse(_url),).timeout(Duration(seconds: TIMEOUT));

      print('status code get Model ${response.statusCode}');
      print('body of get Model ${response.body}');
      var data = jsonDecode(response.body);
      if (response.statusCode == SUCCESSCODE) {
        return new Response(SUCCESSCODE, data);

      } else if (response.statusCode == 401 || response.statusCode == 403) {
//        logOut(context);
      } else {
        return new Response(response.statusCode, data);
      }
    } on TimeoutException catch (_) {
      return Response(ERRORTIMEOUTCODE, {"message": ERRORINTERNET});

    } catch (exception) {

      print(exception);
      return new Response(ERROREXCEPTIONCODE, {"message": ERROREXCEPTION});

    }
    return new Response(ERROREXCEPTIONCODE, {"message": ERROREXCEPTION});

  }





}
