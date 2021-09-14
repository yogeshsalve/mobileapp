import 'package:flutter/material.dart';
import 'package:orderapp/drawerpages/orderenquiry.dart';

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
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => OrderEnquiry()));
                  },
                  child: Container(
                    width: 110,
                    height: 110,
                    child: Card(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Image.asset(
                            "images/enquiry.png",
                            width: size.height * 0.1,
                          ),
                          SizedBox(
                            height: size.height * 0.01,
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
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[200],
                        boxShadow: [
                          BoxShadow(color: Colors.black, blurRadius: 12.0)
                        ],
                        border: Border.all(color: Colors.black)),
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
                          "images/outstanding_balance.png",
                          width: size.height * 0.1,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
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
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[200],
                      boxShadow: [
                        BoxShadow(color: Colors.black, blurRadius: 12.0)
                      ],
                      border: Border.all(color: Colors.black)),
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
                          "images/history.png",
                          width: size.height * 0.1,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
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
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[200],
                      boxShadow: [
                        BoxShadow(color: Colors.black, blurRadius: 12.0)
                      ],
                      border: Border.all(color: Colors.black)),
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(10),
                  //   color: Colors.white,
                  // ),
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
