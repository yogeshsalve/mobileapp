import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:orderapp/product/product_detail.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HomeSearch extends StatefulWidget {
  const HomeSearch({Key? key}) : super(key: key);

  @override
  _HomeSearchState createState() => _HomeSearchState();
}

var p = TextEditingController();
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

class _HomeSearchState extends State<HomeSearch> {
  String desc = "";
  // var aa = "44";
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

    //test("44");
  }

  test(text) async {
    text.toLowerCase();
    setState(() {
      productsdisplay = items3.where((items3) {
        items3 = items3.toString();
        items3 = items3.toLowerCase();
        return items3.contains(text.toString());
      }).toList();
    });
  }

  fetchProduct() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    // ---------------token-------------------
    // final SharedPreferences pref = await SharedPreferences.getInstance();
    userCookie = pref.getString('userCookiekey')!;
    setState(() {});
    print(userCookie);

    // -------------token ------------------------

    var url = Uri.parse('http://114.143.151.6:901/product-all');
    var response = await http.get(url, headers: {'Cookie': userCookie});
    print(response.statusCode);
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
    print(productsdisplay);
  }

  final _formKey = GlobalKey<FormState>();
  // final _formKey2 = GlobalKey<FormState>();
  // final _cartkey = GlobalKey<FormState>();
  String productName = '';
  var a;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments.toString();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.blueAccent[700],
        backgroundColor: Colors.grey[850],
        // title: TopBar1(),
        title: Text("STORE"),
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
                color: Colors.blue,
                height: size.height * 0.03,
              ),
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
                                    //controller: ,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Search APLORDER Item',
                                        icon: Icon(Icons.search,
                                            color: Colors.blue)),
                                    onChanged: test),
                              ),
                            ),
                            Icon(Icons.camera_alt, color: Colors.blue)
                          ],
                        )),
                  ],
                ),
              ),
              //-----------------
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
                                                    desc: productsdisplay[index]
                                                        ['desc'],
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
                                      // onTap: () {
                                      //   showDialog(
                                      //       context: context,
                                      //       builder: (BuildContext context) =>
                                      //           new AlertDialog(
                                      //             shape: RoundedRectangleBorder(
                                      //                 borderRadius:
                                      //                     BorderRadius.all(
                                      //                         Radius.circular(
                                      //                             32.0))),
                                      //             contentPadding:
                                      //                 EdgeInsets.only(top: 10.0),
                                      //             content: SingleChildScrollView(
                                      //               child: Container(
                                      //                 width: size.width * 1,
                                      //                 child: Form(
                                      //                   key: _formKey2,
                                      //                   child: Column(
                                      //                       mainAxisAlignment:
                                      //                           MainAxisAlignment
                                      //                               .start,
                                      //                       children: <Widget>[
                                      //                         SizedBox(
                                      //                             height:
                                      //                                 size.height *
                                      //                                     0.01),
                                      //                         Container(
                                      //                           alignment:
                                      //                               Alignment
                                      //                                   .center,
                                      //                           margin: EdgeInsets
                                      //                               .symmetric(
                                      //                                   horizontal:
                                      //                                       50),
                                      //                           child:
                                      //                               TextFormField(
                                      //                             // readOnly: true,
                                      //                             controller: myController11
                                      //                               ..text = productsdisplay[
                                      //                                           index]
                                      //                                       [
                                      //                                       'itemno']
                                      //                                   .toString(),

                                      //                             // controller: passwordText,
                                      //                             style: TextStyle(
                                      //                                 fontSize:
                                      //                                     18),
                                      //                             decoration:
                                      //                                 InputDecoration(
                                      //                                     labelText:
                                      //                                         "Item"),
                                      //                           ),
                                      //                         ),
                                      //                         SizedBox(
                                      //                             height:
                                      //                                 size.height *
                                      //                                     0.01),
                                      //                         Container(
                                      //                           alignment:
                                      //                               Alignment
                                      //                                   .center,
                                      //                           margin: EdgeInsets
                                      //                               .symmetric(
                                      //                                   horizontal:
                                      //                                       50),
                                      //                           child:
                                      //                               TextFormField(
                                      //                             // readOnly: true,
                                      //                             controller:
                                      //                                 myController22,

                                      //                             // controller: passwordText,
                                      //                             style: TextStyle(
                                      //                                 fontSize:
                                      //                                     18),
                                      //                             decoration:
                                      //                                 InputDecoration(
                                      //                                     labelText:
                                      //                                         "Quantity"),
                                      //                           ),
                                      //                         ),
                                      //                         SizedBox(
                                      //                             height:
                                      //                                 size.height *
                                      //                                     0.01),
                                      //                         Container(
                                      //                           alignment:
                                      //                               Alignment
                                      //                                   .center,
                                      //                           margin: EdgeInsets
                                      //                               .symmetric(
                                      //                                   horizontal:
                                      //                                       50),
                                      //                           child:
                                      //                               TextFormField(
                                      //                             // readOnly: true,
                                      //                             controller:
                                      //                                 myController33,

                                      //                             // controller: passwordText,
                                      //                             style: TextStyle(
                                      //                                 fontSize:
                                      //                                     18),
                                      //                             decoration:
                                      //                                 InputDecoration(
                                      //                                     labelText:
                                      //                                         "Uom"),
                                      //                           ),
                                      //                         ),
                                      //                         SizedBox(
                                      //                             height:
                                      //                                 size.height *
                                      //                                     0.01),
                                      //                         Container(
                                      //                           alignment:
                                      //                               Alignment
                                      //                                   .center,
                                      //                           margin: EdgeInsets
                                      //                               .symmetric(
                                      //                                   horizontal:
                                      //                                       50),
                                      //                           child:
                                      //                               TextFormField(
                                      //                             // readOnly: true,
                                      //                             controller:
                                      //                                 myController44,

                                      //                             // controller: passwordText,
                                      //                             style: TextStyle(
                                      //                                 fontSize:
                                      //                                     18),
                                      //                             decoration:
                                      //                                 InputDecoration(
                                      //                                     labelText:
                                      //                                         "Stock Status"),
                                      //                           ),
                                      //                         ),
                                      //                         SizedBox(
                                      //                             height:
                                      //                                 size.height *
                                      //                                     0.01),
                                      //                         Container(
                                      //                           alignment:
                                      //                               Alignment
                                      //                                   .center,
                                      //                           margin: EdgeInsets
                                      //                               .symmetric(
                                      //                                   horizontal:
                                      //                                       50),
                                      //                           child:
                                      //                               TextFormField(
                                      //                             // readOnly: true,
                                      //                             controller:
                                      //                                 myController55,

                                      //                             // controller: passwordText,
                                      //                             style: TextStyle(
                                      //                                 fontSize:
                                      //                                     18),
                                      //                             decoration:
                                      //                                 InputDecoration(
                                      //                                     labelText:
                                      //                                         "All Uom"),
                                      //                           ),
                                      //                         ),
                                      //                         SizedBox(
                                      //                             height:
                                      //                                 size.height *
                                      //                                     0.05),
                                      //                         Material(
                                      //                           color:
                                      //                               Colors.blue,
                                      //                           borderRadius:
                                      //                               BorderRadius
                                      //                                   .circular(
                                      //                                       10),
                                      //                           child: InkWell(
                                      //                             onTap: () {
                                      //                               // Navigator.of(context).pushReplacement(MaterialPageRoute(
                                      //                               //     builder: (BuildContext context) => Cart()));
                                      //                               // cart(context);
                                      //                             },
                                      //                             child:
                                      //                                 Container(
                                      //                               width: 150,
                                      //                               height: 50,
                                      //                               alignment:
                                      //                                   Alignment
                                      //                                       .center,
                                      //                               child: Text(
                                      //                                   "Add To Cart",
                                      //                                   style: TextStyle(
                                      //                                       color: Colors
                                      //                                           .white,
                                      //                                       fontWeight: FontWeight
                                      //                                           .bold,
                                      //                                       fontSize:
                                      //                                           18)),
                                      //                             ),
                                      //                           ),
                                      //                         ),
                                      //                         SizedBox(
                                      //                             height:
                                      //                                 size.height *
                                      //                                     0.1),
                                      //                       ]),
                                      //                 ),
                                      //               ),
                                      //             ),

                                      //           ));
                                      // },
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.circle,
                                          size: 30.0,
                                          color: getColor(),
                                        ),
                                        title: Text(
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
