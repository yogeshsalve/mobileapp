import 'package:flutter/material.dart';

class Homefifth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Container(
      color: Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Container(
                  width: 110,
                  height: 110,
                  child: Card(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Image.asset(
                          "images/assets/note.png",
                          width: size.height * 0.1,
                        ),
                        Text(
                          "Order Enquiry",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 20,
                ), //SizedBox
                Container(
                  width: 110,
                  height: 110,
                  child: Card(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Image.asset(
                          "images/assets/note.png",
                          width: size.height * 0.1,
                        ),
                        Text(
                          "Outstanding",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                ),

                SizedBox(
                  width: 20,
                ), //SizedBox
                Container(
                  width: 110,
                  height: 110,
                  child: Card(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Image.asset(
                          "images/assets/note.png",
                          width: size.height * 0.1,
                        ),
                        Center(
                          child: Text(
                            "Purchase History",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                ),
              ], //<Widget>[]
              mainAxisAlignment: MainAxisAlignment.center,
            ), //Row
          ],
        ),
      ),
    ));
  }
}
