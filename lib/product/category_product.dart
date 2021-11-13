import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:orderapp/product/product_detail.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryProduct extends StatefulWidget {
  const CategoryProduct({Key? key}) : super(key: key);

  @override
  _CategoryProductState createState() => _CategoryProductState();
}

class Todo {
  final String title;
  final String description;

  const Todo(this.title, this.description);
}

final todos = [];

var myController1 = TextEditingController();
var myController2 = TextEditingController();
var myController3 = TextEditingController();
var myController4 = TextEditingController();
var myController5 = TextEditingController();
var productName;
// var productName1 = productName;
var myController11 = TextEditingController();
var myController22 = TextEditingController();
var myController33 = TextEditingController();
var myController44 = TextEditingController();
var myController55 = TextEditingController();

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
  String userCookie = '';
  // ignore: non_constant_identifier_names
  DateTime pre_backpress = DateTime.now();
  @override
  void initState() {
    super.initState();
    // this.getProductName();
    fetchProduct();
  }

  fetchProduct() async {
    // var requestBody = {
    //   'category': productName,
    // };
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var productName = pref.getString('product');
    // var map = new Map<String, dynamic>();
    // map['category'] = myController1.text;

    // ---------------token-------------------
    // final SharedPreferences pref = await SharedPreferences.getInstance();
    userCookie = pref.getString('userCookiekey')!;
    setState(() {});

    print(userCookie);

    // -------------token ------------------------

    var url = Uri.parse('http://114.143.151.6:901/products-by-category');
    var response = await http.post(url,
        body: {"category": productName, "limit": "10000"},
        headers: {'Cookie': userCookie});

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

  final _formKey = GlobalKey<FormState>();
  //final _formKey2 = GlobalKey<FormState>();
  // final _cartkey = GlobalKey<FormState>();
  String productName = '';
  var a;
  @override
  Widget build(BuildContext context) {
    // GlobalKey _toolTipKey1 = GlobalKey();
    // GlobalKey _toolTipKey2 = GlobalKey();
    // GlobalKey _toolTipKey3 = GlobalKey();
    // GlobalKey _toolTipKey4 = GlobalKey();
    // GlobalKey _toolTipKey5 = GlobalKey();
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

      body: WillPopScope(
        onWillPop: () async {
          final timegap = DateTime.now().difference(pre_backpress);
          final cantExit = timegap >= Duration(seconds: 2);
          pre_backpress = DateTime.now();
          if (cantExit) {
            //show snackbar
            final snack = SnackBar(
              content: Text('Press Back button again to Exit'),
              duration: Duration(seconds: 2),
            );
            ScaffoldMessenger.of(context).showSnackBar(snack);
            return false; // false will do nothing when back press
          } else {
            return true; // true will exit the app
          }
        },
        child: Column(mainAxisAlignment: MainAxisAlignment.start,

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
                                      icon: Icon(Icons.search,
                                          color: Colors.blue)),
                                  onChanged: (text) {
                                    text.toLowerCase();
                                    setState(() {
                                      productsdisplay = items3.where((items3) {
                                        items3 = items3.toString();
                                        items3 = items3.toLowerCase();
                                        return items3.contains(text.toString());
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
                      height: 35.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 15.0,
                                      color: Colors.blue[900],
                                    ),
                                    Text(
                                      " 3 to 4 Days",
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 15.0,
                                      color: Colors.orange,
                                    ),
                                    Text(
                                      " 10 to 15 Days",
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 15.0,
                                      color: Colors.yellow,
                                    ),
                                    Text(
                                      " 15 to 20 Days",
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 15.0,
                                      color: Colors.red,
                                    ),
                                    Text(
                                      " No Stock",
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                              ]),
                          // Row(
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     children: [
                          //       // Row(
                          //       //   children: [
                          //       //     Icon(
                          //       //       Icons.circle,
                          //       //       size: 15.0,
                          //       //       color: Colors.yellow,
                          //       //     ),
                          //       //     Text(
                          //       //       " 15 to 20 Days",
                          //       //       style: TextStyle(fontSize: 12),
                          //       //     )
                          //       //   ],
                          //       // ),
                          //       // Row(
                          //       //   children: [
                          //       //     Icon(
                          //       //       Icons.circle,
                          //       //       size: 15.0,
                          //       //       color: Colors.red,
                          //       //     ),
                          //       //     Text(
                          //       //       " No Stock",
                          //       //       style: TextStyle(fontSize: 12),
                          //       //     )
                          //       //   ],
                          //       // ),
                          //       Row(
                          //         children: [
                          //           Icon(
                          //             Icons.circle,
                          //             size: 15.0,
                          //             color: Colors.green,
                          //           ),
                          //           Text(
                          //             "  Total Stock",
                          //             style: TextStyle(fontSize: 12),
                          //           )
                          //         ],
                          //       ),
                          //     ]),
                        ],
                      ))),
              //-----------------
              // SizedBox(
              //   width: double.infinity,
              //   child: Container(
              //       decoration: BoxDecoration(
              //           color: Colors.blue,
              //           border: Border.all(
              //             color: Colors.black,
              //             width: 1.0,
              //           )),
              //       height: 60.0,
              //       child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Padding(
              //               padding: const EdgeInsets.all(10.0),
              //               child: GestureDetector(
              //                 onTap: () {
              //                   final dynamic tooltip =
              //                       _toolTipKey1.currentState;
              //                   tooltip.ensureTooltipVisible();
              //                 },
              //                 child: Tooltip(
              //                   key: _toolTipKey1,
              //                   message: 'No Stock',
              //                   child: Icon(
              //                     Icons.circle,
              //                     size: 20.0,
              //                     color: Colors.red,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             Padding(
              //               padding: const EdgeInsets.all(10.0),
              //               child: GestureDetector(
              //                 onTap: () {
              //                   final dynamic tooltip =
              //                       _toolTipKey2.currentState;
              //                   tooltip.ensureTooltipVisible();
              //                 },
              //                 child: Tooltip(
              //                   key: _toolTipKey2,
              //                   message: '15 to 20 Days',
              //                   child: Icon(
              //                     Icons.circle,
              //                     size: 20.0,
              //                     color: Colors.yellow,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             Padding(
              //               padding: const EdgeInsets.all(10.0),
              //               child: GestureDetector(
              //                 onTap: () {
              //                   final dynamic tooltip =
              //                       _toolTipKey3.currentState;
              //                   tooltip.ensureTooltipVisible();
              //                 },
              //                 child: Tooltip(
              //                   key: _toolTipKey3,
              //                   message: '10 to 15 Days',
              //                   child: Icon(
              //                     Icons.circle,
              //                     size: 20.0,
              //                     color: Colors.orange,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             Padding(
              //               padding: const EdgeInsets.all(10.0),
              //               child: GestureDetector(
              //                 onTap: () {
              //                   final dynamic tooltip =
              //                       _toolTipKey4.currentState;
              //                   tooltip.ensureTooltipVisible();
              //                 },
              //                 child: Tooltip(
              //                   key: _toolTipKey4,
              //                   message: '3 to 4 Days',
              //                   child: Icon(
              //                     Icons.circle,
              //                     size: 20.0,
              //                     color: Colors.blue[900],
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             Padding(
              //               padding: const EdgeInsets.all(10.0),
              //               child: GestureDetector(
              //                 onTap: () {
              //                   final dynamic tooltip =
              //                       _toolTipKey5.currentState;
              //                   tooltip.ensureTooltipVisible();
              //                 },
              //                 child: Tooltip(
              //                   key: _toolTipKey5,
              //                   message: 'Total Stock',
              //                   child: Icon(
              //                     Icons.circle,
              //                     size: 20.0,
              //                     color: Colors.green,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ])),
              // ),
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
              if (productsdisplay.isNotEmpty)
                //--------------
                Expanded(
                  child: new ListView.builder(
                    itemCount: productsdisplay.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      getColor() {
                        if (productsdisplay[index]['stock-colour'] == "RED")
                          return Colors.red;
                        else if (productsdisplay[index]['stock-colour'] ==
                            "YELLOW")
                          return Colors.yellow;
                        else if (productsdisplay[index]['stock-colour'] ==
                            "ORANGE")
                          return Colors.orange;
                        else if (productsdisplay[index]['stock-colour'] ==
                            "BLUE")
                          return Colors.blue;
                        else if (productsdisplay[index]['stock-colour'] ==
                            "GREEN") return Colors.green;
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
                            child: Column(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        //print("object");
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetail(
                                                    item: productsdisplay[index]
                                                        ['itemno'],
                                                    stockstatus:
                                                        productsdisplay[index]
                                                            ['stock-colour'],
                                                    unitconv: "",
                                                    todo: productsdisplay[index]
                                                        ['unitconv'],
                                                  )
                                              // settings: RouteSettings(
                                              //     arguments:
                                              //         productsdisplay[index]),
                                              ),
                                        );
                                      },
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.circle,
                                          size: 30.0,
                                          color: getColor(),
                                        ),
                                        title: Text(
                                          "Product :" +
                                              " " +
                                              productsdisplay[index]['desc']
                                                  .toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                        ),
                                        subtitle: Text(
                                          "Item No :" +
                                              " " +
                                              productsdisplay[index]['itemno']
                                                  .toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                        ),
                                        trailing: Text(
                                          productsdisplay[index]['unit'],
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              if (productsdisplay.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(160.0),
                  child: Center(
                    child: SizedBox(
                      child: CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),
            ]),
      ),
    );
  }

  void getProductName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    productName = pref.getString('product')!;
    setState(() {});
  }
}
