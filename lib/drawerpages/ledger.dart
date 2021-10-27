import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/dashboard.dart';
import 'package:orderapp/drawer.dart';

class Ledger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        title: const Text('Ledger'),
        leading: BackButton(
            color: Colors.white,
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Dashboard()))),
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
