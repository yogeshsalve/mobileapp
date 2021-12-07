import 'dart:convert';
// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/dashboard.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:orderapp/product/product_detail.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  String ordno = "";
  String? userName;
  List products = [];
  var recordid = "";
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
    // ---------------token-------------------
    final SharedPreferences pref = await SharedPreferences.getInstance();
    userCookie = pref.getString('userCookiekey')!;
    setState(() {});

    //print(userCookie);

    // -------------token ------------------------

    var url = Uri.parse('http://114.143.151.6:901/cart-list');
    var response = await http.get(url, headers: {'Cookie': userCookie});
    print(response.body);
    if (response.statusCode == 200) {
      var items = jsonDecode(response.body);
      // print(items);
      List products2 = [];
      for (var item in items) {
        //   print(item);
        products2.add(item);
      }
      // print(products2);
      setState(() {
        products = products2;
      });
    } else
      setState(() {
        products = [];
      });

    //print(products);
  }

//###########################################
  emptyCart() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    userCookie = pref.getString('userCookiekey')!;
    setState(() {});
    print(userCookie);
// -------------token ------------------------
    var url = Uri.parse("http://114.143.151.6:901/cart-empty");
    // ignore: unused_local_variable
    var response = await http.post(url, headers: {'Cookie': userCookie});
    //print(response.body);
  }

  //###########################################
  deleteData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    userCookie = pref.getString('userCookiekey')!;
    setState(() {});
    print(userCookie);
// -------------token ------------------------
    var url = Uri.parse("http://114.143.151.6:901/cart-delete");
    // ignore: unused_local_variable
    var response = await http.post(url, body: {
      "record_id": recordid,
    }, headers: {
      'Cookie': userCookie
    });
    print(response.body);
  }

  //------------------------place order api-----------------------
  postData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
// ---------------token-------------------
// final SharedPreferences pref = await SharedPreferences.getInstance();
    userCookie = pref.getString('userCookiekey')!;
    setState(() {});
    print(userCookie);
// -------------token ------------------------
    var url = Uri.parse("http://aplhome.info:701/PlaceOrderApi/api/values");
    var response = await http.post(url, body: {
      //----------------------------------------
      "IDCUST": userName,
      "NAMECUST": " ",
      "OrdNumber": "",
      "SNAMECUST": "",
      "EMAIL1": "",
      "TEXTSTRE1": "",
      "TEXTSTRE2": "",
      "TEXTSTRE3": "",
      "TEXTSTRE4": "",
      "NAMECITY": "",
      "CODESTTE": "",
      "CODEPSTL": "",
      "CODECTRY": "",
      "NAMECTAC": "",
      "STEXTSTRE1": "",
      "STEXTSTRE2": "",
      "STEXTSTRE3": "",
      "STEXTSTRE4": "",
      "SNAMECITY": "",
      "SCODESTTE": "",
      "SCODEPSTL": "",
      "SCODECTRY": "",
      "SNAMECTAC": "",
      "TEXTPHON1": "",
      "LOCATION": "P",
      "PONUMBER": "",
      "ORDERREF": "",
      "ORDDATE": "2021-10-19",
      "ORDCOMM": "",
      "ORDREMK": "",
      "ORDEMAIL": "",
      "PRIMSHIPTO": "",
      "RepError": "",
      "OrderLineItems[0][ITEMNO]": products[0]['itemno'].toString(),
      "OrderLineItems[0][LineDiscount]": "0",
      "OrderLineItems[0][PRIUNTPRC]": "0",
      "OrderLineItems[0][QUANTITY]": products[0]['quantity'].toString(),
      "OrderLineItems[0][STOCKUNIT]": products[0]['unit'].toString(),
      "OrderLineItems[0][UnitPrice]": "0",
    }, headers: {
      'Cookie': userCookie
    });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var items = jsonDecode(response.body);
      if (items["OrdNumber"] != null) {
        setState(() {
          ordno = items["OrdNumber"].toString();
        });
        emptyCart();
      }
      Size size = MediaQuery.of(context).size;
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Column(children: [
            Center(
              child:
                  // Image.network(
                  //   'https://flutter-examples.com/wp-content/uploads/2019/12/android_icon.png',
                  Container(
                margin: EdgeInsets.all(10),
                width: size.width * 0.15,
                height: size.height * 0.1,
                decoration: BoxDecoration(
                  // shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('images/orderplaced.png'),
                      fit: BoxFit.fill),
                ),
              ),
            ),

            // Text('Order placed successfully..!!')
          ]),
          content: Text(
            "Order placed!!  \n Order no: " + ordno.toString(),
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Dashboard())),
              child: const Text('Continue Shopping'),
            ),
            TextButton(
              onPressed: () {},
              // =>
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => Cart())),
              child: const Text('View all Orders'),
            ),
          ],
        ),
      );
    }
  }

  //-------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: size.width * 0.5,
                      child: Text("Cart"),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      child: IconButton(
                        icon: Icon(Icons.delete, color: Colors.white),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Alert'),
                              content: const Text(
                                  'Are You Sure you want to delete all cart items?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    emptyCart();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Cart()));
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ]),
        leading: BackButton(
            color: Colors.white,
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Dashboard()))),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepOrange,
        label: Text('PLACE ORDER'),
        onPressed: () {
          postData();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 16.0,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Icon(Icons.list),
                          trailing: InkWell(
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onTap: () {
                              //*********************** */
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
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
                                          recordid = products[index]['recordid']
                                              .toString();
                                        });
                                        deleteData();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Cart()));
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                              //*********************** */
                            },
                          ),
                          title: Text(
                            "PRODUCT :" +
                                " " +
                                products[index]['desc'].toString(),
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          subtitle: Text(
                            "Quantity :" +
                                " " +
                                products[index]['quantity'].toString() +
                                "\n" +
                                products[index]['itemno'].toString(),
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        )),
                  );
                }),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }

  void getUserName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    userName = pref.getString('usernamekey')!;
    setState(() {});
  }
}
