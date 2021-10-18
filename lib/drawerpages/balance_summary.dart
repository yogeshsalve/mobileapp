import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/drawer.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BalanceSummary extends StatefulWidget {
  @override
  _BalanceSummaryState createState() => _BalanceSummaryState();
}

class _BalanceSummaryState extends State<BalanceSummary> {
  String userCookie = '';
  List items2 = [
    {"outstanding": 0.000, "unpaid": 0.000}
  ];
  @override
  void initState() {
    super.initState();
    postData();
  }

  postData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
// ---------------token-------------------
// final SharedPreferences pref = await SharedPreferences.getInstance();
    userCookie = pref.getString('userCookiekey')!;
    setState(() {});
    print(userCookie);
// -------------token ------------------------
    var url = Uri.parse("http://114.143.151.6:901/balance-summary");
    var response = await http.post(url, headers: {'Cookie': userCookie});
    // print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        items2 = jsonDecode(response.body);
        print(items2);
        print(items2[0]["outstanding"]);
        print(items2[0]["unpaid"]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        title: const Text('Order Enquiry'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    width: size.width * 0.27,
                    height: size.height * 0.15,
                    child: Card(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Text("OutStanding:"),
                          SizedBox(height: size.height * 0.05),
                          Text(items2[0]["outstanding"].toString())
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[200],
                        boxShadow: [
                          BoxShadow(color: Colors.black, blurRadius: 12.0)
                        ],
                        border: Border.all(color: Colors.black)),
                  ),
                ],
              ),
              SizedBox(
                width: size.width * 0.03,
              ),
              Column(
                children: [
                  Container(
                    width: size.width * 0.27,
                    height: size.height * 0.15,
                    child: Card(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Text("Unpaid:"),
                          SizedBox(height: size.height * 0.05),
                          Text(items2[0]["unpaid"].toString())
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[200],
                        boxShadow: [
                          BoxShadow(color: Colors.black, blurRadius: 12.0)
                        ],
                        border: Border.all(color: Colors.black)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
