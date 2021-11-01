import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/dashboard.dart';
import 'package:orderapp/drawer.dart';
import 'package:http/http.dart' as http;
import 'package:orderapp/mobile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class OrderEnquiry extends StatefulWidget {
  @override
  _OrderEnquiryState createState() => _OrderEnquiryState();
}

class _OrderEnquiryState extends State<OrderEnquiry> {
  final myController1 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String userCookie = '';
  List products2 = [];
  List items3 = [];
  List productsdisplay = [
    {
      "discount": "0.000",
      "last_post_date": "00000",
      "order_number": "00000",
      "po_number": "00000",
      "ship_via_code": "00000",
      "ship_via_code_desc": "00000",
      "subtotal": "00000",
      "terms_code": "00000",
      "total_ex_tax": "00000",
      "total_in_tax": "00000",
      "total_tax": "00000"
    }
  ];

  @override
  void initState() {
    super.initState();
    postData();
  }

  postData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    // ---------------token-------------------
    // final SharedPreferences pref = await SharedPreferences.getInstance();
    userCookie = pref.getString('userCookiekey')!;
    setState(() {});

    print(userCookie);

    // -------------token ------------------------
    var url = Uri.parse("http://114.143.151.6:901/order-detail");
    var response = await http.post(url,
        body: {"orduniq": myController1.text}, headers: {'Cookie': userCookie});
    // myController1.text = "0000";
    print(response.body);

    items3.clear();
    if (response.statusCode == 200) {
      var items2 = jsonDecode(response.body);
      // print(items2);
      for (var item2 in items2) {
        products2.add(item2);
        // products2.add(item2['itemno']);
        setState(() {
          items3 = products2;
          productsdisplay = products2;
        });
      }
    }

    // items3 = items1;

