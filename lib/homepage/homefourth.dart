import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:orderapp/product/category_product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

// import 'package:orderapp/product/product_grid.dart';

// import 'package:orderapp/product/product_grid.dart';

class Homefourth extends StatefulWidget {
  @override
  _HomefourthState createState() => _HomefourthState();
}

class _HomefourthState extends State<Homefourth> {
  int _index = -1;
  String getData = '';
  String userCookie = '';
  var xyz = "session=QwJyeKwiLowATLO7DRCqY28gcTH6EikHe0VE6cAYhCw";

  // var url = Uri.parse('https://yogeshsalve.com/API/');
  var url = Uri.parse('http://114.143.151.6:901/categories');
  List getList1 = [];
  List getList = [];
  List getList2 = [];
  String productName = '';
  // var cookie;

  @override
  void initState() {
    super.initState();
    this.fetchData();
    // getCookie();
  }

  Future fetchData() async {
// ---------------token-------------------
    final SharedPreferences pref = await SharedPreferences.getInstance();
    userCookie = pref.getString('userCookiekey')!;
    setState(() {});

    print(userCookie);

    // -------------token ------------------------

    http.Response response;
    response = await http.get(url, headers: {'Cookie': userCookie});

    if (response.statusCode == 200) {
      setState(() {
        getList1 = json.decode(response.body);
        for (var item2 in getList1) {
          getList2.add(item2['id']);
          setState(() {
            getList = getList2;
          });
        }
      });
      print(getList);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        // color: Colors.blue[100],
        color: Colors.grey[850],
        child: SizedBox(
          height: size.height * 0.10, // card height
          child: PageView.builder(
            itemCount: getList.length,
            controller: PageController(viewportFraction: 0.20),
            onPageChanged: (int index) => setState(() => _index = index),
            itemBuilder: (_, i) {
              return Transform.scale(
                scale: i == _index ? 1 : 1,
                child: InkWell(
                  onTap: () => {
                    setProductName(getList[i].toString()),
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) => CategoryProduct(),
                        settings:
                            RouteSettings(arguments: getList[i].toString()),
                      ),
                    ),
                  },
                  child: Card(
                    color: Colors.blue,
                    elevation: 10,
                    shape: CircleBorder(
                      side: BorderSide(color: Colors.white, width: 2.1),
                    ),
                    child: Center(
                      child: Text(
                        getList[i].toString(),
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      // child: Text(userCookie),
    );
  }

  Future<void> setProductName(productName) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('product', productName);
  }

  // void getCookie() async {
  //   final SharedPreferences pref = await SharedPreferences.getInstance();
  //   userCookie = pref.getString('userCookiekey')!;
  //   setState(() {});
  // }
}
