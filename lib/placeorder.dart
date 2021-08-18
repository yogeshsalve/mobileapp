import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:orderapp/store/buyform.dart';

// import 'package:orderapp/store/dropdown.dart';

class PlaceOrder extends StatefulWidget {
  @override
  _PlaceOrderState createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  String getData = '';
  // var url = Uri.parse('http://91weblessons.com/demo/api/mobile/api2.php');
  var url = Uri.parse('https://yogeshsalve.com/API/products/getcartorder.php');
  List getList = [];

  Future fetchData() async {
    http.Response response;
    response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        getList = json.decode(response.body);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        title: const Text('Place Order'),
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigation(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Card(
            color: Colors.white,
            child: Image.asset(
              "images/container.png",
              // fit: BoxFit.cover,

              height: size.height * 0.2,
              width: size.height * 0.65,
            ),
          ),
          // SizedBox(
          //   height: size.height * 0.01,
          // ),
          Card(
            color: Colors.orange[900],
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Click Below to Order",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Expanded(
          //   //   // flex: 1,

          //   child: Text(
          //     "Click Below to Buy",
          //     style: TextStyle(fontSize: 16.0),
          //   ),
          //   //   //   child: Container(
          //   //   //       alignment: Alignment.center,
          //   //   //       color: Colors.lightBlue,
          //   //   //       child: MyDropDown()),
          // ),
          Expanded(
              flex: 6,
              child: ListView.builder(
                itemCount: getList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    // alignment: Alignment.center,
                    // color: Colors.white,
                    child: Center(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.of(context).pushReplacement(
                        //       MaterialPageRoute(
                        //         builder: (BuildContext context) => BuyForm(),
                        //         settings:
                        //             RouteSettings(arguments: getList[index]),
                        //       ),
                        //     );
                        //   },
                        Card(
                          child: InkWell(
                            onTap: () => {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (BuildContext context) => BuyForm(),
                                  settings:
                                      RouteSettings(arguments: getList[index]),
                                ),
                              ),
                            },
                            child: Container(
                              height: size.height * 0.09,
                              // width: size.height * 0.65,
                              child: Text(
                                getList[index].toString(),
                                style: TextStyle(
                                  fontSize: 21.0,
                                ),
                              ),
                              padding: EdgeInsets.all(
                                15.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                  );
                },
              )),
        ],
      ),
    );
  }
}
