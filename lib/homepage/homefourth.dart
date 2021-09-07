import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:orderapp/product/product_grid.dart';

class Homefourth extends StatefulWidget {
  @override
  _HomefourthState createState() => _HomefourthState();
}

class _HomefourthState extends State<Homefourth> {
  int _index = -1;
  String getData = '';
  var url = Uri.parse('https://yogeshsalve.com/API/');
  List getList = [];

  Future fetchData() async {
    http.Response response;
    response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        getList = json.decode(response.body);
        print(getList);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        color: Colors.blue[100],
        child: SizedBox(
          height: size.height * 0.15, // card height
          child: PageView.builder(
            itemCount: getList.length,
            controller: PageController(viewportFraction: 0.28),
            onPageChanged: (int index) => setState(() => _index = index),
            itemBuilder: (_, i) {
              return Transform.scale(
                scale: i == _index ? 1 : 0.9,
                child: InkWell(
                  onTap: () => {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) => Productgrid(),
                        settings:
                            RouteSettings(arguments: getList[i].toString()),
                      ),
                    ),
                  },
                  child: Card(
                    color: Colors.grey,
                    elevation: 6,
                    shape: CircleBorder(
                      side: BorderSide(color: Colors.white, width: 2.1),
                    ),
                    child: Center(
                      child: Text(
                        getList[i].toString(),
                        style: TextStyle(
                            fontSize: 15,
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
    );
  }
}
