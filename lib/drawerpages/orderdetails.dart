import 'dart:convert';
// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/dashboard.dart';
// import 'package:orderapp/drawer.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetails extends StatefulWidget {
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
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
    // ---------------token-------------------
    final SharedPreferences pref = await SharedPreferences.getInstance();
    userCookie = pref.getString('userCookiekey')!;
    setState(() {});

    print(userCookie);

    // -------------token ------------------------

    var url = Uri.parse('http://114.143.151.6:901/order-inquiry-list');
    var response = await http.post(url,
        body: {"limit": "50", "page": "1"}, headers: {'Cookie': userCookie});

    if (response.statusCode == 200) {
      var items = jsonDecode(response.body);
      print(items);
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

    print(products);
  }

  // deleteData() async {
  //   try {
  //     var response = await http.post(
  //         Uri.parse("https://yogeshsalve.com/API/products/deletecart.php"),
  //         body: {
  //           "id": delid,
  //           "Item_no": itemNo,
  //           "quantity": qty,
  //         });
  //     print(response.body);
  //     if (response.statusCode == 200) {
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => Cart()));
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        title: const Text('Order Details List'),
        leading: BackButton(
            color: Colors.white,
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Dashboard()))),
      ),
      //body: Container(),
      body: Scrollbar(
        thickness: 8,
        isAlwaysShown: true,
        radius: Radius.circular(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: MaterialStateColor.resolveWith(
                      (states) => Colors.orangeAccent),
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        'Expected Date',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'On Hold',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Order Date',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Order Number',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Order Total',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Orduniq',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'PO Number',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Reference',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                  // for ( 1==1)

                  rows: <DataRow>[
                    for (var p in products)
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text(p["expected_date"].toString())),
                          DataCell(Text(p["on_hold"].toString())),
                          DataCell(Text(p["order_date"].toString())),
                          DataCell(Text(p["order_number"].toString())),
                          DataCell(Text(p["order_total"].toString())),
                          DataCell(Text(p["orduniq"].toString())),
                          DataCell(Text(p["po_number"].toString())),
                          DataCell(Text(p["reference"].toString())),
                        ],
                      ),
                  ],
                ),
              ),
              // Expanded(
              //   child: ListView.builder(
              //       itemCount: products.length,
              //       itemBuilder: (BuildContext context, int index) {
              //         return InkWell(
              //           onTap: () {},
              //           child: Card(
              //             elevation: 16.0,
              //             child: Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: ListTile(
              //                   leading: Icon(Icons.list),
              //                   title: Text(
              //                     "expected_date :" +
              //                         " " +
              //                         products[index]['expected_date'].toString(),
              //                     style:
              //                         TextStyle(color: Colors.black, fontSize: 15),
              //                   ),
              //                   subtitle: Text(
              //                     "on_hold :" +
              //                         " " +
              //                         products[index]['on_hold'].toString() +
              //                         "\n" +
              //                         "order_date :" +
              //                         " " +
              //                         products[index]['order_date'].toString() +
              //                         "\n" +
              //                         "order_number :" +
              //                         " " +
              //                         products[index]['order_number'].toString() +
              //                         "\n" +
              //                         "order_total :" +
              //                         " " +
              //                         products[index]['order_total'].toString() +
              //                         "\n" +
              //                         "orduniq :" +
              //                         " " +
              //                         products[index]['orduniq'].toString() +
              //                         "\n" +
              //                         "po_number :" +
              //                         " " +
              //                         products[index]['po_number'].toString() +
              //                         "\n" +
              //                         "reference :" +
              //                         " " +
              //                         products[index]['reference'].toString() +
              //                         "\n",
              //                     style:
              //                         TextStyle(color: Colors.black, fontSize: 15),
              //                   ),
              //                 )),
              //           ),
              //         );
              //       }),
              // ),
            ],
          ),
        ),
      ),

      // drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigation(),
    );
  }

  // Widget getBody() {
  //   // List items = [];
  //   return Column(
  //     children: <Widget>[
  //       // Container(
  //       //   child: Text((products.length == 0 ? "Disabled" : "Enabled")),
  //       // ),
  //       Expanded(
  //         child: ListView.builder(
  //             itemCount: products.length,
  //             itemBuilder: (context, int index) {
  //               // return Text("index $index");
  //               return getCard(products[index]);
  //             }),
  //       )
  //     ],
  //   );
  // }

  // Widget getCard(item) {
  //   Size size = MediaQuery.of(context).size;
  //   // var cartid = item['cartid'];
  //   // var productOrder = item['desc'];
  //   // var price = item['price'];
  //   var quantity = item['quantity'];
  //   // var count = item['count'];

  //   // List<String> names = [
  //   //   cartid.toString(),
  //   //   // price.toString(),
  //   //   quantity.toString(),
  //   //   // count.toString(),
  //   // ];

  //   return Padding(
  //     padding: const EdgeInsets.all(6.0),
  //     child: Card(
  //       color: Colors.indigo[100],
  //       child: InkWell(
  //         onTap: () => {
  //           // Navigator.of(context).pushReplacement(
  //           //   MaterialPageRoute(
  //           //     builder: (BuildContext context) => UpdateCart(),
  //           //   ),
  //           // ),
  //         },
  //         // elevation: 50,
  //         child: Padding(
  //           padding: const EdgeInsets.all(0.0),
  //           child: ListTile(
  //             title: Row(
  //               children: <Widget>[
  //                 SizedBox(width: size.width * 0.03),
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: <Widget>[
  //                     SizedBox(
  //                       height: 20,
  //                     ),
  //                     // Text(
  //                     //   "Product :" + " " + productOrder.toString(),
  //                     //   style: TextStyle(
  //                     //       fontSize: 15, fontWeight: FontWeight.bold),
  //                     // ),
  //                     SizedBox(
  //                       height: 10,
  //                     ),
  //                     Text(
  //                       "Quantity :" + " " + quantity,
  //                       style: TextStyle(
  //                           fontSize: 17, fontWeight: FontWeight.bold),
  //                     ),
  //                     SizedBox(
  //                       height: 10,
  //                     ),
  //                     Row(
  //                         mainAxisAlignment: MainAxisAlignment.end,
  //                         children: <Widget>[
  //                           SizedBox(
  //                             width: 120,
  //                           ),
  //                           // ElevatedButton.icon(
  //                           //   icon: Icon(Icons.edit),
  //                           //   onPressed: () {
  //                           //     Navigator.of(context).push(MaterialPageRoute(
  //                           //         builder: (context) =>
  //                           //             UpdateCart(value: names)));
  //                           //   },
  //                           //   label: Text('Edit'),
  //                           //   style: ElevatedButton.styleFrom(
  //                           //     shape: StadiumBorder(),
  //                           //     primary: Colors.green,
  //                           //   ),
  //                           // ),
  //                           SizedBox(
  //                             width: 20,
  //                           ),
  //                           ElevatedButton.icon(
  //                             icon: Icon(Icons.delete),
  //                             onPressed: () {
  //                               showDialog(
  //                                 context: context,
  //                                 builder: (BuildContext context) =>
  //                                     AlertDialog(
  //                                   title: const Text('Alert'),
  //                                   content: const Text('Are You Sure..?'),
  //                                   actions: <Widget>[
  //                                     TextButton(
  //                                       onPressed: () =>
  //                                           Navigator.pop(context, 'Cancel'),
  //                                       child: const Text('Cancel'),
  //                                     ),
  //                                     // TextButton(
  //                                     //   onPressed: () {
  //                                     //     setState(() {
  //                                     //       delid = id;
  //                                     //       itemNo = itemno;
  //                                     //       qty = quantity;
  //                                     //       deleteData();
  //                                     //     });
  //                                     //   },
  //                                     //   child: const Text('OK'),
  //                                     // ),
  //                                   ],
  //                                 ),
  //                               );
  //                             },
  //                             label: Text('Delete'),
  //                             style: ElevatedButton.styleFrom(
  //                               shape: StadiumBorder(),
  //                               primary: Colors.red,
  //                             ),
  //                           )
  //                         ]),
  //                   ],
  //                 )
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void getUserName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    userName = pref.getString('usernamekey')!;
    setState(() {});
  }
}
