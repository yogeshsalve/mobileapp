// import 'package:flutter/material.dart';
// import 'package:orderapp/bottomnavigation.dart';
// import 'package:orderapp/drawer.dart';

// class PrintInvoice extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blueAccent[700],
//         title: const Text('Print Invoice'),
//       ),
//       drawer: MyDrawer(),
//       bottomNavigationBar: BottomNavigation(),
//     );
//   }
// }

import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/dashboard.dart';
// import 'package:orderapp/drawer.dart';

class PrintInvoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        title: const Text('Print Invoice'),
        leading: BackButton(
            color: Colors.white,
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Dashboard()))),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.02),
            Container(
              color: Colors.white,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Center(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Inovice Search",
                    // prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.search),
                    // border: InputBorder.none,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
              ),
            ),
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
            DataTable(
              columns: [
                DataColumn(
                    label: Text(
                  'ID',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
                DataColumn(
                    label: Text('Name',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Profession',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('1')),
                  DataCell(Text('Stephen')),
                  DataCell(Text('Actor')),
                ]),
                DataRow(cells: [
                  DataCell(Text('5')),
                  DataCell(Text('John')),
                  DataCell(Text('Student')),
                ]),
                DataRow(cells: [
                  DataCell(Text('10')),
                  DataCell(Text('Harry')),
                  DataCell(Text('Leader')),
                ]),
                DataRow(cells: [
                  DataCell(Text('15')),
                  DataCell(Text('Peter')),
                  DataCell(Text('Scientist')),
                ]),
              ],
            ),
          ],
        ),
      ),
      // drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
