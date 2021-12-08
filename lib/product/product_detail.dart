import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/dashboard.dart';
import 'package:orderapp/drawer.dart';
import 'package:orderapp/drawerpages/cart.dart';

// import 'package:orderapp/drawerpages/dbhelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:orderapp/homepage/homesearch.dart';
// import 'package:orderapp/drawerpages/cart%20copy.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class ProductDetail extends StatefulWidget {
  late String desc, item, stockstatus, unitconv;
  List todo = [];
  ProductDetail(
      {Key? key,
      required this.desc,
      required this.item,
      required this.stockstatus,
      required this.unitconv,
      required this.todo})
      : super(key: key);
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  String userCookie = '';
  final _formKey = GlobalKey<FormState>();
  var selectedLocation;
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();
  final myController5 = TextEditingController();

  // final dbhelper = Databasehelper.instance;
  // void insertdata() async {
  //   Map<String, dynamic> row = {
  //     Databasehelper.columnDesc: myController1.text,
  //     Databasehelper.columnQuantity: myController2.text,
  //     Databasehelper.columnUom: myController3.text,
  //     // Databasehelper.columnDesc: myController4.text,
  //   };
  //   final id = await dbhelper.insert(row);

  //   print(id);
  // }

  //###########################################

  postData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
// ---------------token-------------------

    userCookie = pref.getString('userCookiekey')!;
    setState(() {});
    print(userCookie);
// -------------token ------------------------
    var url = Uri.parse("http://114.143.151.6:901/cart-add");
    var response = await http.post(url, body: {
      "item": myController1.text,
      "quantity": myController2.text,
      "selected_uom": myController3.text,
      "stock_status": myController4.text,
      "all_uom": myController5.text,

      // "item": '0912020306',
      // "quantity": '790',
      // "selected_uom": 'BOX/4000.00',
      // "stock_status": 'ORANGE',
      // "all_uom": 'BOX/4000.00CASE/80000.00MPCS/1000.00NOS/1.00',
    }, headers: {
      'Cookie': userCookie
    });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Info'),
          content: const Text('Product Added to Cart'),
          actions: <Widget>[
            // TextButton(
            //   onPressed: () => Navigator.pop(context, 'OK'),
            //   child: const Text('Cancel'),
            // ),
            TextButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Cart())),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
    if (response.statusCode == 500) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Alert'),
          content: const Text('Invalid Input Quantity'),
          actions: <Widget>[
            // TextButton(
            //   onPressed: () => Navigator.pop(context, 'OK'),
            //   child: const Text('Cancel'),
            // ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  //###########################################

  @override
  Widget build(BuildContext context) {
    var stringList;
    //var seluom;

    Size size = MediaQuery.of(context).size;
    List a = [];
    List<String> alluom = [];

    List<String> _locations = [];

    for (var item2 in widget.todo) {
      a.add(item2);
      alluom.add(
          item2["UNIT"].toString() + " / " + item2["CONVERSION"].toString());
      _locations.add(item2["UNIT"] + "/" + item2["CONVERSION"]);
      // products2.add(item2['itemno']);
      setState(() {
        _locations = _locations;
        stringList = alluom.join("");
        print(stringList);
      });
    }

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.blueAccent[700],
        backgroundColor: Colors.grey[850],
        title: const Text('Add To Cart'),
        leading: BackButton(
            color: Colors.white,
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Dashboard()))),
      ),
      // ***********************
      body: Material(
          child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: size.height * 0.1),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          child: TextFormField(
                            //readOnly: true,
                            // controller: myController1,
                            controller: myController1..text = widget.item,
                            // controller: passwordText,
                            style: TextStyle(fontSize: 18),
                            decoration: InputDecoration(
                              labelText: "Item No",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          width: 400,
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: Colors.blueGrey,
                                  width: 1,
                                  style: BorderStyle.solid)),
                          child: DropdownButton(
                            isExpanded: true,

                            hint: Text(
                              'Please choose a uom',
                              style: TextStyle(fontSize: 18),
                            ), // Not necessary for Option 1
                            value: selectedLocation,
                            onChanged: (newValue) {
                              setState(() {
                                selectedLocation = newValue;
                                //sseluom = newValue;
                              });
                            },
                            items: _locations.map((location) {
                              return DropdownMenuItem(
                                child: new Text(location),
                                value: location,
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          child: TextFormField(
                            //readOnly: true,
                            //controller: _controller,
                            controller: myController2,
                            keyboardType: TextInputType.number,
                            // controller: passwordText,
                            style: TextStyle(fontSize: 18),
                            decoration: InputDecoration(
                              labelText: "Quantity",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Visibility(
                          visible: false,
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            child: TextFormField(
                              // readOnly: true,
                              //controller: _controller,
                              controller: myController3
                                ..text = selectedLocation ?? 'default value',
                              // controller: passwordText,
                              style: TextStyle(fontSize: 18),
                              decoration: InputDecoration(
                                labelText: "UOM",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        // Visibility(
                        //   // visible: false,
                        //   child: Container(
                        //     alignment: Alignment.center,
                        //     margin: EdgeInsets.symmetric(horizontal: 50),
                        //     child: TextFormField(
                        //       //readOnly: true,
                        //       //controller: _controller,
                        //       controller: myController4,
                        //       keyboardType: TextInputType.number,
                        //       // controller: passwordText,
                        //       style: TextStyle(fontSize: 18),
                        //       decoration: InputDecoration(
                        //         labelText: "Desc",
                        //         border: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(5.0),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(height: size.height * 0.01),
                        Container(
                          alignment: Alignment.center,
                          //color: Colors.white,
                          width: size.width * 0.7,
                          child: ElevatedButton(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add,
                                  // color: Colors.black,
                                ),
                                Text(
                                  '  Add to Cart',
                                  // style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                            onPressed: () {
                              postData();
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 70, vertical: 10),
                                textStyle: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                shape: StadiumBorder()),
                          ),
                        ),
                        // ElevatedButton(
                        //     onPressed: () {
                        //       postData();
                        //     },
                        //     child: Text("Add To Cart"))
                      ])))),

      // ***********************
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
