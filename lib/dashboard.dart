import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/drawer.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        title: const Text('DashBoard'),
      ),

      // //BOTTOM NAVIGATION
      bottomNavigationBar: BottomNavigation(),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Padding(
            //   padding: const EdgeInsets.all(12.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: <Widget>[
            //       // Icon(
            //       //   Icons.menu,
            //       //   color: Colors.white,
            //       //   size: 52.0,
            //       // ),
            //       // Image.asset(
            //       //   "images/assets/image.png",
            //       //   width: 52.0,
            //       // )
            //     ],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Text(
                // "Welcome APL ORDER, \nSelect an option",
                "Welcome User",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20.0,
                  children: <Widget>[
                    SizedBox(
                      width: size.width * 0.40,
                      height: size.height * 0.25,
                      child: Card(
                        // color: Color.fromARGB(255, 21, 21, 21),
                        color: Colors.blue,
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                "images/assets/outstanding.png",
                                width: size.height * 0.1,
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Text(
                                "Outstanding",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Text(
                                "Rs. 10000",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              )
                            ],
                          ),
                        )),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.40,
                      height: size.height * 0.25,
                      child: Card(
                        // color: Color.fromARGB(255, 21, 21, 21),
                        color: Colors.blue,
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                "images/assets/note.png",
                                width: size.height * 0.1,
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Text(
                                "Pending Orders",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Text(
                                "12 Orders",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              )
                            ],
                          ),
                        )),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.40,
                      height: size.height * 0.25,
                      child: Card(
                        // color: Color.fromARGB(255, 21, 21, 21),
                        color: Colors.blue,
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                "images/assets/calendar.png",
                                width: size.height * 0.1,
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Text(
                                "Monthly Sale",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Text(
                                "Rs. 100000",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              )
                            ],
                          ),
                        )),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.40,
                      height: size.height * 0.25,
                      child: Card(
                        // color: Color.fromARGB(255, 21, 21, 21),
                        color: Colors.blue,
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  "images/assets/settings.png",
                                  width: size.height * 0.1,
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Text(
                                  "Yearly Sale",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "Rs. 1200000",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),

      drawer: MyDrawer(),
    );
  }
}
