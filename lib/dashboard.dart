import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/drawer.dart';
//import 'package:orderapp/drawerpages/cart.dart';
//import 'package:orderapp/drawerpages/cart%20copy.dart';
import 'package:orderapp/drawerpages/changepassword.dart';
// import 'package:orderapp/drawerpages/ledger.dart';
import 'package:orderapp/homepage/homefifth.dart';
import 'package:orderapp/homepage/homefourth.dart';
import 'package:orderapp/homepage/homeseventh.dart';
import 'package:orderapp/homepage/homesixth.dart';
import 'package:orderapp/homepage/homethreehalf.dart';
import 'package:orderapp/homepage/top_bar.dart';
import 'package:orderapp/loginscreen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:badges/badges.dart';

//-----------------------------------------------------------
Future<bool> showExitPopup(context) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     minimumSize: Size(double.infinity,
                //         30), // double.infinity is the width and 30 is the height
                //   ),
                //   onPressed: () {},
                //   child: Text('AlgoSmart'),
                // ),
                SizedBox(height: 10),
                Text("Do you want to exit the application?"),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          print('yes selected');
                          exit(0);
                        },
                        child: Text("Yes"),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blueAccent.shade700),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {
                        print('no selected');
                        Navigator.of(context).pop();
                      },
                      child: Text("No", style: TextStyle(color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                    ))
                  ],
                )
              ],
            ),
          ),
        );
      });
}
//-----------------------------------------------------------

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

var count = 0;

class _DashboardState extends State<Dashboard> {
  // ignore: non_constant_identifier_names
  DateTime pre_backpress = DateTime.now();
  String userName = "";
  List products = [];
  String userCookie = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getUserName();
    fetchProduct();
  }

//***************************************** */
  fetchProduct() async {
    // ---------------token-------------------
    final SharedPreferences pref = await SharedPreferences.getInstance();
    userCookie = pref.getString('userCookiekey')!;
    var url = Uri.parse('http://114.143.151.6:901/cart-list');
    var response = await http.get(url, headers: {'Cookie': userCookie});
    print(response.statusCode);
    if (response.statusCode == 200) {
      var items = jsonDecode(response.body);
      List products2 = [];
      if (items != null)
        for (var item in items) {
          products2.add(item);
        }
      setState(() {
        products = products2;
        count = products.length;
      });
    } else
      setState(() {
        count = 0;
      });
    print(count);
  }

//###########################################

  @override
  Widget build(BuildContext context) {
    void handleClick(String value) {
      switch (value) {
        case 'Change Password':
          {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => ChangePassword()));
          }
          break;
        case 'Logout':
          {
            //logoutUser();
            logOut();
            // {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => LoginScreen()));
            // }
          }
          break;
      }
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // backgroundColor: Colors.blue[700],
        backgroundColor: Colors.blueAccent.shade700,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    width: size.width * 0.2,
                    child: Text("Home"),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  _textBadge(),
                  // IconButton(
                  //   icon: Icon(Icons.shopping_cart, color: Colors.white),
                  //   onPressed: () {
                  //     Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //         builder: (BuildContext context) => Cart()));
                  //   },
                  // ),
                  //-------------------------------------
                  // Positioned(
                  //   top: 3.0,
                  //   right: 4.0,
                  //   child: Stack(
                  //     children: [
                  //       Center(
                  //         child: Text(
                  //           count.toString(),
                  //           style: new TextStyle(
                  //               color: Colors.white,
                  //               fontSize: 11.0,
                  //               fontWeight: FontWeight.w500),
                  //         ),
                  //       ),
                  //       IconButton(
                  //         icon: Icon(
                  //           Icons.shopping_cart,
                  //           color: Colors.white,
                  //           size: 30.0,
                  //         ),
                  //         onPressed: () {},
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  //----------------------------------
                  PopupMenuButton<String>(
                    onSelected: handleClick,
                    itemBuilder: (BuildContext context) {
                      return {'Change Password', 'Logout'}.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),

      // //BOTTOM NAVIGATION
      bottomNavigationBar: BottomNavigation(),
      backgroundColor: Colors.white,

      //BODY
      body: WillPopScope(
        onWillPop: () => showExitPopup(context),
        // onWillPop: () async {
        //   final timegap = DateTime.now().difference(pre_backpress);
        //   final cantExit = timegap >= Duration(seconds: 2);
        //   pre_backpress = DateTime.now();
        //   if (cantExit) {
        //     //show snackbar
        //     final snack = SnackBar(
        //       content: Text('Press Back button again to Exit'),
        //       duration: Duration(seconds: 2),
        //     );
        //     ScaffoldMessenger.of(context).showSnackBar(snack);
        //     return false; // false will do nothing when back press
        //   } else {
        //     return true; // true will exit the app
        //   }
        // },
        child: Scrollbar(
          thickness: 8,
          isAlwaysShown: true,
          radius: Radius.circular(10),
          child: SafeArea(
              child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TopBar(),
                Container(
                  height: size.height * 0.06,
                  width: size.width * 1,
                  color: Colors.blueAccent.shade700,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Welcome $userName",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Homefourth(),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Homehreehalf(),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Homefifth(),
                // SizedBox(
                //   height: size.height * 0.01,
                // ),
                // Container(
                //   color: Colors.blue,
                //   height: size.width * 0.01,
                // ),
                Homesixth(),
                // Container(
                //   color: Colors.blue,
                //   height: size.width * 0.01,
                // ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                HomeSeventh(),
                // Container(
                //   height: size.height * 0.15,
                //   width: size.width * 1,
                //   color: Colors.white,
                //   //Put your child widget here.
                // ),

                // SizedBox(
                //   height: size.height * 0.01,
                // ),

                // Container(
                //   height: size.height * 0.1,
                //   width: size.width * 1,
                //   color: Colors.yellow,
                //   //Put your child widget here.
                // ),
              ],
            ),
          )),
        ),
      ),

      drawer: MyDrawer(),
    );
  }

  void getUserName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    userName = pref.getString('usernamekey')!;
    setState(() {});
  }

//for logout button
  void logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('usernamekey');
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
  }

  Future logOut() async {
    var url = Uri.parse('http://114.143.151.6:901/logout');
    String userCookie = '';
    // ---------------token-------------------
    final SharedPreferences pref = await SharedPreferences.getInstance();
    userCookie = pref.getString('userCookiekey')!;
    setState(() {});
    print(userCookie);
    // -------------token ------------------------
    http.Response response;
    response = await http.get(url, headers: {'Cookie': userCookie});
    print(response.body);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
  }
}

Widget _textBadge() {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Badge(
      padding: EdgeInsets.all(6),
      badgeContent: Text(
        count.toString(),
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      child: IconButton(
        icon: Icon(Icons.shopping_cart, color: Colors.white),
        onPressed: () {},
      ),
      position: BadgePosition.topEnd(top: 2),
    ),
  );
}
