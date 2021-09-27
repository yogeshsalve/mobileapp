import 'package:flutter/material.dart';
import 'package:orderapp/drawer.dart';
//import 'package:orderapp/bottomnavigation.dart';
//import 'package:orderapp/drawer.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'dart:convert';

class DropDown extends StatefulWidget {
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String getData = '';
  // var url = Uri.parse('https://yogeshsalve.com/API/');
  var url = Uri.parse('https://yogeshsalve.com/API/');
  List getList = [];
  // ignore: avoid_init_to_null
  var items = ['Default Item 1'];
  Future fetchData() async {
    http.Response response;
    response = await http.get(url);
    //print(response.body);
    // var items2 = response.body;
    // items = items2 as List<String>;
    getList = json.decode(response.body);
    // List products2 = [];
    for (var i in getList) {
      if (1 == 1) {
        print(i);
        items.add(i);
      }
    }
    print(items);
    if (response.statusCode == 200) {
      setState(() {
        // items = ['Default Item 2'];3
        items = items;
        // var items = response.body;
      });
    }
    //print(getList);
    print(items);
    //print(getList);
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  final TextEditingController _controller = new TextEditingController();

  // var items = [
  //   'Working a lot harder',
  //   'Being a lot smarter',
  //   'Being a self-starter',
  //   'Placed in charge of trading charter',
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        title: const Text('DropDown'),
      ),
      drawer: MyDrawer(),
      body: new Center(
        child: new Container(
          child: new Column(
            children: [
              new Padding(
                padding: const EdgeInsets.all(24.0),
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                        child: new TextField(
                      controller: _controller,
                      readOnly: true,
                    )),
                    new PopupMenuButton<String>(
                      icon: const Icon(Icons.arrow_drop_down),
                      onSelected: (String value) {
                        _controller.text = value;
                      },
                      itemBuilder: (BuildContext context) {
                        return items.map<PopupMenuItem<String>>((String value) {
                          return new PopupMenuItem(
                              child: new Text(value), value: value);
                        }).toList();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
