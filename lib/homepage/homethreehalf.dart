// import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:orderapp/homepage/monthlypurchase.dart';
// import 'package:orderapp/homepage/monthlypurchase.dart';
// import 'package:orderapp/splashscreen.dart';

class Homehreehalf extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Container(
      // color: Colors.blue[700],
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Row(
                // mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ElevatedButton(
                        child: Row(
                          children: [
                            Icon(
                              Icons.download,
                              color: Colors.white,
                            ),
                            Text(
                              '  Monthly Purchase',
                              // style: TextStyle(color: Colors.orange),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MonthlyPurchase()));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          // textStyle: TextStyle(
                          //     fontSize: 18, fontWeight: FontWeight.bold),
                          // shape: StadiumBorder()
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ElevatedButton(
                        child: Row(
                          children: [
                            Icon(
                              Icons.download,
                              // color: Colors.black,
                            ),
                            Text(
                              '  Yearly Purchase',
                              // style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MonthlyPurchase()));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          // textStyle: TextStyle(
                          //     fontSize: 18, fontWeight: FontWeight.bold),
                          // shape: StadiumBorder()
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Row(
            //   children: <Widget>[
            //     // ignore: deprecated_member_use
            //     RaisedButton(
            //       elevation: 16.0,
            //       child: Text('Monthly Purchase'),
            //       color: Colors.green,
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.all(Radius.circular(16.0))),
            //       onPressed: () {
            //         Navigator.of(context).pushReplacement(MaterialPageRoute(
            //             builder: (BuildContext context) => MonthlyPurchase()));
            //       },
            //     ),

            //     SizedBox(
            //       width: size.width * 0.1,
            //     ),

            //     // ignore: deprecated_member_use
            //     RaisedButton(
            //       elevation: 16.0,
            //       child: Text(
            //         'Yearly Purchase',
            //       ),
            //       color: Colors.green,
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.all(Radius.circular(16.0))),
            //       onPressed: () {},
            //     ),
            //   ], //<Widget>[]
            //   mainAxisAlignment: MainAxisAlignment.center,
            // ), //Row
          ],
        ),
      ),
    ));
  }
}
