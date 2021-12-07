import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/drawer.dart';
//import 'package:date_field/date_field.dart';

class PurchaseHistory extends StatefulWidget {
  @override
  _PurchaseHistoryState createState() => _PurchaseHistoryState();
}

class _PurchaseHistoryState extends State<PurchaseHistory> {
  @override
  Widget build(BuildContext context) {
    int _radioValue = 0;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        title: const Text('PurchaseHistory'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.02),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 70),
              child: DropdownButton<String>(
                isExpanded: true,
                icon: Icon(Icons.arrow_drop_down_circle),
                style: TextStyle(color: Colors.green, fontSize: 22),
                // hint: Text("Select item"),
                items: [
                  DropdownMenuItem<String>(
                    child: Text('Product 1'),
                    value: 'one',
                  ),
                  DropdownMenuItem<String>(
                    child: Text('Product 2'),
                    value: 'two',
                  ),
                  DropdownMenuItem<String>(
                    child: Text('Product 3'),
                    value: 'three',
                  ),
                ],
                onChanged: (String? value) {},
                hint: Text('Select Category'),
                //value: _value,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Radio(
                  value: 0,
                  groupValue: _radioValue,
                  onChanged: null,
                ),
                new Text(
                  'Detail',
                  style: new TextStyle(fontSize: 16.0),
                ),
                SizedBox(width: size.width * 0.2),
                new Radio(
                  value: 1,
                  groupValue: _radioValue,
                  onChanged: null,
                ),
                new Text(
                  'Summary',
                  style: new TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              // width: 100.0,
              alignment: Alignment.center,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: DateTimeFormField(
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.black45),
                  errorStyle: TextStyle(color: Colors.redAccent),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.event_note),
                  labelText: 'From Date:',
                ),
                mode: DateTimeFieldPickerMode.date,
                autovalidateMode: AutovalidateMode.always,
                validator: (e) =>
                    (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                onDateSelected: (DateTime value) {
                  print(value);
                },
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Container(
              // width: 100.0,
              alignment: Alignment.center,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: DateTimeFormField(
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.black45),
                  errorStyle: TextStyle(color: Colors.redAccent),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.event_note),
                  labelText: 'To Date:',
                ),
                mode: DateTimeFieldPickerMode.date,
                autovalidateMode: AutovalidateMode.always,
                validator: (e) =>
                    (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                onDateSelected: (DateTime value) {
                  print(value);
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Container(
              alignment: Alignment.center,
              color: Colors.white,
              child: ElevatedButton(
                child: Text('Get Report'),
                // onPressed: () {
                //   print('Pressed');
                // },
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    shape: StadiumBorder()),
              ),
            ),
            SizedBox(height: size.height * 0.05),
          ],
        ),
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
