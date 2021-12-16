import 'dart:convert';
// import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/dashboard.dart';
import 'package:orderapp/drawer.dart';
import 'package:orderapp/mobile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PrintInvoice2 extends StatefulWidget {
  @override
  _PrintInvoice2State createState() => _PrintInvoice2State();
}

class _PrintInvoice2State extends State<PrintInvoice2> {
  final myController1 = TextEditingController();
  String userCookie = '';
  List products = [
    {
      "amount_outstanding": "-",
      "days_overdue": "-",
      "due_date": "-",
      "invoice_amount": "-",
      "invoice_date": "-",
      "invoice_id": "-",
      "po_number": "-",
      "reference": "-"
    }
  ];

  @override
  void initState() {
    super.initState();
    this.fetchProduct();
  }

  fetchProduct() async {
    // ---------------token-------------------
    final SharedPreferences pref = await SharedPreferences.getInstance();
    userCookie = pref.getString('userCookiekey')!;
    setState(() {});
    print(userCookie);
    // -------------token ------------------------

    var url = Uri.parse('http://114.143.151.6:901/balance-list');
    var response = await http.post(url,
        body: {"limit": "500", "page": "1"}, headers: {'Cookie': userCookie});

    if (response.statusCode == 200) {
      var items = jsonDecode(response.body);
      //print(items);
      List products2 = [];
      for (var item in items) {
        if (item["invoice_id"] == myController1.text)
          //   print(item);
          products2.add(item);
      }
      // print(products2);
      setState(() {
        products = products2;
      });
    } else
      setState(() {
        products = [
          {
            "amount_outstanding": "-",
            "days_overdue": "-",
            "due_date": "-",
            "invoice_amount": "-",
            "invoice_date": "-",
            "invoice_id": "-",
            "po_number": "-",
            "reference": "-"
          }
        ];
      });

    print(products);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments.toString();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: size.width * 0.5,
                      child: Text("Invoice Data"),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.02),
            Container(
              //color: Colors.white,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Center(
                child: TextField(
                  readOnly: true,
                  controller: myController1..text = args,
                  decoration: InputDecoration(
                    labelText: "Inovice Search",
                    // prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      onPressed: () {
                        fetchProduct();
                      },
                      icon: Icon(Icons.search),
                    ),
                    // border: InputBorder.none,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            const Divider(
              // height: 20,
              thickness: 2,
              indent: 0,
              endIndent: 0,
              color: Colors.grey,
            ),
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
            // Container(
            //   // width: 100.0,
            //   alignment: Alignment.center,
            //   //color: Colors.white,
            //   padding: EdgeInsets.symmetric(horizontal: 40),
            //   child: DateTimeFormField(
            //     decoration: InputDecoration(
            //       hintStyle: TextStyle(color: Colors.black45),
            //       errorStyle: TextStyle(color: Colors.redAccent),
            //       border: OutlineInputBorder(),
            //       suffixIcon: Icon(Icons.event_note),
            //       labelText: 'From Date:',
            //     ),
            //     mode: DateTimeFieldPickerMode.date,
            //     autovalidateMode: AutovalidateMode.always,
            //     validator: (e) =>
            //         (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
            //     onDateSelected: (DateTime value) {
            //       print(value);
            //     },
            //   ),
            // ),
            // SizedBox(height: size.height * 0.02),
            // Container(
            //   // width: 100.0,
            //   alignment: Alignment.center,
            //   //color: Colors.white,
            //   padding: EdgeInsets.symmetric(horizontal: 40),
            //   child: DateTimeFormField(
            //     decoration: InputDecoration(
            //       hintStyle: TextStyle(color: Colors.black45),
            //       errorStyle: TextStyle(color: Colors.redAccent),
            //       border: OutlineInputBorder(),
            //       suffixIcon: Icon(Icons.event_note),
            //       labelText: 'To Date:',
            //     ),
            //     mode: DateTimeFieldPickerMode.date,
            //     autovalidateMode: AutovalidateMode.always,
            //     validator: (e) =>
            //         (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
            //     onDateSelected: (DateTime value) {
            //       print(value);
            //     },
            //   ),
            // ),
            // SizedBox(
            //   height: size.height * 0.01,
            // ),
            // Container(
            //   alignment: Alignment.center,
            //   //color: Colors.white,
            //   child: ElevatedButton(
            //     child: Text('Get Report'),
            //     // onPressed: () {
            //     //   print('Pressed');
            //     // },
            //     onPressed: () {
            //       fetchProduct();
            //     },
            //     style: ElevatedButton.styleFrom(
            //         primary: Colors.deepPurple,
            //         padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            //         textStyle:
            //             TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            //         shape: StadiumBorder()),
            //   ),
            // ),
            SizedBox(height: size.height * 0.05),
            DataTable(
              headingRowColor: MaterialStateColor.resolveWith(
                  (states) => Colors.grey.shade400),
              columns: [
                DataColumn(
                    label: Text(
                  'Sr.no',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
                DataColumn(
                    label: Text('Head',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Value',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('1')),
                  DataCell(Text('Invoice Id')),
                  DataCell(Text(products[0]["invoice_id"].toString())),
                ]),
                DataRow(cells: [
                  DataCell(Text('2')),
                  DataCell(Text('Outstanding Amount')),
                  DataCell(Text(products[0]["amount_outstanding"].toString())),
                ]),
                DataRow(cells: [
                  DataCell(Text('3')),
                  DataCell(Text('Overdue Days')),
                  DataCell(Text(products[0]["days_overdue"].toString())),
                ]),
                DataRow(cells: [
                  DataCell(Text('4')),
                  DataCell(Text('Due Date')),
                  DataCell(Text(products[0]["due_date"].toString())),
                ]),
                DataRow(cells: [
                  DataCell(Text('5')),
                  DataCell(Text('Invoice Amount')),
                  DataCell(Text(products[0]["invoice_amount"].toString())),
                ]),
                DataRow(cells: [
                  DataCell(Text('6')),
                  DataCell(Text('Invoice Date')),
                  DataCell(Text(products[0]["invoice_date"].toString())),
                ]),
                DataRow(cells: [
                  DataCell(Text('7')),
                  DataCell(Text('Po Number')),
                  DataCell(Text(products[0]["po_number"].toString())),
                ]),
                DataRow(cells: [
                  DataCell(Text('8')),
                  DataCell(Text('Reference')),
                  DataCell(Text(products[0]["reference"].toString())),
                ]),
              ],
            ),
          ],
        ),
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigation(),
      backgroundColor: Colors.white,
    );
  }

  Future<void> _createPDF() async {
    PdfDocument document = PdfDocument();
    //final page = document.pages.add();
    // page.graphics
    //     .drawString("Welcome", PdfStandardFont(PdfFontFamily.helvetica, 30));

    //*********************************************
    PdfGrid grid = PdfGrid();
    grid.columns.add(count: 8);
    grid.headers.add(1);
    PdfGridRow header = grid.headers[0];
    header.cells[0].value = "Invoice Id";
    header.cells[1].value = "Outstanding Amount";
    header.cells[2].value = "Overdue Days";
    header.cells[3].value = "Due Date";
    header.cells[4].value = "Invoice Amount";
    header.cells[5].value = "Invoice Date";
    header.cells[6].value = "Po Number";
    header.cells[7].value = "Reference";
    //*********************************************

    PdfGridRow row = grid.rows.add();
    row.cells[0].value = products[0]["invoice_id"].toString();
    row.cells[1].value = products[0]["amount_outstanding"].toString();
    row.cells[2].value = products[0]["days_overdue"].toString();
    row.cells[3].value = products[0]["due_date"].toString();
    row.cells[4].value = products[0]["invoice_amount"].toString();
    row.cells[5].value = products[0]["invoice_date"].toString();
    row.cells[6].value = products[0]["po_number"].toString();
    row.cells[7].value = products[0]["reference"].toString();
    grid.draw(
        page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));
    List<int> bytes = document.save();
    document.dispose();
    saveAndLaunchFile(bytes, 'Invoice Report.pdf');
  }
}
