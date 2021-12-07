import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/drawer.dart';

class Obreport extends StatefulWidget {
  @override
  _ObreportState createState() => _ObreportState();
}

class _ObreportState extends State<Obreport> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments.toString();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        title: const Text('Obreport'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [Text(args)],
          ),
        ),
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
