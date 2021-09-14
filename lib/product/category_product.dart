import 'package:flutter/material.dart';
import 'package:orderapp/dashboard.dart';
// import 'package:orderapp/product/CategoryService.dart';
import 'package:http/http.dart' as http;
import 'package:orderapp/homepage/top_bar.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CategoryProduct extends StatefulWidget {
  const CategoryProduct({Key? key}) : super(key: key);

  @override
  _CategoryProductState createState() => _CategoryProductState();
}

var myController1 = TextEditingController();
var productName;
// var productName1 = productName;

class _CategoryProductState extends State<CategoryProduct> {
  String desc = "";
  String itemno = "";
  String stockcolour = "";
  String unit = "";
  var items = ['Please wait..'];
  List products2 = [];
  List items3 = [];
  List items1 = [];

  @override
  void initState() {
    super.initState();
    // this.getProductName();
    fetchProduct();

    // this.myController1.text = "";

    //callproductcategoryApi(context);
  }

  fetchProduct() async {
    // var requestBody = {
    //   'category': productName,
    // };
    final SharedPreferences pref = await SharedPreferences.getInstance();

    // var map = new Map<String, dynamic>();
    // map['category'] = myController1.text;

    var url = Uri.parse('http://114.143.151.6:901/products-by-category');
    var response =
        await http.post(url, body: {"category": pref.getString('product')});

    items3.clear();
    if (response.statusCode == 200) {
      var items2 = jsonDecode(response.body);
      // print(items2);
      for (var item2 in items2) {
        products2.add(item2['desc']);
        setState(() {
          items3 = products2;
        });
      }
    }

    // items3 = items1;
    print(myController1.text);
    print("after" + productName);
    print(productName);
    print(productName);
    print(productName);
    print(items3);
  }

// Future.delayed(Duration.zero, () async {
//   myFunction();
// });
  //------------------------- above wala working ------------------------

  // postData() async {
  //   //print('function executed successfully..!!');
  //   try {
  //     var response = await http.post(
  //         Uri.parse("http://114.143.151.6:901/products-by-category"),
  //         body: {
  //           "category": myController1.text,
  //         });
  //     print(response.body);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  //--------------------------------------------------------------------------

  // callproductcategoryApi(BuildContext context) async {
  //   final service = CategoryServices();
  //   await Future.delayed(Duration(seconds: 1));

  //   service.apiCallproductcategory(
  //     {
  //       "category": myController1.text,
  //     },
  //   ).then((value) {
  //     print(value.status);
  //     // print(value.data[0]["desc"]);

  //     // if (value.status == 200) {
  //     //   setState(() {
  //     //     desc = value.desc.toString();
  //     //     // print(desc);
  //     //     // itemno = value.itemno.toString();
  //     //     // stockcolour = value.stockcolour.toString();
  //     //     // unit = value.unit.toString();
  //     //   });
  //     //   // Navigator.push(
  //     //   //     context, MaterialPageRoute(builder: (context) => Dashboard()));
  //     // } else {}
  //   });
  // }

  final _formKey = GlobalKey<FormState>();
  String productName = '';
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        title: const Text('Category Products Grid'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Dashboard()),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: fetchProduct(),
      // ),
      body: Column(mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TopBar(),
            //----------
            Form(
              key: _formKey,
              child: Visibility(
                visible: true,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: true,

                    controller: myController1..text = args,
                    textAlign: TextAlign.center,

                    // controller: passwordText,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    // decoration: InputDecoration(labelText: "category"),
                  ),
                ),
              ),
            ),
            //--------------
            Expanded(
              child: new ListView.builder(
                itemCount: items3.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: new Text(
                                    items3[index].toString(),
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // Icon(
                            //   Icons.favorite,
                            //   color: Colors.red,
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.add_circle,
                                    color: Colors.green,
                                    size: 40.0,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            //---------------

            //----------------

            //------------------------------

            //------------------------------
          ]),
    );
  }

  void getProductName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    productName = pref.getString('product')!;
    setState(() {});
  }
}
