import 'package:flutter/material.dart';
import 'package:orderapp/drawerpages/orderdetails.dart';
import 'package:orderapp/drawerpages/orderenquiry.dart';
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
            Row(
              children: <Widget>[
                // ignore: deprecated_member_use
                RaisedButton(
                  elevation: 16.0,
                  child: Text('Order Enquiry'),
                  color: Colors.yellow,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => OrderEnquiry()));
                  },
                ),

                SizedBox(
                  width: size.width * 0.1,
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  elevation: 16.0,
                  child: Text('Order Details'),
                  color: Colors.yellow,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => OrderDetails()));
                  },
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
