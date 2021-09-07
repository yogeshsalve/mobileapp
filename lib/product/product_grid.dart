import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:orderapp/dashboard.dart';
import 'package:orderapp/homepage/top_bar.dart';

class Productgrid extends StatefulWidget {
  const Productgrid({Key? key}) : super(key: key);

  @override
  _ProductgridState createState() => _ProductgridState();
}

class _ProductgridState extends State<Productgrid> {
  List products = [];
  @override
  void initState() {
    super.initState();
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
        if (item2['category'] == "NUT") {
          // print(item['title']);
          products.add(item2['title']);
        }
      }

      print(products);
      // setState(() {
      //   items = products2;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
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
          TopBar(),
          Expanded(
              flex: 6,
              child: ListView.builder(
                itemCount: products.length,
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
                                        arguments: products[index]),
                                  ),
                                ),
                              },
                              child: Container(
                                height: size.height * 0.18,
                                // width: size.height * 0.65,
                                child: Column(children: [
                                  Text(
                                    products[index].toString(),
                                    style: TextStyle(
                                      fontSize: 21.0,
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
                                          size: 36.0,
                                          semanticLabel:
                                              'Text to announce in accessibility modes',
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                              "Add to Cart".toUpperCase(),
                                              style: TextStyle(fontSize: 14)),
                                        )
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
