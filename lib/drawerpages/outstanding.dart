// import 'package:flutter/material.dart';
// import 'package:orderapp/bottomnavigation.dart';
// import 'package:orderapp/drawer.dart';

// class Outstanding extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blueAccent[700],
//         title: const Text('Outstanding Balance'),
//       ),
//       drawer: MyDrawer(),
//       bottomNavigationBar: BottomNavigation(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/drawer.dart';
// import 'package:orderapp/splashscreen.dart';

class Outstanding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        title: const Text('Outstanding Balance'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.02),
            // TEXT BOX WITH SEARCH ICON
            // Container(
            //   color: Colors.white,
            //   alignment: Alignment.centerLeft,
            //   padding: EdgeInsets.symmetric(horizontal: 40),
            //   child: Center(
            //     child: TextField(
            //       decoration: InputDecoration(
            //         labelText: "Order Search",
            //         // prefixIcon: Icon(Icons.search),
            //         suffixIcon: Icon(Icons.search),
            //         // border: InputBorder.none,
            //         border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(10.0),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // TEXT BOX WITH SEARCH ICON
            SizedBox(height: size.height * 0.05),
            Container(
              alignment: Alignment.center,
              color: Colors.white,
              child: ElevatedButton(
                child: Text('Print Outstanding Report'),
                // onPressed: () {
                //   print('Pressed');
                // },
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    textStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    shape: StadiumBorder()),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            DataTable(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black38)),
              columns: [
                DataColumn(
                    label: Text(
                  'ID',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
                DataColumn(
                    label: Text('Item Name',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Qty',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('1')),
                  DataCell(Text('Stephen')),
                  DataCell(Text('200')),
                ]),
                DataRow(cells: [
                  DataCell(Text('5')),
                  DataCell(Text('John')),
                  DataCell(Text('300')),
                ]),
                DataRow(cells: [
                  DataCell(Text('10')),
                  DataCell(Text('Harry')),
                  DataCell(Text('400')),
                ]),
                DataRow(cells: [
                  DataCell(Text('15')),
                  DataCell(Text('Peter')),
                  DataCell(Text('500')),
                ]),
              ],
            ),
          ],
        ),
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
