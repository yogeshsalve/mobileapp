import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/dashboard.dart';
// import 'package:orderapp/drawer.dart';
import 'package:http/http.dart' as http;
import 'package:orderapp/drawerpages/newoutstanding.dart';
// import 'package:orderapp/drawerpages/obreport.dart';
import 'package:orderapp/mobile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
// import 'package:orderapp/splashscreen.dart';

class Outstanding extends StatefulWidget {
  @override
  _OutstandingState createState() => _OutstandingState();
}

class _OutstandingState extends State<Outstanding> {
  String userCookie = '';
  List products = [];

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
    fetchProduct();
  }

  postData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    // ---------------token-------------------
    // final SharedPreferences pref = await SharedPreferences.getInstance();
    userCookie = pref.getString('userCookiekey')!;
    setState(() {});
    print(userCookie);
    // -------------token ------------------------
    var url = Uri.parse("http://114.143.151.6:901/balance-summary");
    var response = await http.post(url, headers: {'Cookie': userCookie});
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
      print(items);
      List products2 = [];
      for (var item in items) {
        //   print(item);
        products2.add(item);
      }
      // print(products2);
      setState(() {
        products = products2;
      });
    } else
      setState(() {
        products = [];
      });

    print(products);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: const Text('Outstanding Balance'),
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
            SizedBox(height: size.height * 0.05),
            DataTable(
              // headingRowColor: MaterialStateColor.resolveWith((states) {return HexColor('#222D65');},),
              headingRowColor: MaterialStateColor.resolveWith(
                  (states) => Colors.grey.shade300),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black38)),
              columns: [
                DataColumn(
                    label: Text(
                  'ID',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.green[600],
                      fontWeight: FontWeight.bold),
                )),
                DataColumn(
                    label: Text('Outstanding',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.green[600],
                            fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Unpaid',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.green[600],
                            fontWeight: FontWeight.bold))),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('1')),
                  DataCell(Text(productsdisplay[0]['outstanding'].toString())),
                  DataCell(Text(productsdisplay[0]['unpaid'].toString())),
                ]),
              ],
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              //color: Colors.white,
              width: size.width * 0.9,
              child: ElevatedButton(
                child: Row(
                  children: [
                    // Icon(
                    //   Icons.print,
                    //   // color: Colors.black,
                    // ),
                    Text(
                      'Generate Outstanding Report',
                      // style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                onPressed: () {
                  // _createPDF();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OutstandingData()),
                  );
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
            // Divider(),
            SizedBox(height: size.height * 0.02),

            //TEST FOR OUTSTADNING API

            // Container(
            //   child: InkWell(
            //       onTap: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => OutstandingData()),
            //         );
            //         // PdfPage();
            //       },
            //       child: Text("OutstandingData")),
            // ),

            //ABOVE IS F TEST OUTSTANDING API BY PRAJKTA

            const Divider(
              height: 20,
              thickness: 2,
              indent: 0,
              endIndent: 0,
              color: Colors.grey,
            ),
            SizedBox(height: size.height * 0.02),
            Column(
              children: [
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.grey.shade400),
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text(
                            'Inv No.',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
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
                            'Po Number',
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
                        // DataColumn(
                        //   label: Text(
                        //     'Print',
                        //     style: TextStyle(fontStyle: FontStyle.italic),
                        //   ),
                        // ),

                        // DataColumn(
                        //   label: Text(
                        //     'Inv Date',
                        //     style: TextStyle(fontStyle: FontStyle.italic),
                        //   ),
                        // ),

                        // DataColumn(
                        //   label: Text(
                        //     'Reference',
                        //     style: TextStyle(fontStyle: FontStyle.italic),
                        //   ),
                        // ),
                      ],
                      rows: <DataRow>[
                        for (var p in products)
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text(
                                p["invoice_id"].toString(),
                                style: TextStyle(fontStyle: FontStyle.italic),
                              )),
                              DataCell(Text(
                                p["invoice_date"].toString(),
                                style: TextStyle(fontStyle: FontStyle.italic),
                              )),
                              DataCell(Text(
                                p["due_date"].toString(),
                                style: TextStyle(fontStyle: FontStyle.italic),
                              )),
                              DataCell(Text(
                                p["po_number"].toString(),
                                style: TextStyle(fontStyle: FontStyle.italic),
                              )),
                              DataCell(Text(
                                p["invoice_amount"].toString(),
                                style: TextStyle(fontStyle: FontStyle.italic),
                              )),
                              DataCell(Text(
                                p["overdue days"].toString(),
                                style: TextStyle(fontStyle: FontStyle.italic),
                              )),
                              DataCell(Text(
                                p["amount_outstanding"].toString(),
                                style: TextStyle(fontStyle: FontStyle.italic),
                              )),
                            ],
                          ),
                      ],
                      columnSpacing: 30,
                      horizontalMargin: 10,
                      // rowsPerPage: 8,
                      showCheckboxColumn: false,
                    ))
              ],
            ),
          ],
        ),
      ),
      // drawer: MyDrawer(),
      //bottomNavigationBar: BottomNavigation(),
    );
  }

  Future<void> _createPDF() async {
    PdfDocument document = new PdfDocument();

    //final page = document.pages.add();
    // page.graphics
    //     .drawString("Welcome", PdfStandardFont(PdfFontFamily.helvetica, 30));

    // *******************************

    PdfGrid grid = PdfGrid();
    grid.columns.add(count: 3);
    grid.headers.add(1);
    //grid.columns[1].width = 50;
    PdfGridRow header = grid.headers[0];
    header.cells[0].value = "ID";
    header.cells[1].value = "Outstanding";
    header.cells[2].value = "Unpaid";

    // *******************************

    PdfGridRow row = grid.rows.add();
    row.cells[0].value = "1";
    row.cells[1].value = productsdisplay[0]['outstanding'].toString();
    row.cells[2].value = productsdisplay[0]['unpaid'].toString();

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
