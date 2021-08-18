import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/drawer.dart';
import 'package:orderapp/placeorder.dart';
import 'package:orderapp/store/updatecart.dart';
import 'package:http/http.dart' as http;

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List products = [];
  var delid = "";

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    this.fetchProduct();
  }

  fetchProduct() async {
    var url = Uri.parse('https://yogeshsalve.com/API/products/cart.php');
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

  deleteData() async {
    try {
      var response = await http.post(
          Uri.parse("https://yogeshsalve.com/API/products/deletecart.php"),
          body: {
            "id": delid,
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
              context, MaterialPageRoute(builder: (context) => PlaceOrder()));
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
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, int index) {
          // return Text("index $index");
          return getCard(products[index]);
        });
  }

  Widget getCard(item) {
    Size size = MediaQuery.of(context).size;
    var id = item['id'];
    var productOrder = item['item_name'];
    var quantity = item['quantity'];
    var available = item['available'];

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
                                            deleteData();
                                          });
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                                //print(names[0]);
                                // setState(() {
                                //   delid = id;
                                //   deleteData();
                                // });
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
}
