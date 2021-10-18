import 'dart:convert';
// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/drawer.dart';
import 'package:orderapp/placeorder.dart';
import 'package:orderapp/store/updatecart.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  String? userName;
  List products = [];
  var delid = "";
  var itemNo = "";
  var qty = "";
  String userCookie = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    this.fetchProduct();
    getUserName();
  }

  fetchProduct() async {
    // var url = Uri.parse('https://yogeshsalve.com/API/products/cart.php');

    // ---------------token-------------------
    final SharedPreferences pref = await SharedPreferences.getInstance();
    userCookie = pref.getString('userCookiekey')!;
    setState(() {});

    print(userCookie);

    // -------------token ------------------------

    var url = Uri.parse('http://114.143.151.6:901/cart-list');
    var response = await http.get(url, headers: {'Cookie': userCookie});

    if (response.statusCode == 200) {
      var items = jsonDecode(response.body);
      // print(items);
      List products2 = [];
      for (var item in items) {
        print(item);
        products2.add(item);
      }
      print(products);
      setState(() {
        products = products2;
      });
    } else
      setState(() {
        products = [];
      });
  }

  deleteData() async {
    try {
      var response = await http.post(
          Uri.parse("https://yogeshsalve.com/API/products/deletecart.php"),
          body: {
            "id": delid,
            "Item_no": itemNo,
            "quantity": qty,
          });
      print(response.body);
      if (response.statusCode == 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Cart()));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        title: const Text('Cart'),
      ),
      //body: Container(),
      body: getBody(),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.orangeAccent[400],
        foregroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      (products.length == 0 ? Cart() : PlaceOrder())));
        },
        icon: Icon(Icons.check_box),
        label: Text(
          "Checkout",
          style: TextStyle(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigation(),
    );
  }

  Widget getBody() {
    // List items = [];
    return Column(
      children: <Widget>[
        // Container(
        //   child: Text((products.length == 0 ? "Disabled" : "Enabled")),
        // ),
        Expanded(
          child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, int index) {
                // return Text("index $index");
                return getCard(products[index]);
              }),
        )
      ],
    );
  }

  Widget getCard(item) {
    Size size = MediaQuery.of(context).size;
    var id = item['id'];
    var productOrder = item['item_name'];
    var quantity = item['quantity'];
    var available = item['available'];
    var itemno = item['Item_no'];

    List<String> names = [
      id.toString(),
      productOrder.toString(),
      quantity.toString(),
      available.toString(),
    ];

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Card(
        color: Colors.indigo[100],
        child: InkWell(
          onTap: () => {
            // Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(
            //     builder: (BuildContext context) => UpdateCart(),
            //   ),
            // ),
          },
          // elevation: 50,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: ListTile(
              title: Row(
                children: <Widget>[
                  SizedBox(width: size.width * 0.03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Product :" + " " + productOrder.toString(),
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Quantity :" + " " + quantity,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
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
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        UpdateCart(value: names)));
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
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Alert'),
                                    content: const Text('Are You Sure..?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            delid = id;
                                            itemNo = itemno;
                                            qty = quantity;
                                            deleteData();
                                          });
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              },
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

  void getUserName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    userName = pref.getString('usernamekey')!;
    setState(() {});
  }
}
