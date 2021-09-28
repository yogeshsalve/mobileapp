import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/dashboard.dart';
// import 'package:orderapp/product/CategoryService.dart';
import 'package:http/http.dart' as http;
// import 'package:orderapp/splashscreen.dart';
// import 'package:orderapp/splashscreen.dart';
// import 'package:orderapp/homepage/top_bar.dart';
// import 'package:orderapp/homepage/topbar1.dart';
// import 'package:orderapp/homepage/topbar1.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CategoryProduct extends StatefulWidget {
  const CategoryProduct({Key? key}) : super(key: key);

  @override
  _CategoryProductState createState() => _CategoryProductState();
}

var myController1 = TextEditingController();
var myController2 = TextEditingController();
var myController3 = TextEditingController();
var myController4 = TextEditingController();
var myController5 = TextEditingController();
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
  List productsdisplay = [];
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
    var productName = pref.getString('product');
    // var map = new Map<String, dynamic>();
    // map['category'] = myController1.text;

    var url = Uri.parse('http://114.143.151.6:901/products-by-category');
    var response = await http.post(url, body: {
      "category": productName
    }, headers: {
      'Cookie': "session=cLmSPlij6RiMs2xCCvtWMQLVUE755gItrrfKoRNN290"
    });

    items3.clear();
    if (response.statusCode == 200) {
      var items2 = jsonDecode(response.body);
      // print(items2);
      for (var item2 in items2) {
        products2.add(item2);
        // products2.add(item2['itemno']);
        setState(() {
          items3 = products2;
          productsdisplay = products2;
        });
      }
    }

    // items3 = items1;

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
  final _cartkey = GlobalKey<FormState>();
  String productName = '';
  var a;
  @override
  Widget build(BuildContext context) {
    GlobalKey _toolTipKey1 = GlobalKey();
    GlobalKey _toolTipKey2 = GlobalKey();
    GlobalKey _toolTipKey3 = GlobalKey();
    GlobalKey _toolTipKey4 = GlobalKey();
    GlobalKey _toolTipKey5 = GlobalKey();
    var args = ModalRoute.of(context)!.settings.arguments.toString();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        // title: TopBar1(),
        title: Text(args),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Dashboard()),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: fetchProduct(),
      // ),
      body: Column(mainAxisAlignment: MainAxisAlignment.start,

          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // TopBar(),
            Container(
              padding: EdgeInsets.all(5),
              color: Colors.grey[350],
              height: size.height * 0.09,
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      margin: EdgeInsets.all(5),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: size.width * 0.7,
                            height: size.height * 0.06,
                            child: Center(
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Search APLORDER Item',
                                    icon:
                                        Icon(Icons.search, color: Colors.blue)),
                                onChanged: (text) {
                                  text.toLowerCase();
                                  setState(() {
                                    productsdisplay = items3.where((items3) {
                                      items3 = items3.toLowerCase();
                                      return items3.contains(text);
                                    }).toList();
                                  });
                                },
                              ),
                            ),
                          ),
                          Icon(Icons.camera_alt, color: Colors.blue)
                        ],
                      )),
                ],
              ),
            ),
            //-----------------
            SizedBox(
              width: double.infinity,
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      )),
                  height: 60.0,

                  //          child: GestureDetector(
                  //   onTap: () {
                  //     final dynamic tooltip = _toolTipKey.currentState;
                  //     tooltip.ensureTooltipVisible();
                  //   },
                  //   child: Tooltip(
                  //     key: _toolTipKey,
                  //     message: 'button is disabled',
                  //     child: Radio(
                  //       groupValue: null,
                  //       onChanged: null,
                  //       value: null,
                  //     ),
                  //   ),
                  // ),
                  //-----
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () {
                              final dynamic tooltip = _toolTipKey1.currentState;
                              tooltip.ensureTooltipVisible();
                            },
                            child: Tooltip(
                              key: _toolTipKey1,
                              message: 'No Stock',
                              child: Icon(
                                Icons.circle,
                                size: 40.0,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () {
                              final dynamic tooltip = _toolTipKey2.currentState;
                              tooltip.ensureTooltipVisible();
                            },
                            child: Tooltip(
                              key: _toolTipKey2,
                              message: '15 to 20 Days',
                              child: Icon(
                                Icons.circle,
                                size: 40.0,
                                color: Colors.yellow,
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () {
                              final dynamic tooltip = _toolTipKey3.currentState;
                              tooltip.ensureTooltipVisible();
                            },
                            child: Tooltip(
                              key: _toolTipKey3,
                              message: '10 to 15 Days',
                              child: Icon(
                                Icons.circle,
                                size: 40.0,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () {
                              final dynamic tooltip = _toolTipKey4.currentState;
                              tooltip.ensureTooltipVisible();
                            },
                            child: Tooltip(
                              key: _toolTipKey4,
                              message: '3 to 4 Days',
                              child: Icon(
                                Icons.circle,
                                size: 40.0,
                                color: Colors.blue[900],
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () {
                              final dynamic tooltip = _toolTipKey5.currentState;
                              tooltip.ensureTooltipVisible();
                            },
                            child: Tooltip(
                              key: _toolTipKey5,
                              message: 'Total Stock',
                              child: Icon(
                                Icons.circle,
                                size: 40.0,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),

                        // child: Center(
                        //     child: Text(
                        //   args,
                        //   style: TextStyle(
                        //       fontSize: 24.0,
                        //       fontWeight: FontWeight.bold,
                        //       color: Colors.white),
                        // )),
                      ])),
            ),
            //----------
            Form(
              key: _formKey,
              child: Visibility(
                visible: false,
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
                    decoration: InputDecoration(hoverColor: Colors.amber),
                  ),
                ),
              ),
            ),

            //--------------
            Expanded(
              child: new ListView.builder(
                itemCount: productsdisplay.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  getColor() {
                    if (productsdisplay[index]['stock-colour'] == "RED")
                      return Colors.red;
                    else if (productsdisplay[index]['stock-colour'] == "YELLOW")
                      return Colors.yellow;
                    else if (productsdisplay[index]['stock-colour'] == "ORANGE")
                      return Colors.orange;
                    else if (productsdisplay[index]['stock-colour'] == "BLUE")
                      return Colors.blue;
                    else if (productsdisplay[index]['stock-colour'] == "GREEN")
                      return Colors.green;
                  }

                  return InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Card(
                        elevation: 16.0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        child: Column(children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                    onTap: () =>
                                        Navigator.pop(context, 'Favourite'),
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 24.0,
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: new Text(
                                  productsdisplay[index]['desc'] +
                                      "\n" +
                                      "Item No: " +
                                      productsdisplay[index]['itemno'],
                                  // "\t" +
                                  // "Unit :" +
                                  // productsdisplay[index]['unit'],
                                  //--------

                                  //--------------
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),

                              //---
                              // new Text(

                              //   productsdisplay[index]['itemno'],
                              //   style: TextStyle(
                              //     fontSize: 20.0,
                              //   ),
                              //   textAlign: TextAlign.left,
                              // ),
                            ],
                          ),

                          // Icon(
                          //   Icons.favorite,
                          //   color: Colors.red,
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.circle,
                                  size: 40.0,
                                  color: getColor(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    //##############
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        // backgroundColor: Colors.lightBlue[50],

                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(32.0),
                                            ),
                                            side: BorderSide(
                                                color: Colors.red, width: 3.0)),

                                        title: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: InkWell(
                                                onTap: () => Navigator.pop(
                                                    context, 'Cancel'),
                                                child: CircleAvatar(
                                                  radius: 16.0,
                                                  backgroundColor: Colors.red,
                                                  child: Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                    size: 30.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: const Text(
                                                'ADD TO CART',
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),

                                        // content: const Text('Are You Sure..?'),
                                        actions: <Widget>[
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                // Text(
                                                //   "Description: \t" +
                                                //       productsdisplay[index]
                                                //           ['desc'],
                                                // ),
                                                // Text(
                                                //   "Item No: \t" +
                                                //       productsdisplay[index]
                                                //           ['itemno'],
                                                // ),
                                                //------------------
                                                Form(
                                                  key: _cartkey,
                                                  child: Visibility(
                                                    visible: true,
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: TextFormField(
                                                            readOnly: true,
                                                            controller: myController2
                                                              ..text =
                                                                  productsdisplay[
                                                                          index]
                                                                      ['desc'],
                                                            textAlign: TextAlign
                                                                .center,

                                                            // controller: passwordText,
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  "Description",
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        //---------------------
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: TextFormField(
                                                            readOnly: true,
                                                            controller: myController3
                                                              ..text =
                                                                  productsdisplay[
                                                                          index]
                                                                      [
                                                                      'itemno'],
                                                            textAlign: TextAlign
                                                                .center,

                                                            // controller: passwordText,
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  "Item No",
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        //--------
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: TextFormField(
                                                            readOnly: true,

                                                            controller: myController4
                                                              ..text =
                                                                  productsdisplay[
                                                                          index]
                                                                      ['unit'],
                                                            textAlign: TextAlign
                                                                .center,

                                                            // controller: passwordText,
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            decoration:
                                                                InputDecoration(
                                                              labelText: "UOM",
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                        //------------------------
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: TextFormField(
                                                            readOnly: true,
                                                            controller:
                                                                myController1
                                                                  ..text = args,
                                                            textAlign: TextAlign
                                                                .center,

                                                            // controller: passwordText,
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  "Quantity",
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                //----------form end -----
                                              ]),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                child: ElevatedButton(
                                                  child: Text('ADD'),
                                                  // onPressed: () {
                                                  //   print('Pressed');
                                                  // },
                                                  onPressed: () {},
                                                  style: ElevatedButton
                                                      .styleFrom(
                                                          primary:
                                                              Colors.deepPurple,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      60,
                                                                  vertical: 10),
                                                          textStyle: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          shape:
                                                              StadiumBorder()),
                                                ),
                                              ),
                                              // TextButton(
                                              //   onPressed: () {
                                              //     setState(() {
                                              //       // delid = id;
                                              //       // itemNo = itemno;
                                              //       // qty = quantity;
                                              //       // deleteData();
                                              //     });
                                              //   },
                                              //   child: const Text('OK'),
                                              // ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                    //##############
                                  },
                                  child: Icon(
                                    Icons.add_circle,
                                    color: Colors.black,
                                    size: 40.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ]),
    );
  }

  void getProductName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    productName = pref.getString('product')!;
    setState(() {});
  }
}
