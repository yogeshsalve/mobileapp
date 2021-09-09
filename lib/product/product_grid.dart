import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:orderapp/dashboard.dart';
// import 'package:orderapp/homepage/top_bar.dart';

class Productgrid extends StatefulWidget {
  const Productgrid({Key? key}) : super(key: key);

  @override
  _ProductgridState createState() => _ProductgridState();
}

class _ProductgridState extends State<Productgrid> {
  final myController1 = TextEditingController();
  List products = [];
  List products2 = [];
  List productsdisplay = [];
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) => yourFunction(context));
    fetchProduct();
  }

  fetchProduct() async {
    var url = Uri.parse('https://yogeshsalve.com/API/products/productdata.php');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var items2 = jsonDecode(response.body);
      // print(items);
      //List products2 = [];
      products.clear();
      for (var item2 in items2) {
        if (item2['category'] == myController1.text) {
          // print(item['title']);
          products2.add(item2['title']);
          setState(() {
            products = products2;
            productsdisplay = products2;
          });
        }
      }

      print(products);
      // setState(() {
      //   items = products2;
      // });
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    int _itemCount = 0;
    final args = ModalRoute.of(context)!.settings.arguments.toString();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        title: const Text('Products Grid'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Dashboard()),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Form(
            key: _formKey,
            child: Visibility(
              visible: false,
              child: TextFormField(
                readOnly: true,
                controller: myController1..text = args,
                // controller: passwordText,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(labelText: "category"),
              ),
            ),
          ),
          // TopBar(),

          Container(
            padding: EdgeInsets.all(5),
            color: Colors.grey[350],
            height: size.height * 0.10,
            child: Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    margin: EdgeInsets.all(5),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 300,
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search APLORDER Item',
                                icon: Icon(Icons.search, color: Colors.blue)),
                            onChanged: (text) {
                              text.toLowerCase();
                              setState(() {
                                productsdisplay = products.where((products) {
                                  products = products.toLowerCase();
                                  return products.contains(text);
                                }).toList();
                              });
                            },
                          ),
                        ),
                        Icon(Icons.camera_alt, color: Colors.blue)
                      ],
                    )),
              ],
            ),
          ),

          // TextFormField(
          //   style: TextStyle(fontSize: 18),
          //   decoration: InputDecoration(labelText: "search"),
          //   onChanged: (text) {
          //     text.toLowerCase();
          //     setState(() {
          //       productsdisplay = products.where((products) {
          //         products = products.toLowerCase();
          //         return products.contains(text);
          //       }).toList();
          //     });
          //   },
          // ),
          Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: productsdisplay.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    // alignment: Alignment.center,
                    // color: Colors.white,
                    child: Center(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.of(context).pushReplacement(
                        //       MaterialPageRoute(
                        //         builder: (BuildContext context) => BuyForm(),
                        //         settings:
                        //             RouteSettings(arguments: getList[index]),
                        //       ),
                        //     );
                        //   },
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            elevation: 10.0,
                            child: InkWell(
                              onTap: () => {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Dashboard(),
                                    settings: RouteSettings(
                                        arguments: productsdisplay[index]),
                                  ),
                                ),
                              },
                              child: Container(
                                height: size.height * 0.16,
                                // width: size.height * 0.65,
                                child: Column(children: [
                                  Text(
                                    productsdisplay[index].toString(),
                                    style: TextStyle(
                                      fontSize: 13.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ),
                                        _itemCount != 0
                                            ? new IconButton(
                                                icon: new Icon(Icons.remove),
                                                onPressed: () => setState(
                                                    () => _itemCount--),
                                              )
                                            : new Container(),
                                        new Text(_itemCount.toString()),
                                        new IconButton(
                                            icon: new Icon(Icons.add),
                                            onPressed: () =>
                                                setState(() => _itemCount++)),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Icon(
                                          Icons.add_circle,
                                          color: Colors.green,
                                        )
                                        // ElevatedButton(
                                        //   onPressed: () {},
                                        //   child: Text(
                                        //       "Add to Cart".toUpperCase(),
                                        //       style: TextStyle(fontSize: 14)),
                                        // )
                                      ],
                                    ),
                                  ),
                                ]),

                                padding: EdgeInsets.all(
                                  15.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                  );
                },
              )),
        ],
      ),
    );
  }
}
