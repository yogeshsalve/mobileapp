import 'package:flutter/material.dart';
import 'package:orderapp/drawerpages/certificate.dart';
import 'package:orderapp/drawerpages/ledger.dart';
import 'package:orderapp/drawerpages/printinvoice.dart';

class Homesixth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Container(
      color: Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => PrintInvoice()));
                  },
                  child: Container(
                    width: size.width * 0.27,
                    height: size.height * 0.15,
                    child: Card(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Image.asset(
                            "images/invoice.png",
                            width: size.height * 0.1,
                          ),
                          Text(
                            "Invoice",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
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
                        builder: (BuildContext context) => Certificate()));
                  },
                  child: Container(
                    width: size.width * 0.27,
                    height: size.height * 0.15,
                    child: Card(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Image.asset(
                            "images/certificate.png",
                            width: size.height * 0.1,
                          ),
                          Text(
                            "Certificate",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
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
                        builder: (BuildContext context) => Ledger()));
                  },
                  child: Container(
                    width: size.width * 0.29,
                    height: size.height * 0.15,
                    child: Card(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Image.asset(
                            "images/ledger.png",
                            width: size.height * 0.1,
                          ),
                          Text(
                            "Ledger",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
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
              ], //<Widget>[]
              mainAxisAlignment: MainAxisAlignment.center,
            ), //Row
          ],
        ),
      ),
    ));
  }
}
