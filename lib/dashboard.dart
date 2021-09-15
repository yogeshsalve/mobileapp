import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/drawer.dart';
import 'package:orderapp/drawerpages/changepassword.dart';
import 'package:orderapp/homepage/homefifth.dart';
import 'package:orderapp/homepage/homefourth.dart';
import 'package:orderapp/homepage/homesixth.dart';
import 'package:orderapp/homepage/homethreehalf.dart';
import 'package:orderapp/homepage/top_bar.dart';
import 'package:orderapp/loginscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String userName = "";
  @override
  void initState() {
    super.initState();
    getUserName();
  }

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
            logoutUser();
            // {
            //   Navigator.of(context).pushReplacement(MaterialPageRoute(
            //       builder: (BuildContext context) => LoginScreen()));
            // }
          }
          break;
      }
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue[700],
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
                  IconButton(
                    icon: Icon(Icons.mic, color: Colors.white),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.shopping_cart, color: Colors.white),
                    onPressed: () {},
                  ),
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
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TopBar(),
            Container(
              height: size.height * 0.06,
              width: size.width * 1,
              color: Colors.blue,
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
            Container(
              color: Colors.blue,
              height: size.width * 0.01,
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Container(
              height: size.height * 0.15,
              width: size.width * 1,
              color: Colors.white,
              //Put your child widget here.
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Container(
              height: size.height * 0.1,
              width: size.width * 1,
              color: Colors.yellow,
              //Put your child widget here.
            ),
          ],
        ),
      )),

      // body: SafeArea(
      //     child: SingleChildScrollView(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Padding(
      //         padding: const EdgeInsets.all(18),
      //         child: Text(
      //           // "Welcome APL ORDER, \nSelect an option",
      //           "Welcome $userName",
      //           style: TextStyle(
      //               color: Colors.black,
      //               fontSize: 22.0,
      //               fontWeight: FontWeight.bold),
      //           textAlign: TextAlign.start,
      //         ),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.all(12.0),
      //         child: Center(
      //           child: Wrap(
      //             spacing: 20,
      //             runSpacing: 20.0,
      //             children: <Widget>[
      //               SizedBox(
      //                 width: size.width * 0.40,
      //                 height: size.height * 0.25,
      //                 child: Card(
      //                   // color: Color.fromARGB(255, 21, 21, 21),
      //                   color: Colors.blue,
      //                   elevation: 2.0,
      //                   shape: RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.circular(8.0)),
      //                   child: Center(
      //                       child: Padding(
      //                     padding: const EdgeInsets.all(8.0),
      //                     child: Column(
      //                       children: <Widget>[
      //                         Image.asset(
      //                           "images/assets/outstanding.png",
      //                           width: size.height * 0.1,
      //                         ),
      //                         SizedBox(
      //                           height: size.height * 0.02,
      //                         ),
      //                         Text(
      //                           "Outstanding",
      //                           style: TextStyle(
      //                               color: Colors.black,
      //                               fontWeight: FontWeight.bold,
      //                               fontSize: 15),
      //                         ),
      //                         SizedBox(
      //                           height: size.height * 0.01,
      //                         ),
      //                         Text(
      //                           "Rs. 10000",
      //                           style: TextStyle(
      //                               color: Colors.white,
      //                               fontWeight: FontWeight.bold,
      //                               fontSize: 18),
      //                         )
      //                       ],
      //                     ),
      //                   )),
      //                 ),
      //               ),
      //               SizedBox(
      //                 width: size.width * 0.40,
      //                 height: size.height * 0.25,
      //                 child: Card(
      //                   // color: Color.fromARGB(255, 21, 21, 21),
      //                   color: Colors.blue,
      //                   elevation: 2.0,
      //                   shape: RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.circular(8.0)),
      //                   child: Center(
      //                       child: Padding(
      //                     padding: const EdgeInsets.all(8.0),
      //                     child: Column(
      //                       children: <Widget>[
      //                         Image.asset(
      //                           "images/assets/note.png",
      //                           width: size.height * 0.1,
      //                         ),
      //                         SizedBox(
      //                           height: size.height * 0.02,
      //                         ),
      //                         Text(
      //                           "Pending Orders",
      //                           style: TextStyle(
      //                               color: Colors.black,
      //                               fontWeight: FontWeight.bold,
      //                               fontSize: 15.0),
      //                         ),
      //                         SizedBox(
      //                           height: size.height * 0.01,
      //                         ),
      //                         Text(
      //                           "12 Orders",
      //                           style: TextStyle(
      //                               color: Colors.white,
      //                               fontWeight: FontWeight.bold,
      //                               fontSize: 18.0),
      //                         )
      //                       ],
      //                     ),
      //                   )),
      //                 ),
      //               ),
      //               SizedBox(
      //                 width: size.width * 0.40,
      //                 height: size.height * 0.25,
      //                 child: Card(
      //                   // color: Color.fromARGB(255, 21, 21, 21),
      //                   color: Colors.blue,
      //                   elevation: 2.0,
      //                   shape: RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.circular(8.0)),
      //                   child: Center(
      //                       child: Padding(
      //                     padding: const EdgeInsets.all(8.0),
      //                     child: Column(
      //                       children: <Widget>[
      //                         Image.asset(
      //                           "images/assets/calendar.png",
      //                           width: size.height * 0.1,
      //                         ),
      //                         SizedBox(
      //                           height: size.height * 0.02,
      //                         ),
      //                         Text(
      //                           "Monthly Sale",
      //                           style: TextStyle(
      //                               color: Colors.black,
      //                               fontWeight: FontWeight.bold,
      //                               fontSize: 15.0),
      //                         ),
      //                         SizedBox(
      //                           height: size.height * 0.01,
      //                         ),
      //                         Text(
      //                           "Rs. 100000",
      //                           style: TextStyle(
      //                               color: Colors.white,
      //                               fontWeight: FontWeight.bold,
      //                               fontSize: 18.0),
      //                         )
      //                       ],
      //                     ),
      //                   )),
      //                 ),
      //               ),
      //               SizedBox(
      //                 width: size.width * 0.40,
      //                 height: size.height * 0.25,
      //                 child: Card(
      //                   // color: Color.fromARGB(255, 21, 21, 21),
      //                   color: Colors.blue,
      //                   elevation: 2.0,
      //                   shape: RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.circular(8.0)),
      //                   child: Center(
      //                     child: Padding(
      //                       padding: const EdgeInsets.all(8.0),
      //                       child: Column(
      //                         children: <Widget>[
      //                           Image.asset(
      //                             "images/assets/settings.png",
      //                             width: size.height * 0.1,
      //                           ),
      //                           SizedBox(
      //                             height: size.height * 0.02,
      //                           ),
      //                           Text(
      //                             "Yearly Sale",
      //                             style: TextStyle(
      //                                 color: Colors.black,
      //                                 fontWeight: FontWeight.bold,
      //                                 fontSize: 15.0),
      //                           ),
      //                           SizedBox(
      //                             height: 5.0,
      //                           ),
      //                           Text(
      //                             "Rs. 1200000",
      //                             style: TextStyle(
      //                                 color: Colors.white,
      //                                 fontWeight: FontWeight.bold,
      //                                 fontSize: 18.0),
      //                           )
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // )),

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
}
