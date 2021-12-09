import 'dart:convert';
// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/dashboard.dart';
// import 'package:orderapp/drawer.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;

import 'package:orderapp/mobile.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PendingOrder extends StatefulWidget {
  @override
  _PendingOrderState createState() => _PendingOrderState();
}

class _PendingOrderState extends State<PendingOrder> {
  List subjects = ['1', '2', '3', '4', '5'];
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

    var url = Uri.parse('http://114.143.151.6:901/order-pending-list');
    var response = await http.post(url,
        body: {"limit": "500", "page": "1"}, headers: {'Cookie': userCookie});

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.blueAccent[700],
        backgroundColor: Colors.grey[850],
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: size.width * 0.5,
                      child: Text("Pending Order"),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      //width: size.width * 0.5,
                      child: IconButton(
                        icon: Icon(Icons.file_download, color: Colors.white),
                        onPressed: () {
                          _createPDF();
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

      //body: Container(),
      body: Scrollbar(
        thickness: 5,
        isAlwaysShown: true,
        radius: Radius.circular(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.blue,
                height: size.height * 0.03,
              ),
              // const Divider(
              //   // height: 20,
              //   thickness: 5,
              //   indent: 0,
              //   endIndent: 0,
              //   color: Colors.grey,
              // ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: MaterialStateColor.resolveWith(
                      (states) => Colors.grey.shade400),
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        'Item No',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    // DataColumn(
                    //   label: Text(
                    //     'Action',
                    //     style: TextStyle(fontStyle: FontStyle.italic),
                    //   ),
                    // ),
                    DataColumn(
                      label: Text(
                        'Customer Item No.',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Description',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Pending Qty',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Order No.',
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
                        'Customer Order No.',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Rate',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Price UOM',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),

                    DataColumn(
                      label: Text(
                        'Quantity Order',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Total Quantity Order',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Shipped Qty',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Total Shipped Qty',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Balance Qty',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Total Balance Qty',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Commited Qty',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                  // for ( 1==1)

                  rows: <DataRow>[
                    for (var p in products)
                      DataRow(
                        cells: <DataCell>[
                          DataCell(
                            Text(
                              p["item"].toString(),
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                          DataCell(Text(p["customer_item_no"].toString())),
                          DataCell(Text(p["description"].toString())),
                          DataCell(Text(p["quantity_balance"].toString())),
                          DataCell(
                              Text(p["quantity_balance_total"].toString())),
                          DataCell(Text(p["order_number"].toString())),
                          DataCell(Text(p["order_date"].toString())),
                          DataCell(Text(p["customer_order_number"].toString())),
                          DataCell(Text(p["unit_price"].toString())),
                          DataCell(Text(p["price_uom"].toString())),
                          DataCell(Text(p["quantity_ordered"].toString())),
                          DataCell(
                              Text(p["quantity_ordered_total"].toString())),
                          DataCell(Text(p["quantity_shipped"].toString())),
                          DataCell(
                              Text(p["quantity_shipped_total"].toString())),
                          DataCell(Text(p["quantity_balance"].toString())),
                          DataCell(Text(p["quantity_commit"].toString())),
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

  Future<void> _createPDF() async {
    PdfDocument document = PdfDocument();
    //final page = document.pages.add();
    // page.graphics
    //     .drawString("Welcome", PdfStandardFont(PdfFontFamily.helvetica, 30));

    // *******************************
    PdfGrid grid = PdfGrid();
    grid.columns.add(count: 8);
    grid.headers.add(1);
    PdfGridRow header = grid.headers[0];
    header.cells[0].value = "Expected Date";
    header.cells[1].value = "On Hold";
    header.cells[2].value = "Order Date";
    header.cells[3].value = "Order Number";
    header.cells[4].value = "Order Total";
    header.cells[5].value = "Order Uniq";
    header.cells[6].value = "Po Number";
    header.cells[7].value = "Reference";
    // *******************************
    for (var p in products) {
      PdfGridRow row = grid.rows.add();
      row.cells[0].value = p["expected_date"].toString();
      row.cells[1].value = p["on_hold"].toString();
      row.cells[2].value = p["order_date"].toString();
      row.cells[3].value = p["order_number"].toString();
      row.cells[4].value = p["order_total"].toString();
      row.cells[5].value = p["orduniq"].toString();
      row.cells[6].value = p["po_number"].toString();
      row.cells[7].value = p["reference"].toString();
    }

    grid.draw(
        page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));
    List<int> bytes = document.save();
    document.dispose();
    saveAndLaunchFile(bytes, 'Order Details Report.pdf');
  }
}
