import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/dashboard.dart';
import 'package:orderapp/drawer.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:orderapp/splashscreen.dart';

class Outstanding extends StatefulWidget {
  @override
  _OutstandingState createState() => _OutstandingState();
}

class _OutstandingState extends State<Outstanding> {
  String userCookie = '';

  List products2 = [];

  List items3 = [];

  List productsdisplay = [
    {
      "discount": "0.000",
      "last_post_date": "00000",
      "order_number": "00000",
      "po_number": "00000",
      "ship_via_code": "00000",
      "ship_via_code_desc": "00000",
      "subtotal": "00000",
      "terms_code": "00000",
      "total_ex_tax": "00000",
      "total_in_tax": "00000",
      "total_tax": "00000"
    }
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
    // myController1.text = "0000";
    print(response.body);

    items3.clear();
    if (response.statusCode == 200) {
      var items2 = jsonDecode(response.body);
      // print(items2);
      for (var item2 in items2) {
        products2.add(item2);
        // products2.add(item2['itemno']);
        setState(() {
          items3 = products2;
          productsdisplay = products2;
        });
      }
    }

    // items3 = items1;

    print(productsdisplay);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        title: const Text('Outstanding Balance'),
        leading: BackButton(
            color: Colors.white,
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Dashboard()))),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.02),
            SizedBox(height: size.height * 0.05),
            SizedBox(height: size.height * 0.05),
            DataTable(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black38)),
              columns: [
                DataColumn(
                    label: Text(
                  'ID',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
                DataColumn(
                    label: Text('Outstanding',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Unpaid',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('1')),
                  DataCell(Text(productsdisplay[0]['outstanding'].toString())),
                  DataCell(Text(productsdisplay[0]['unpaid'].toString())),
                ]),
              ],
            ),
            SizedBox(height: size.height * 0.08),
            Container(
              alignment: Alignment.center,
              color: Colors.white,
              child: ElevatedButton(
                child: Text('Print Outstanding Report'),
                // onPressed: () {
                //   print('Pressed');
                // },
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    textStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    shape: StadiumBorder()),
              ),
            ),
          ],
        ),
      ),
      // drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
