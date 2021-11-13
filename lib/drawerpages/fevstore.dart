import 'dart:convert';
// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/dashboard.dart';
// import 'package:orderapp/drawer.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
// import 'package:orderapp/product/product_detail.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

class FavStore extends StatefulWidget {
  @override
  _FavStoreState createState() => _FavStoreState();
}

class _FavStoreState extends State<FavStore> {
  List products = [
    {
      "AUDTDATE": "20120707",
      "AUDTORG": "AGDATA",
      "AUDTTIME": "15252263",
      "AUDTUSER": "ADMIN",
      "C10": "2063502.0000",
      "C11": "170247.0000",
      "C12": "170247.0000",
      "C13": "1",
      "C5": "10",
      "C6": "0.0000",
      "C7": "1987550.0000",
      "C8": "133278.0000",
      "C9": "0.0000",
      "CONVERSION": "150.000000",
      "DESC": "HEX NUTS \"APL\"SS (304) M 12",
      "FMTITEMNO": "09340212",
      "ITEM": "09340212",
      "ITEMNO": "09340212",
      "ITEMNO1": "09340212",
      "ITEMNO2": null,
      "ITEMNO3": null,
      "ITEMNO4": null,
      "ITEMNO5": null,
      "ITEMNO6": "09340212",
      "ITEMNO7": "09340212",
      "OPTFIELD": null,
      "OPTFIELD1": null,
      "OPTFIELD2": null,
      "OPTFIELD3": null,
      "UNIT": "BOX",
      "VALUE": null,
      "VALUE1": null,
      "VALUE2": null,
      "VALUE3": null,
      "stockColour": "ORANGE"
    }
  ];
  String? userName;
  //List products = [];
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

    var url = Uri.parse('http://114.143.151.6:901/favorite-products');
    var response = await http.post(url,
        body: {"limit": "5", "page": "1"}, headers: {'Cookie': userCookie});

    if (response.statusCode == 404) {
      var items = jsonDecode(products.toString());
      //var items = jsonDecode(response.body);
      //print(items);
      products.clear();
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
    print(response.statusCode);
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
        backgroundColor: Colors.blueAccent[700],
        title: const Text('Favorite Products'),
        leading: BackButton(
            color: Colors.white,
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Dashboard()))),
      ),
      //body: Container(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (products.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Container(
                    child: Center(
                      child: Text(
                        'Sorry, No Data Found..!!',
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(color: Colors.black12, spreadRadius: 2),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.redAccent,
                    ),
                    padding: EdgeInsets.all(1),
                    //color: Colors.yellow,
                    height: size.height * 0.07,
                    width: size.width * 1,
                  ),
                  // child: SizedBox(
                  //   child: CircularProgressIndicator(),
                  //   width: 60,
                  //   height: 60,
                  // ),
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => ProductDetail(
                      //             item: products[index]['itemno'],
                      //             stockstatus: products[index]['stock-colour'],
                      //             unitconv: "",
                      //             todo: products[index]['unitconv'],
                      //           )

                      //       ),
                      // );
                    },
                    child: Card(
                      elevation: 16.0,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Icon(Icons.list),
                            title: Text(
                              products[index]["DESC"],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            subtitle: Text(
                              "item no :" +
                                  " " +
                                  products[index]['ITEM'].toString() +
                                  "\n" +
                                  "unit :" +
                                  " " +
                                  products[index]['UNIT'].toString() +
                                  "\n" +
                                  "stock status :" +
                                  " " +
                                  products[index]['stockColour'].toString() +
                                  "\n",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          )),
                    ),
                  );
                }),
          ),
        ],
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
