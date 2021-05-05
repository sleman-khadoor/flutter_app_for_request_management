import 'package:flutter/cupertino.dart';
import 'package:vacation_manager/constant/constant.dart';
import 'package:vacation_manager/models/vacation.dart';
import 'package:vacation_manager/networking/api.dart';
import 'package:vacation_manager/networking/response.dart';

class VacationRepo{

  Future<Response> getVacations(String query, BuildContext context)async{
    String url = 'requests';

    if (query != null) {
      url += '?$query';
    }
    Response response = await Api.getListItems2(url, context);
    return parsedVacationsFromJson(response, context);
  }




  Future<Response> parsedVacationsFromJson(Response response, context) async{
    try{
      if(response.statusCode== SUCCESSCODE)
      {
        print(response.object);

        List list = response.object['data'] ['data'];
        List<Vacation> vacations = list.map((vac) => Vacation.fromJson(vac)).toList();
        return Response(SUCCESSCODE, vacations);


      }
      else{
        return Response(ERROREXCEPTIONCODE, ERROREXCEPTION);
      }
    }
    catch(e){
      print(e);
      return Response(ERROREXCEPTIONCODE, ERROREXCEPTION);
    }


  }



  Future<Response> editVacationStatus(int vacationId,int status, BuildContext context)async{
    String url = 'status';
    print("vacationId = $vacationId");

    Map<String, dynamic> body = {
      "id" : vacationId,
      "status" : status
    };

    Response response = await Api.post(url, body,context);
    return parsedEditVacationStatusFromJson(response, status,context);
  }

  Future<Response> parsedEditVacationStatusFromJson(Response response, int status,context) async{
    try{
      if(response.statusCode== SUCCESSCODE)
      {
        print(response.object);
        bool isSuccess = response.object['success'];
        if(isSuccess == true){
          return Response(SUCCESSCODE, {
            "success" : true,
            "newStatus" : status.toString(),
            "message" : status == 1 ? "Request approved successfully" : "Request rejected successfully"
          });
        }else{
          return Response(SUCCESSCODE, {
            "success" : false,
            "message" : "Request Failed, please try again"
          });
        }

      }
      else{
        return Response(ERROREXCEPTIONCODE, ERROREXCEPTION);
      }
    }
    catch(e){
      print(e);
      return Response(ERROREXCEPTIONCODE, ERROREXCEPTION);
    }


  }



}