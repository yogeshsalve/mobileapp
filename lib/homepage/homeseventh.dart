import 'package:flutter/material.dart';
import 'package:orderapp/drawerpages/orderdetails.dart';
// import 'package:orderapp/drawerpages/orderdetails.dart';
// import 'package:orderapp/drawerpages/orderenquiry.dart';
// import 'package:orderapp/homepage/monthlypurchase.dart';

class HomeSeventh extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Container(
      color: Colors.blue[700],
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => OrderDetails()));
              },
              child: Container(
                child: Center(
                  child: Text(
                    'Order Details',
                    textScaleFactor: 1.8,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: Colors.black12, spreadRadius: 2),
                  ],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(1),
                //color: Colors.yellow,
                height: size.height * 0.07,
                width: size.width * 1,
              ),
            ),

            // Row(
            //   children: <Widget>[
            //     Expanded(
            //       // ignore: deprecated_member_use
            //       child: RaisedButton(
            //         child: Text('Approve'),
            //         onPressed: () => null,
            //       ),
            //     ),
            //     SizedBox(
            //       width: size.width * 0.1,
            //     ),
            //     Expanded(
            //       // ignore: deprecated_member_use
            //       child: RaisedButton(
            //         child: Text('Order Details'),
            //         onPressed: () => null,
            //       ),
            //     ),
            //     SizedBox(
            //       width: size.width * 0.1,
            //     ),
            //     Expanded(
            //       // ignore: deprecated_member_use
            //       child: RaisedButton(
            //         child: Text('Need Revise'),
            //         onPressed: () => null,
            //       ),
            //     )
            //   ],
            // ),
          ],
        ),
      ),
    ));
  }
}