    print(productsdisplay);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: size.width * 0.5,
                      child: Text("Order Enquiry"),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      //width: size.width * 0.5,
                      child: IconButton(
                        icon: Icon(Icons.file_download, color: Colors.white),
                        onPressed: () {
                          _createPDF();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ]),
        leading: BackButton(
            color: Colors.white,
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Dashboard()))),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                    controller: myController1..text,
                    decoration: InputDecoration(
                      labelText: "Item/Order Search",
                      // prefixIcon: Icon(Icons.search),
                      suffixIcon: IconButton(
                        onPressed: () {
                          postData();
                        },
                        icon: Icon(Icons.search),
                      ),
                      // border: InputBorder.none,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              DataTable(
                columnSpacing: 10,
                columns: [
                  DataColumn(
                      label: Text(
                    'No',
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
                    DataCell(Text('discount')),
                    DataCell(Text(productsdisplay[0]['discount'].toString())),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('2')),
                    DataCell(Text('last_post_date')),
                    DataCell(
                        Text(productsdisplay[0]['last_post_date'].toString())),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('3')),
                    DataCell(Text('order_number')),
                    DataCell(
                        Text(productsdisplay[0]['order_number'].toString())),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('4')),
                    DataCell(Text('po_number')),
                    DataCell(Text(productsdisplay[0]['po_number'].toString())),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('5')),
                    DataCell(Text('ship_via_code')),
                    DataCell(
                        Text(productsdisplay[0]['ship_via_code'].toString())),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('6')),
                    DataCell(Text('ship_via_code_desc')),
                    DataCell(Text(
                        productsdisplay[0]['ship_via_code_desc'].toString())),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('7')),
                    DataCell(Text('subtotal')),
                    DataCell(Text(productsdisplay[0]['subtotal'].toString())),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('8')),
                    DataCell(Text('terms_code')),
                    DataCell(Text(productsdisplay[0]['terms_code'].toString())),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('9')),
                    DataCell(Text('total_ex_tax')),
                    DataCell(
                        Text(productsdisplay[0]['total_ex_tax'].toString())),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('10')),
                    DataCell(Text('total_in_tax')),
                    DataCell(
                        Text(productsdisplay[0]['total_in_tax'].toString())),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('11')),
                    DataCell(Text('total_tax')),
                    DataCell(Text(productsdisplay[0]['total_tax'].toString())),
                  ]),
                ],
              ),
              SizedBox(height: size.height * 0.05),
              // Container(
              //   alignment: Alignment.center,
              //   color: Colors.white,
              //   child: ElevatedButton(
              //     child: Text('Print Report'),
              //     onPressed: () {
              //       postData();
              //     },
              //     style: ElevatedButton.styleFrom(
              //         primary: Colors.deepPurple,
              //         padding:
              //             EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              //         textStyle:
              //             TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              //         shape: StadiumBorder()),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigation(),
    );
  }

  Future<void> _createPDF() async {
    PdfDocument document = PdfDocument();
    //final page = document.pages.add();
    // page.graphics
    //     .drawString("Welcome", PdfStandardFont(PdfFontFamily.helvetica, 30));

    // *******************************
    PdfGrid grid = PdfGrid();
    grid.columns.add(count: 3);
    grid.headers.add(1);
    //grid.columns[1].width = 50;
    PdfGridRow header = grid.headers[0];
    header.cells[0].value = "No";
    header.cells[1].value = "Head";
    header.cells[2].value = "Description";

    // *******************************

    PdfGridRow row = grid.rows.add();
    row.cells[0].value = "1";
    row.cells[1].value = "discount";
    row.cells[2].value = productsdisplay[0]['discount'].toString();

    row = grid.rows.add();
    row.cells[0].value = "2";
    row.cells[1].value = "last_post_date";
    row.cells[2].value = productsdisplay[0]['last_post_date'].toString();

    row = grid.rows.add();
    row.cells[0].value = "3";
    row.cells[1].value = "order_number";
    row.cells[2].value = productsdisplay[0]['order_number'].toString();

    row = grid.rows.add();
    row.cells[0].value = "4";
    row.cells[1].value = "po_number";
    row.cells[2].value = productsdisplay[0]['po_number'].toString();

    row = grid.rows.add();
    row.cells[0].value = "5";
    row.cells[1].value = "ship_via_code:";
    row.cells[2].value = productsdisplay[0]['ship_via_code'].toString();

    row = grid.rows.add();
    row.cells[0].value = "6";
    row.cells[1].value = "ship_via_code_desc";
    row.cells[2].value = productsdisplay[0]['ship_via_code_desc'].toString();

    row = grid.rows.add();
    row.cells[0].value = "7";
    row.cells[1].value = "subtotal";
    row.cells[2].value = productsdisplay[0]['subtotal'].toString();

    row = grid.rows.add();
    row.cells[0].value = "8";
    row.cells[1].value = "terms_code";
    row.cells[2].value = productsdisplay[0]['terms_code'].toString();

    row = grid.rows.add();
    row.cells[0].value = "9";
    row.cells[1].value = "total_ex_tax";
    row.cells[2].value = productsdisplay[0]['total_ex_tax'].toString();

    row = grid.rows.add();
    row.cells[0].value = "10";
    row.cells[1].value = "total_in_tax";
    row.cells[2].value = productsdisplay[0]['total_in_tax'].toString();

    row = grid.rows.add();
    row.cells[0].value = "11";
    row.cells[1].value = "total_tax";
    row.cells[2].value = productsdisplay[0]['total_tax'].toString();
    grid.style = PdfGridStyle(
        cellPadding: PdfPaddings(left: 2, right: 3, top: 4, bottom: 5),
        backgroundBrush: PdfBrushes.white,
        textBrush: PdfBrushes.black,
        font: PdfStandardFont(PdfFontFamily.timesRoman, 25));
    grid.draw(
        page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));
    List<int> bytes = document.save();
    document.dispose();
    saveAndLaunchFile(bytes, 'Order Details Report.pdf');
  }
}
