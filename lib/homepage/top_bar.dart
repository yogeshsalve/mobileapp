import 'package:flutter/material.dart';
import 'package:orderapp/homepage/homesearch.dart';
import 'package:orderapp/models/global.dart';

// ignore: must_be_immutable
class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(5),
        color: Colors.grey[350],
        height: size.height * 0.09,
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => HomeSearch()));
              },
              child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  margin: EdgeInsets.all(5),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(Icons.search, color: dark_blue),
                      Text('SEARCH FOR APL PRODUCTS HERE'),
                      Container(
                        // width: size.width * 0.8,
                        height: size.height * 0.06,
                        // child: Center(
                        // ignore: deprecated_member_use
                        // child: ElevatedButton.icon(
                        //   style: ElevatedButton.styleFrom(
                        //     primary: Colors.white, // background
                        //     onPrimary: Colors.blue,
                        //     shape: RoundedRectangleBorder(
                        //         side: BorderSide(
                        //       color: Colors.white,
                        //     )), // foreground
                        //   ),
                        //   icon: Icon(Icons.search, color: dark_blue),
                        //   label: Text(
                        //       'SEARCH APL PRODUCTS                         .'),
                        //   onPressed: () => {
                        //     Navigator.of(context).pushReplacement(
                        //         MaterialPageRoute(
                        //             builder: (BuildContext context) =>
                        //                 HomeSearch())),
                        //   },
                        // ),

                        // ),
                      ),
                      // Icon(Icons.search, color: dark_blue)
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
