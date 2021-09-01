import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/drawer.dart';
//import 'package:orderapp/drawerpages/cart.dart';
//import 'package:orderapp/placeorder.dart';
//import 'package:orderapp/store/updatecart.dart';
import 'package:http/http.dart' as http;
import 'package:orderapp/store/buyform.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaceOrder extends StatefulWidget {
  @override
  _PlaceOrderState createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  final myController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? userName;
  List products = [];
  var delid = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    this.fetchProduct();
    getUserName();
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

  fetchProduct() async {
    var url = Uri.parse('https://yogeshsalve.com/API/products/cart.php');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var items = jsonDecode(response.body)['result'];
      //print(items);
      List products2 = [];
      for (var item in items) {
        if (item['email'] == userName) {
          print(item);
          products2.add(item);
        }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        title: const Text('Place Order'),
      ),
      //body: Container(),
      body: getBody(),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.orangeAccent[400],
        foregroundColor: Colors.black,
        onPressed: () {
          postData();
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
        Container(
          // child: Text("data"),
          child: Form(
            key: _formKey,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: Visibility(
                visible: false,
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
        ),
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
    // return ListView.builder(
    //     itemCount: products.length,
    //     itemBuilder: (context, int index) {
    //       // return Text("index $index");
    //       return getCard(products[index]);
    //     });
  }

  Widget getCard(item) {
    Size size = MediaQuery.of(context).size;
    // var id = item['id'];
    var productOrder = item['item_name'];
    var quantity = item['quantity'];
    //var available = item['available'];

    // List<String> names = [
    //   id.toString(),
    //   productOrder.toString(),
    //   quantity.toString(),
    //   available.toString(),
    // ];

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
