import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/drawer.dart';
import 'package:http/http.dart' as http;
//import 'package:orderapp/drawerpages/cart.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:orderapp/store/buyform.dart';

// import 'package:orderapp/store/dropdown.dart';

class PlaceOrder extends StatefulWidget {
  @override
  _PlaceOrderState createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  String? userName;
  final myController = TextEditingController();
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

  postData() async {
    try {
      var response = await http.post(
          Uri.parse("https://yogeshsalve.com/API/products/placeorder.php"),
          body: {
            "email": myController.text,
          });
      print(response.body);
      var error = jsonDecode(response.body)['error'];
      print(error);
      if (error == "200") {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Alert'),
            content: const Text('Order Placed Successfully..!!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BuyForm()));
                },
                child: const Text('Ok'),
              ),
            ],
          ),
        );
      } else if (error == "400") {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Alert'),
            content: const Text('Order Failed.. Try Again.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Ok'),
                child: const Text('Ok'),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Alert'),
            content: const Text('Order Not Found'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Ok'),
                child: const Text('Ok'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getUserName();
    fetchData();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        title: const Text('Place Order'),
      ),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.orangeAccent[400],
        foregroundColor: Colors.black,
        onPressed: () {
          postData();
          //print("Email Send Successfully...!!!");
        },
        icon: Icon(Icons.check_box),
        label: Text(
          "Send Email",
          style: TextStyle(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
          Form(
            key: _formKey,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: Visibility(
                visible: true,
                child: TextFormField(
                  readOnly: true,
                  controller: myController..text = userName!,
                  // controller: passwordText,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(labelText: 'Username'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getUserName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    userName = pref.getString('usernamekey')!;
    setState(() {});
  }
}
