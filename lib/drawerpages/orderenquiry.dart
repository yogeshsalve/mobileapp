import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/drawer.dart';

class OrderEnquiry extends StatefulWidget {
  @override
  _OrderEnquiryState createState() => _OrderEnquiryState();
}

class _OrderEnquiryState extends State<OrderEnquiry> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        title: const Text('Order Enquiry'),
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
                    labelText: "Item/Order Search",
                    // prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.search),
                    // border: InputBorder.none,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Container(
              alignment: Alignment.center,
              color: Colors.white,
              child: ElevatedButton(
                child: Text('Print Report'),
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
              columnSpacing: 0,
              columns: [
                DataColumn(
                    label: Text(
                  'Sr.No',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                DataColumn(
                    label: Text('Head',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Description',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('1')),
                  DataCell(Text('Order No')),
                  DataCell(Text('......')),
                ]),
                DataRow(cells: [
                  DataCell(Text('2')),
                  DataCell(Text('Customer Order No.')),
                  DataCell(Text('......')),
                ]),
                DataRow(cells: [
                  DataCell(Text('3')),
                  DataCell(Text('On Hold')),
                  DataCell(Text('......')),
                ]),
                DataRow(cells: [
                  DataCell(Text('4')),
                  DataCell(Text('On Reference')),
                  DataCell(Text('......')),
                ]),
                DataRow(cells: [
                  DataCell(Text('5')),
                  DataCell(Text('Order Description')),
                  DataCell(Text('......')),
                ]),
                DataRow(cells: [
                  DataCell(Text('6')),
                  DataCell(Text('Order Date')),
                  DataCell(Text('......')),
                ]),
                DataRow(cells: [
                  DataCell(Text('7')),
                  DataCell(Text('Expected Ship Date')),
                  DataCell(Text('......')),
                ]),
                DataRow(cells: [
                  DataCell(Text('8')),
                  DataCell(Text('Order Total')),
                  DataCell(Text('......')),
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
