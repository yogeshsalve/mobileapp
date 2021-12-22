import 'dart:convert';

// import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:orderapp/drawerpages/newinvoicedata.dart';
import 'package:orderapp/drawerpages/taxinvoice.dart';
import 'package:orderapp/invoicepdf/pdf_page.dart';
import 'package:orderapp/bottomnavigation.dart';
// import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/dashboard.dart';
// import 'package:orderapp/drawerpages/orderenquiry2.dart';
import 'package:orderapp/drawerpages/printinvoice2.dart';

import 'package:shared_preferences/shared_preferences.dart';
// import 'package:orderapp/splashscreen.dart';
// import 'package:orderapp/drawer.dart';
// import 'package:orderapp/api/model/pdf_page.dart';
import 'package:http/http.dart' as http;
// ignore: unused_import
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PrintInvoice extends StatefulWidget {
  @override
  _PrintInvoiceState createState() => _PrintInvoiceState();
}

class _PrintInvoiceState extends State<PrintInvoice> {
  final myController1 = TextEditingController();
  String userCookie = '';
  List items3 = [];
  List products = [
    // {
    //   "amount_outstanding": "-",
    //   "days_overdue": "-",
    //   "due_date": "-",
    //   "invoice_amount": "-",
    //   "invoice_date": "-",
    //   "invoice_id": "-",
    //   "po_number": "-",
    //   "reference": "-"
    // }
  ];
  @override
  void initState() {
    super.initState();
    fetchProduct();
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
    items3.clear();
    if (response.statusCode == 200) {
      var items = jsonDecode(response.body);
      //print(items);
      List products2 = [];
      for (var item in items) {
        // if (item["invoice_id"] == myController1.text)
        //   print(item);
        products2.add(item);
      }
      // print(products2);
      setState(() {
        items3 = products2;
        products = products2;
      });
    } else
      setState(() {
        products = [
          // {
          //   "amount_outstanding": "-",
          //   "days_overdue": "-",
          //   "due_date": "-",
          //   "invoice_amount": "-",
          //   "invoice_date": "-",
          //   "invoice_id": "-",
          //   "po_number": "-",
          //   "reference": "-"
          // }
        ];
      });

    print(products);
    print(items3);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[850],
          title: const Text('Invoice Print'),
          leading: BackButton(
              color: Colors.white,
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Dashboard()))),
        ),
        bottomNavigationBar: BottomNavigation(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.02),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: TextField(
                    controller: myController1,
                    onChanged: (text) {
                      text.toLowerCase();
                      setState(() {
                        products = items3.where((items3) {
                          items3 = items3.toString();
                          items3 = items3.toLowerCase();
                          return items3.contains(text.toString());
                        }).toList();
                      });

                      // setState(() {
                      //   products = items3
                      //       .where((items3) =>
                      //           items3['invoice_date'] >= "20191017" &&
                      //           items3['invice_date'] <= "20191020")
                      //       .toList();
                      // });
                    },
                    decoration: InputDecoration(
                      labelText: "Inovice Search",

                      suffixIcon: InkWell(
                        child: Icon(Icons.search),
                        // onTap: () {
                        //   Navigator.of(context)
                        //       .pushReplacement(MaterialPageRoute(
                        //     builder: (BuildContext context) => PrintInvoice2(),
                        //     settings:
                        //         RouteSettings(arguments: myController1.text),
                        //   ));
                        // },
                      ),
                      // border: InputBorder.none,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              const Divider(
                // height: 20,
                thickness: 2,
                indent: 0,
                endIndent: 0,
                color: Colors.grey,
              ),
              // SizedBox(height: size.height * 0.01),
              // Container(
              //   child: Text(
              //     "--- Search Invoice Data By Date ---",
              //     style: TextStyle(color: Colors.green, fontSize: 18),
              //   ),
              // ),
              // SizedBox(height: size.height * 0.01),
              // from date to date in a single line
              // Container(
              //   color: Colors.white,
              //   child: Row(
              //     // mainAxisSize: MainAxisSize.min,
              //     children: <Widget>[
              //       Expanded(
              //         child: new Padding(
              //           padding: const EdgeInsets.all(5.0),
              //           child: DateTimeFormField(
              //             decoration: InputDecoration(
              //               hintStyle: TextStyle(color: Colors.black45),
              //               errorStyle: TextStyle(color: Colors.redAccent),
              //               border: OutlineInputBorder(),
              //               suffixIcon: Icon(Icons.event_note),
              //               labelText: 'From Date:',
              //             ),
              //             mode: DateTimeFieldPickerMode.date,
              //             autovalidateMode: AutovalidateMode.always,
              //             validator: (e) => (e?.day ?? 0) == 1
              //                 ? 'Please not the first day'
              //                 : null,
              //             onDateSelected: (DateTime value) {
              //               print(value);
              //             },
              //           ),
              //         ),
              //       ),
              //       Expanded(
              //         child: new Padding(
              //           padding: const EdgeInsets.all(5.0),
              //           child: DateTimeFormField(
              //             decoration: InputDecoration(
              //               hintStyle: TextStyle(color: Colors.black45),
              //               errorStyle: TextStyle(color: Colors.redAccent),
              //               border: OutlineInputBorder(),
              //               suffixIcon: Icon(Icons.event_note),
              //               labelText: 'To Date:',
              //             ),
              //             mode: DateTimeFieldPickerMode.date,
              //             autovalidateMode: AutovalidateMode.always,
              //             validator: (e) => (e?.day ?? 0) == 1
              //                 ? 'Please not the first day'
              //                 : null,
              //             onDateSelected: (DateTime value) {
              //               print(value);
              //             },
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                alignment: Alignment.center,
                //color: Colors.white,
                // width: size.width * 0.8,
                child: ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon(
                      //   Icons.download,
                      //   // color: Colors.black,
                      // ),
                      Text(
                        'List of Invoices',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  onPressed: () {
                    // _createPDF();

                    fetchProduct();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    // shape: StadiumBorder()
                  ),
                ),
              ),
              Container(
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PdfPage1()),
                      );
                      // PdfPage();
                    },
                    child: Text("Invoice")),
              ),

              Container(
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InvoiceData()),
                      );
                      // PdfPage();
                    },
                    child: Text("InvoiceData")),
              ),
              SizedBox(height: size.height * 0.02),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: MaterialStateColor.resolveWith(
                      (states) => Colors.grey.shade400),
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        'Inv No',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    // DataColumn(
                    //   label: Text(
                    //     'Action',
                    //     style: TextStyle(fontStyle: FontStyle.italic),
                    //   ),
                    // ),
                    DataColumn(
                      label: Text(
                        'Inv Date',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Due Date',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Party PO Number.',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Inv Amount',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Overdue Days',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Outstanding Amount',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Invoice Print',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                  // for ( 1==1)

                  rows: <DataRow>[
                    for (var p in products)
                      DataRow(
                        cells: <DataCell>[
                          DataCell(
                            InkWell(
                                child: Text(
                              p["invoice_id"].toString(),
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )),
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    PrintInvoice2(),
                                settings: RouteSettings(
                                    arguments: p["invoice_id"].toString()),
                              ));
                            },
                          ),
                          // DataCell(
                          //   IconButton(
                          //     icon: Icon(
                          //       Icons.file_present,
                          //     ),
                          //     iconSize: 30,
                          //     color: Colors.black,
                          //     splashColor: Colors.purple,
                          //     onPressed: () {
                          //       Navigator.of(context)
                          //           .pushReplacement(MaterialPageRoute(
                          //         builder: (BuildContext context) =>
                          //             OrderEnquiry2(),
                          //         settings: RouteSettings(
                          //             arguments: p["orduniq"].toString()),
                          //       ));
                          //     },
                          //   ),
                          // ),
                          DataCell(Text(p["invoice_date"].toString())),
                          DataCell(Text(p["due_date"].toString())),
                          DataCell(Text(p["po_number"].toString())),
                          DataCell(Text(p["invoice_amount"].toString())),
                          DataCell(Text(p["days_overdue"].toString())),
                          DataCell(Text(p["amount_outstanding"].toString())),
                          DataCell(
                            IconButton(
                              icon: Icon(
                                Icons.print,
                              ),
                              iconSize: 30,
                              color: Colors.black,
                              splashColor: Colors.purple,
                              onPressed: () {
                                // _createPDF();
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      TaxInvoice(),
                                  settings: RouteSettings(
                                      arguments: p["invoice_id"].toString()),
                                ));
                              },
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),

              //----- circular indicator ---------------
              if (products.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(160.0),
                  child: Center(
                    child: SizedBox(
                      child: CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),
              //----------
              //----
              // DataTable(
              //   columns: [
              //     DataColumn(
              //         label: Text(
              //       'Sr.no',
              //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              //     )),
              //     DataColumn(
              //         label: Text('Head',
              //             style: TextStyle(
              //                 fontSize: 18, fontWeight: FontWeight.bold))),
              //     DataColumn(
              //         label: Text('Value',
              //             style: TextStyle(
              //                 fontSize: 18, fontWeight: FontWeight.bold))),
              //   ],
              //   rows: [
              //     DataRow(cells: [
              //       DataCell(Text('1')),
              //       DataCell(Text('Invoice Id')),
              //       DataCell(Text(products[0]["invoice_id"].toString())),
              //     ]),
              //     DataRow(cells: [
              //       DataCell(Text('2')),
              //       DataCell(Text('Outstanding Amount')),
              //       DataCell(
              //           Text(products[0]["amount_outstanding"].toString())),
              //     ]),
              //     DataRow(cells: [
              //       DataCell(Text('3')),
              //       DataCell(Text('Overdue Days')),
              //       DataCell(Text(products[0]["days_overdue"].toString())),
              //     ]),
              //     DataRow(cells: [
              //       DataCell(Text('4')),
              //       DataCell(Text('Due Date')),
              //       DataCell(Text(products[0]["due_date"].toString())),
              //     ]),
              //     DataRow(cells: [
              //       DataCell(Text('5')),
              //       DataCell(Text('Invoice Amount')),
              //       DataCell(Text(products[0]["invoice_amount"].toString())),
              //     ]),
              //     DataRow(cells: [
              //       DataCell(Text('6')),
              //       DataCell(Text('Invoice Date')),
              //       DataCell(Text(products[0]["invoice_date"].toString())),
              //     ]),
              //     DataRow(cells: [
              //       DataCell(Text('7')),
              //       DataCell(Text('Po Number')),
              //       DataCell(Text(products[0]["po_number"].toString())),
              //     ]),
              //     DataRow(cells: [
              //       DataCell(Text('8')),
              //       DataCell(Text('Reference')),
              //       DataCell(Text(products[0]["reference"].toString())),
              //     ]),
              //   ],
              // ),
            ],
          ),
          // drawer: MyDrawer(),
          // bottomNavigationBar: BottomNavigation(),
        ));
  }
}
