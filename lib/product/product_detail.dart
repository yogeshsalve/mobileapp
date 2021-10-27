import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/dashboard.dart';
import 'package:orderapp/drawer.dart';
import 'package:orderapp/drawerpages/cart.dart';
// import 'package:orderapp/drawerpages/cart%20copy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class ProductDetail extends StatefulWidget {
  late String item, stockstatus, unitconv;
  List todo = [];
  ProductDetail(
      {Key? key,
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

  //###########################################

  postData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
// ---------------token-------------------
// final SharedPreferences pref = await SharedPreferences.getInstance();
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
        backgroundColor: Colors.blueAccent[700],
        title: const Text('ProductDetail'),
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
                        SizedBox(height: size.height * 0.05),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          child: TextFormField(
                            //readOnly: true,
                            //controller: _controller,
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
                        SizedBox(height: size.height * 0.05),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          child: DropdownButton(
                            isExpanded: true,
                            //style: TextStyle(fontSize: 18),
                            hint: Text(
                              'Please choose a uom',
                              style: TextStyle(fontSize: 24),
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
                        SizedBox(height: size.height * 0.01),
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
                        SizedBox(height: size.height * 0.01),
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
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          child: TextFormField(
                            readOnly: true,
                            //controller: _controller,
                            controller: myController4
                              ..text = widget.stockstatus,
                            // controller: passwordText,
                            style: TextStyle(fontSize: 18),
                            decoration: InputDecoration(
                              labelText: "Stock Status",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        Visibility(
                          visible: false,
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            child: TextFormField(
                              //readOnly: true,
                              //controller: _controller,
                              controller: myController5
                                ..text = stringList.toString(),
                              // controller: passwordText,
                              style: TextStyle(fontSize: 18),
                              decoration: InputDecoration(
                                labelText: "All UOM",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        //Text(widget.todo.toString()),
                        SizedBox(height: size.height * 0.01),
                        // Text(stringList),

                        //Text(selectedLocation ?? 'default value'),
                        ElevatedButton(
                            onPressed: () {
                              postData();
                            },
                            child: Text("Add To Cart"))
                      ])))),

      // ***********************
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
