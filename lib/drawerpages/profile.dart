import 'package:flutter/material.dart';

import 'package:orderapp/bottomnavigation.dart';

import 'package:orderapp/drawer.dart';
import 'package:orderapp/drawerpages/color.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:orderapp/ProfileService.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String getData = "";
  String userName = "";
  String id = "";
  String username = "";
  String email = "";
  String company = "";
  String address = "";
  String contactno = "";
  @override
  void initState() {
    super.initState();
    getUserName();
    callLoginApi(context);
  }

//////////////////////////////////

  callLoginApi(BuildContext context) async {
    final service = ProfileServices();
    await Future.delayed(Duration(seconds: 1));

    service.apiCallLogin(
      {
        "email": userName,
      },
    ).then((value) {
      if (value.status == "200") {
        setState(() {
          getData = value.address.toString();
          id = value.id.toString();
          username = value.username.toString();
          email = value.email.toString();
          company = value.company.toString();
          address = value.address.toString();
          contactno = value.contactno.toString();
        });
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => Dashboard()));
      } else {}
    });
  }

  // _makingPhoneCall() async {
  //   const url = 'tel:9422082780';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

/////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        title: const Text('Profile'),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: Colors.orangeAccent[400],
      //   foregroundColor: Colors.black,
      //   onPressed: () async {
      //     launch('tel://$number');
      //     // Navigator.push(
      //     //     context, MaterialPageRoute(builder: (context) => PlaceOrder()));
      //   },
      //   icon: Icon(Icons.phone),
      //   label: Text(
      //     "CAll US",
      //     style: TextStyle(),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigation(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.blue.shade700, Colors.blue.shade300])),
                child: Container(
                  width: double.infinity,
                  height: 280.0,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            "https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png",
                          ),
                          radius: 50.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          userName,
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Card(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5.0),
                          clipBehavior: Clip.antiAlias,
                          color: Colors.white,
                          elevation: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 22.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        'Monthly Sale',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        "5200",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Yearly Sale",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        "28.5K",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            Container(
              //color: Colors.blue.shade700,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.blue.shade300, Colors.white])),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // SizedBox(
                    //   height: 10.0,
                    // ),
                    // Text(
                    //   'name: $username\n'
                    //   'email: $email\n'
                    //   'address: $address\n'
                    //   'company: $company\n',
                    //   style: TextStyle(
                    //     fontSize: 22.0,
                    //     fontStyle: FontStyle.italic,
                    //     fontWeight: FontWeight.w300,
                    //     color: Colors.black,
                    //     letterSpacing: 2.0,
                    //   ),
                    // ),

                    Card(
                      child: ListTile(
                        title: Text(
                          " Phone: $contactno",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      elevation: 5,
                      shadowColor: Colors.blue,
                      margin: EdgeInsets.all(1),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide:
                              BorderSide(color: Colors.green, width: 1)),
                    ),
                    // Card(
                    //   child: ListTile(
                    //     title: Text(
                    //       "Email: $email",
                    //       style: const TextStyle(fontWeight: FontWeight.bold),
                    //     ),
                    //   ),
                    //   elevation: 5,
                    //   shadowColor: Colors.blue,
                    //   margin: EdgeInsets.all(1),
                    //   shape: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(25),
                    //       borderSide:
                    //           BorderSide(color: Colors.green, width: 1)),
                    // ),
                    Card(
                      child: ListTile(
                        title: Text(
                          "Address: $address",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      elevation: 5,
                      shadowColor: Colors.blue,
                      margin: EdgeInsets.all(1),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide:
                              BorderSide(color: Colors.green, width: 1)),
                    ),
                    Card(
                      child: ListTile(
                        title: Text(
                          "Company: $company",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      elevation: 5,
                      shadowColor: Colors.blue,
                      margin: EdgeInsets.all(1),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide:
                              BorderSide(color: Colors.green, width: 1)),
                    ),
                    // ElevatedButton(
                    //   // style: style,
                    //   onPressed: _makingPhoneCall,
                    //   child: const Text('CALL'),
                    // ),
                    // const SizedBox(height: 30),

                    // ignore: deprecated_member_use
                    // RaisedButton(
                    //   onPressed: () {},
                    //   elevation: 6,
                    //   //color: Theme.of(context).accentColor,
                    //   color: Colors.yellow,
                    //   shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(25)),
                    //   child: Padding(
                    //     padding: EdgeInsets.all(10.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //       children: <Widget>[
                    //         Icon(
                    //           Icons.call,
                    //           color: Colors.black,
                    //         ),
                    //         Text(
                    //           'Contact To APL',
                    //           style: TextStyle(
                    //             fontSize: 20,
                    //             fontWeight: FontWeight.w700,
                    //             color: Colors.black,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 35,
                    // ),
                  ],
                ),
              ),
            ),
            // Container(
            //   width: 250.00,
            //   color: Colors.black,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: <Widget>[],
            //   ),
            // ),
            // Container(
            //   color: Colors.blue,
            //   height: 10.0,
            // )
          ],
        ),
      ),
    );
  }

  void getUserName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    userName = pref.getString('usernamekey')!;
    setState(() {});
  }
}
