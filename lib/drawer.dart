import 'package:flutter/material.dart';
import 'package:orderapp/drawerpages/cart.dart';
import 'package:orderapp/drawerpages/certificate.dart';
import 'package:orderapp/drawerpages/changepassword.dart';
import 'package:orderapp/drawerpages/fevstore.dart';

import 'package:orderapp/drawerpages/ledger.dart';
import 'package:orderapp/drawerpages/orderenquiry.dart';
import 'package:orderapp/drawerpages/outstanding.dart';
import 'package:orderapp/drawerpages/pendingorder.dart';
import 'package:orderapp/drawerpages/printinvoice.dart';
import 'package:orderapp/drawerpages/saleshistory.dart';
import 'package:orderapp/drawerpages/store.dart';
import 'package:orderapp/dropdowntest.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Container(
              // color: Theme.of(context).primaryColor,
              color: Colors.white,
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Container(
                    // color: Theme.of(context).primaryColor,

                    margin: EdgeInsets.only(top: 30, bottom: 5),
                    width: 85,
                    height: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: new AssetImage("images/logo3.png"),
                        )),
                  ),
                  Text(
                    "for those who want the best",
                    style: TextStyle(fontSize: 15, color: Colors.blueAccent),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),

            // Divider(
            //   thickness: 2,
            //   color: Colors.deepPurpleAccent[300],
            // ),

            //listTiles
            ListTile(
              title: Text(
                'ABC Pvt. Ltd.',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              tileColor: Colors.blue,
              leading: Icon(Icons.account_circle),
              onTap: null,
            ),

            // Divider(
            //   thickness: 2,
            //   color: Colors.deepPurpleAccent[300],
            // ),

            ListTile(
              title: Text('Store', style: TextStyle(fontSize: 20)),
              tileColor: Colors.white10,
              leading: Icon(Icons.share),
              onTap: () => {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => Store()))
              },
            ),

            ListTile(
              title: Text('Favourite Store', style: TextStyle(fontSize: 20)),
              tileColor: Colors.white10,
              leading: Icon(Icons.more),
              onTap: () => {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => FavStore()))
              },
            ),

            ListTile(
              title: Text('Cart', style: TextStyle(fontSize: 20)),
              tileColor: Colors.white10,
              leading: Icon(Icons.contact_support),
              onTap: () => {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => Cart()))
              },
            ),

            ListTile(
              title: Text('Order Enquiry', style: TextStyle(fontSize: 20)),
              tileColor: Colors.white10,
              leading: Icon(Icons.contact_support),
              onTap: () => {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => OrderEnquiry()))
              },
            ),

            ListTile(
              title: Text('Pending Order', style: TextStyle(fontSize: 20)),
              tileColor: Colors.white10,
              leading: Icon(Icons.contact_support),
              onTap: () => {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => PendingOrder()))
              },
            ),

            ListTile(
              title:
                  Text('Outstanding Balance', style: TextStyle(fontSize: 20)),
              tileColor: Colors.white10,
              leading: Icon(Icons.contact_support),
              onTap: () => {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => Outstanding()))
              },
            ),

            ListTile(
              title: Text('Print Invoice', style: TextStyle(fontSize: 20)),
              tileColor: Colors.white10,
              leading: Icon(Icons.contact_support),
              onTap: () => {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => PrintInvoice()))
              },
            ),

            ListTile(
              title: Text('Certificate', style: TextStyle(fontSize: 20)),
              tileColor: Colors.white10,
              leading: Icon(Icons.contact_support),
              onTap: () => {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => Certificate()))
              },
            ),

            ListTile(
              title: Text('Ledger', style: TextStyle(fontSize: 20)),
              tileColor: Colors.white10,
              leading: Icon(Icons.contact_support),
              onTap: () => {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => Ledger()))
              },
            ),

            ListTile(
              title: Text('Sales History', style: TextStyle(fontSize: 20)),
              tileColor: Colors.white10,
              leading: Icon(Icons.contact_support),
              onTap: () => {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => SalesHistory()))
              },
            ),

            // Divider(
            //     thickness:2,
            //     color: Colors.deepPurpleAccent[300],
            // ),

            ListTile(
              title: Text('Change Password', style: TextStyle(fontSize: 20)),
              tileColor: Colors.white10,
              leading: Icon(Icons.contact_support),
              onTap: () => {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => ChangePassword()))
              },
            ),

            ListTile(
              title: Text('Log Out', style: TextStyle(fontSize: 20)),
              tileColor: Colors.blue,
              leading: Icon(Icons.contact_support),
              onTap: () => {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => Dropdown()))
              },
            ),
            //ListTiles Ends Here
          ],
        ),
      ),
    );
  }
}
