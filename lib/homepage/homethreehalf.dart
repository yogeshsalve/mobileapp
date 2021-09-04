import 'package:flutter/material.dart';
import 'package:orderapp/homepage/monthlypurchase.dart';

class Homehreehalf extends StatelessWidget {
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
                  child: Text('Monthly Purchase'),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => MonthlyPurchase()));
                  },
                ),

                SizedBox(
                  width: size.width * 0.1,
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  elevation: 16.0,
                  child: Text('Yearly Purchase'),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  onPressed: () {},
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
