import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vacation_manager/constant/constant.dart';
import 'package:vacation_manager/models/vacation.dart';
import 'package:vacation_manager/models/vacation.dart';
import 'package:vacation_manager/pages/home_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:vacation_manager/repo/vacation_repo.dart';
import 'package:vacation_manager/utils/message.dart';
class VacationDetails extends StatelessWidget {
  final Vacation vacation;

  VacationDetails({@required this.vacation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(49, 112, 154, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(49, 112, 154, 1),
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: _BodyVacationDetails(
                vacation: vacation,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BodyVacationDetails extends StatefulWidget {
  final Vacation vacation;

  _BodyVacationDetails({@required this.vacation});

  @override
  _BodyDetailsState createState() => _BodyDetailsState();
}

class _BodyDetailsState extends State<_BodyVacationDetails> {
  bool isLoading;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Container(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: size.height,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.1),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text("Employee Name:  ",
                                    style: TextStyle(
                                      color: Color.fromRGBO(49, 112, 154, 1),
                                      fontWeight: FontWeight.bold,
                                    )),
                                RichText(
                                    text: TextSpan(
                                        text: widget.vacation.name,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)))
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(18.0),
                            ),
                            Row(
                              children: <Widget>[
                                Text("Department:  ",
                                    style: TextStyle(
                                      color: Color.fromRGBO(49, 112, 154, 1),
                                      fontWeight: FontWeight.bold,
                                    )),
                                RichText(
                                    text: TextSpan(
                                        text:  department(widget.vacation),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)))
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(18.0),
                            ),
                            Row(
                              children: <Widget>[
                                Text("Vacation Type:  ",
                                    style: TextStyle(
                                      color: Color.fromRGBO(49, 112, 154, 1),
                                      fontWeight: FontWeight.bold,
                                    )),
                                RichText(
                                    text: TextSpan(
                                        text: vacationType(widget.vacation),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)))
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(18.0),
                            ),
                            Row(
                              children: <Widget>[
                                Text("Number of days/hours:  ",
                                    style: TextStyle(
                                      color: Color.fromRGBO(49, 112, 154, 1),
                                      fontWeight: FontWeight.bold,
                                    )),
                                RichText(
                                    text: TextSpan(
                                        text: widget.vacation.duration,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)
                                    )),

                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(18.0),
                            ),
                            Row(
                              children: <Widget>[
                                Text("Start in Date:  ",
                                    style: TextStyle(
                                      color: Color.fromRGBO(49, 112, 154, 1),
                                      fontWeight: FontWeight.bold,
                                    )),
                                RichText(
                                    text: TextSpan(
                                        text: widget.vacation.startDate,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)))
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(18.0),
                            ),
                            Row(
                              children: <Widget>[
                                Text("End Date:  ",
                                    style: TextStyle(
                                      color: Color.fromRGBO(49, 112, 154, 1),
                                      fontWeight: FontWeight.bold,
                                    )),
                                RichText(
                                    text: TextSpan(
                                        text: widget.vacation.endDate,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)))
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(18.0),
                            ),
                            Row(
                              children: <Widget>[
                                Text("Back to Work Date:  ",
                                    style: TextStyle(
                                      color: Color.fromRGBO(49, 112, 154, 1),
                                      fontWeight: FontWeight.bold,
                                    )),
                                RichText(
                                    text: TextSpan(
                                        text: widget.vacation.backToWorkDate,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)))
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(18.0),
                            ),
                            Row(
                              children: <Widget>[
                                Text("Submission Date:  ",
                                    style: TextStyle(
                                      color: Color.fromRGBO(49, 112, 154, 1),
                                      fontWeight: FontWeight.bold,
                                    )),
                                RichText(
                                    text: TextSpan(
                                        text: widget.vacation.submissionDate,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)))
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                ),
                                RaisedButton(
                                  onPressed: () {
                                    editVacationStatus(1);
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  color: Color.fromRGBO(49, 112, 154, 1),
                                  child: Text(
                                    "Accept",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(50.0),
                                ),
                                RaisedButton(
                                  onPressed: () {
                                    editVacationStatus(2);
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  color: Color.fromRGBO(49, 112, 154, 1),
                                  child: Text(
                                    "Reject",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ]),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Text(
                          "Vacation Request",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }




  void editVacationStatus(int status)async{


    try{
      setState(() {
        isLoading = true;
      });

      var response = await VacationRepo().editVacationStatus(this.widget.vacation.id, status, context);

      if(response.statusCode == SUCCESSCODE){

        bool isSuccess = response.object['success'];
        if(isSuccess == true){

          widget.vacation.status =  response.object['newStatus'];
          MessageUtils(context).showMessage(message: response.object['message']);
          Future.delayed(Duration(seconds: 2),(){
            Navigator.of(context).pop();
          });


        }else{
          
          MessageUtils(context).showMessage(message: response.object['message']);
        }

      }else{
        MessageUtils(context).showMessage(message: response.object);
      }


      setState(() {
        isLoading = false;
      });


    }catch(e){
      print(e);
      setState(() {
        isLoading = false;
      });

    }


  }




  String department(Vacation vacation) {
    if(vacation.department=="1"){
      return "IT";
    }
    else if(vacation.department=="2"){
      return "Telecommunication";
    }
    else{
      return "Mechatronics";
    }
  }

  String vacationType(Vacation vacation) {
    if(vacation.vacationType=="1"){
      return "Deserved";
    }
    else if(vacation.vacationType =="2"){
      return "Unpaid";
    }
    else if(vacation.vacationType=="3"){
      return "Hourly vacation";
    }
    else if(vacation.vacationType=="4"){
      return "Sick leave";
    }
    else if(vacation.vacationType=="5"){
      return "Marriage Leave";
    }
    else if(vacation.vacationType=="6"){
      return "Death leave";
    }
  }
}
