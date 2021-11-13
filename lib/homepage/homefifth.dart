import 'package:flutter/material.dart';
import 'package:orderapp/drawerpages/orderenquiry.dart';
import 'package:orderapp/drawerpages/outstanding.dart';
import 'package:orderapp/drawerpages/purchasehistory.dart';

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
                    width: size.width * 0.27,
                    height: size.height * 0.15,
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
                  width: size.width * 0.03,
                ), //SizedBox
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => Outstanding()));
                  },
                  child: Container(
                    width: size.width * 0.27,
                    height: size.height * 0.15,
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
                ),

                SizedBox(
                  width: size.width * 0.03,
                ), //SizedBox
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => PurchaseHistory()));
                  },
                  child: Container(
                    width: size.width * 0.29,
                    height: size.height * 0.15,
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
