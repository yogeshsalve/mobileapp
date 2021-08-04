import 'package:flutter/material.dart';

class MyDropDown extends StatefulWidget {
  @override
  _MyDropDownState createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  final List<String> subjects = [
    "ALL CATEGORIES",
    "ALLEN CAP",
    "BOLT",
    "NUT",
    "SCREW",
    "WASHER"
  ];

  String selectedSubject = "ALL CATEGORIES";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: selectedSubject,
              onChanged: (value) {
                setState(() {
                  selectedSubject = value!;
                });
              },
              items: subjects.map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem(
                  child: Text(value),
                  value: value,
                );
              }).toList(),
            ),
            Text(
              selectedSubject,
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900),
            )
          ],
        ),
      ),
    );
  }
}
