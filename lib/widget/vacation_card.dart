import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vacation_manager/models/vacation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vacation_manager/pages/vacation_details_page.dart';

class VacationCard extends StatefulWidget {
  final Vacation vacation;

  VacationCard({this.vacation});

  @override
  _VacationCardState createState() => _VacationCardState();
}

class _VacationCardState extends State<VacationCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => VacationDetails(vacation: widget.vacation)));
        setState(() {});
      },
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: widget.vacation.status == "1"
                ? Color.fromRGBO(49, 154, 143, 1)
                : widget.vacation.status == "2"
                ? Color.fromRGBO(154, 49, 59, 1)
                : Color.fromRGBO(49, 112, 154, 1),
          ),

          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    width: 30,
                    height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(1.0)),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.account_circle,
                      color: Colors.white,
                      size: 50,
                    ),
                    Text("Vacation Request",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ))
                  ],
                ),
                Padding(padding: EdgeInsets.all(40.0)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.vacation.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      Text("Employee at Nestech",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
