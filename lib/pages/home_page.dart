import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vacation_manager/constant/constant.dart';
import 'package:vacation_manager/models/vacation.dart';
import 'package:vacation_manager/pages/login_page.dart';
import 'package:vacation_manager/pages/vacation_loader_page.dart';
import 'package:vacation_manager/repo/vacation_repo.dart';
import 'package:vacation_manager/utils/shared_preferences.dart';
import 'package:vacation_manager/widget/vacation_card.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(49, 112, 154, 1),
        title: Text("Incoming Requests"),
        actions: [
          IconButton(icon: Icon(Icons.login),
              tooltip: "Logout",
              onPressed: (){

            SharedPrefs().logOut();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginPage()),
                    (Route<dynamic> route) => false);

          })
        ],
      ),
      body: Container(
          child: Column(
        children: [Expanded(child: BodyHomePage())],
      )),
    );
  }
}

class BodyHomePage extends StatefulWidget {
  @override
  _BodyHomePageState createState() => _BodyHomePageState();
}

class _BodyHomePageState extends State<BodyHomePage> {
  final GlobalKey<RefreshIndicatorState> _refreshItem =
      new GlobalKey<RefreshIndicatorState>();
  ScrollController _scrollController;
  bool _isLoading;
  bool _canLoadMore;
  int _currentPage ;
  int _statusCode;
  List<Vacation> vacations;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    _isLoading = true;
    _canLoadMore = true;
    vacations = [];

    _scrollController.addListener(() {
      if (_scrollController.position.extentAfter < 2 &&
          !_isLoading &&
          _canLoadMore) {
        getMoreVacations();
      }
    });

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshItem.currentState.show());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height;
    if (MediaQuery.of(context).size.aspectRatio >= 1.0) {
      height = width * MediaQuery.of(context).size.aspectRatio;
    } else {
      height = width / MediaQuery.of(context).size.aspectRatio;
    }
    return RefreshIndicator(
      key: _refreshItem,
      onRefresh: () async {
        await clearVacations();
        return;
      },
      child: Container(
        width: width,
        height: height,
        child: ListView(
          controller: _scrollController,
          children: [
            _isLoading && (vacations == null || vacations.length == 0)
                ? Container(child: VacationLoaderPage()) // newsLoaderPage()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      vacations != null && vacations.length > 0
                          ? _listCardsOfVacations()
                          : _statusCode == SUCCESSCODE &&
                                  (vacations.length == 0 || vacations == null)
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 32.0),
                                  child: Text("No Data Found .."),
                                )
                              : _statusCode == ERRORSERVERCODE ||
                                      _statusCode == 400
                                  ? Text("Something error ..")
                                  : _statusCode == ERRORTIMEOUTCODE
                                      ? Text("Time Out ..")
                                      : _statusCode == ERROREXCEPTIONCODE
                                          ? Text("Something error ..")
                                          : Text("Something error .."),
                      Padding(padding: EdgeInsets.all(4)),
                      _isLoading && _statusCode == SUCCESSCODE
                          ? Container(
                              child: Column(
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3.0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6.0,
                                  ),
                                  Text(
                                    "Loading ..",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      Padding(padding: EdgeInsets.all(32)),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  void clearVacations() {
    _isLoading = true;
    _canLoadMore = true;
    vacations = [];
    _currentPage = 1;

    getMoreVacations();
  }

  void getMoreVacations() async {
    setState(() {
      _statusCode = 200;
      _isLoading = true;
    });
    print('current  page = $_currentPage');

    try {
      var response =
          await VacationRepo().getVacations("page=$_currentPage", context);

      _statusCode = response.statusCode;
      print(_statusCode);
      if (response.statusCode == SUCCESSCODE) {
        if (response.object != null && (response.object as List).length > 0) {
          vacations.addAll(response.object);

          _currentPage++;
        } else {
          _canLoadMore = false;
        }
      } else {
        print(response.object.toString());
      }
      setState(() {
        _isLoading = false;
      });
    } catch (exception) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _listCardsOfVacations() {
    return Column(
      children: vacations
          .map((vacation) => VacationCard(
                vacation: vacation,
              ))
          .toList(),
    );
  }
}
