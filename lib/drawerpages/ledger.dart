import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/dashboard.dart';
import 'package:orderapp/drawer.dart';

class Ledger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        title: const Text('Ledger'),
        leading: BackButton(
            color: Colors.white,
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Dashboard()))),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            // Container(
            //   color: Colors.white,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       Text('hii'),
            //       Text('hello'),
            //     ],
            //   ),
            // ),
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
      // drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
