//import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/drawer.dart';
import 'package:orderapp/product/category_product.dart';
//import 'package:orderapp/product/category_product.dart';

// ignore: must_be_immutable
class ProductDetail extends StatefulWidget {
  late String item, stockstatus, unitconv, productname;
  List todo = [];
  ProductDetail(
      {Key? key,
      required this.item,
      required this.stockstatus,
      required this.unitconv,
      required this.productname,
      required this.todo})
      : super(key: key);
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();
  final myController5 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //var data = ModalRoute.of(context)!.settings.arguments.toString();
    //var data2 = jsonDecode(data);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        title: Text(widget.productname),
        leading: BackButton(
            color: Colors.white, onPressed: () => Navigator.pop(context)),
      ),
      // ***********************
      body: Material(
          child: SingleChildScrollView(
              child: Form(
                  //key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
            SizedBox(height: size.height * 0.05),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: TextFormField(
                readOnly: true,
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
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: TextFormField(
                readOnly: true,
                //controller: _controller,
                controller: myController1..text = widget.item,
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
            SizedBox(height: size.height * 0.01),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: TextFormField(
                readOnly: true,
                //controller: _controller,
                controller: myController4..text = widget.stockstatus,
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
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: TextFormField(
                readOnly: true,
                //controller: _controller,
                controller: myController1..text = widget.item,
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
            SizedBox(height: size.height * 0.01),
            Text(widget.todo.toString())
          ])))),

      // ***********************
      // drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
