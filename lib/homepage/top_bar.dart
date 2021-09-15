import 'package:flutter/material.dart';
import 'package:orderapp/models/global.dart';

// ignore: must_be_immutable
class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(5),
      color: Colors.grey[350],
      height: size.height * 0.09,
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
                    width: size.width * 0.7,
                    height: size.height * 0.06,
                    child: Center(
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search APLORDER Item',
                            icon: Icon(Icons.search, color: dark_blue)),
                      ),
                    ),
                  ),
                  Icon(Icons.camera_alt, color: dark_blue)
                ],
              ))
        ],
      ),
    );
  }
}
