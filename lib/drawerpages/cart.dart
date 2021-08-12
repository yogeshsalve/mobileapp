//import 'dart:js';

//import 'dart:js';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/drawer.dart';
import 'package:orderapp/store/updatecart.dart';
//import 'package:orderapp/splashscreen.dart';

import 'package:http/http.dart' as http;

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List products = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    this.fetchProduct();
  }

  fetchProduct() async {
    var url = Uri.parse('http://yogeshsalve.com/API/addtocart.php');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var items = jsonDecode(response.body)['result'];
      // print(items);
      setState(() {
        products = items;
      });
    } else
      // print(response.body);
      setState(() {
        products = [];
      });
  }

  // List getList = [];

  // Future fetchData() async {
  //   http.Response response;
  //   response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     setState(() {
  //       getList = json.decode(response.body);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        title: const Text('Cart'),
      ),
      body: getBody(),
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigation(),
    );
  }

  Widget getBody() {
    // List items = [];
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, int index) {
          // return Text("index $index");
          return getCard(products[index]);
        });
  }

  Widget getCard(item) {
    Size size = MediaQuery.of(context).size;
    var productOrder = item['item_name'];
    // var available = item['available'];
    // var uom = item['uom'];
    var quantity = item['quantity'];
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Card(
        child: InkWell(
          onTap: () => {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) => UpdateCart(),
              ),
            ),
          },
          // elevation: 50,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: ListTile(
              title: Row(
                children: <Widget>[
                  // Container(
                  //   width: 60,
                  //   height: 60,
                  //   decoration: BoxDecoration(
                  //       color: primary,
                  //       borderRadius: BorderRadius.circular(60 / 2),
                  //       image: DecorationImage(
                  //           fit: BoxFit.cover,
                  //           image: NetworkImage(
                  //               "https://images.unsplash.com/photo-1628038340278-9818521002ac?ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDl8dG93SlpGc2twR2d8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"))),
                  // ),
                  SizedBox(width: size.width * 0.03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Item :" + " " + productOrder.toString(),
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Text(
                      //   available.toString(),
                      //   style: TextStyle(fontSize: 17),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Text(
                      //   uom.toString(),
                      //   style: TextStyle(fontSize: 17),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      Text(
                        quantity.toString(),
                        style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            SizedBox(
                              width: 120,
                            ),
                            ElevatedButton.icon(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            UpdateCart()));
                              },
                              label: Text('Edit'),
                              style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                primary: Colors.green,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ElevatedButton.icon(
                              icon: Icon(Icons.delete),
                              onPressed: () {},
                              label: Text('Delete'),
                              style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                primary: Colors.red,
                              ),
                            )
                          ]),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
