import 'package:flutter/material.dart';
import 'package:orderapp/drawerpages/printinvoice.dart';

import 'package:flutter/rendering.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class TaxInvoice extends StatelessWidget {
  // const TaxInvoice({Key? key}) : super(key: key);

  final GlobalKey<State<StatefulWidget>> _printKey = GlobalKey();

//---------------
  void _printScreen() {
    Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
      final doc = pw.Document();

      final image = await WidgetWraper.fromKey(
        key: _printKey,
        pixelRatio: 2.0,
      );

      doc.addPage(pw.Page(
          pageFormat: format,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Expanded(
                child: pw.Image(image),
              ),
            );
          }));

      return doc.save();
    });
  }

//-----------------

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent[700],
          title: const Text('TAX INVOICE'),
          leading: BackButton(
              color: Colors.white,
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PrintInvoice()))),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.09,
                // width: MediaQuery.of(context).size.width * 0.6,
                color: Colors.white,
                alignment: Alignment.center,
                child: Text(
                  "TAX INVOICE",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            color: Colors.white,
                            alignment: Alignment.topCenter,
                            child: Text("LOGO"),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            color: Colors.white,
                            alignment: Alignment.topCenter,
                            child: Text(
                              "GSTIN : 27AAACA4710A1ZH \nPan No: AAACA4710A \nCIN No. : U28932MH1897PTC043152",
                              style: TextStyle(
                                fontSize: 7,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            color: Colors.white,
                            alignment: Alignment.topLeft,
                            child: Text("AGARWAL FASTNERS PVT. LTD"),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Container(
                            color: Colors.white,
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Plot No. 11, Manor - Palghar Road, Chahade Village, Taluka \nPalghar, Dist.Palghar, Maharashtra - India - Pin Code : 401404 \nTel No.: 02525-657001/02 Email:sales@aplhome.com, State Code:27",
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: Text(""),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: Text(""),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //2nd row
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.white,
                alignment: Alignment.topLeft,
                // child: Text("Second row"),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Table(
                    // defaultColumnWidth: IntrinsicColumnWidth(),
                    border: TableBorder.all(color: Colors.black),
                    columnWidths: {
                      0: FixedColumnWidth(140.0), // fixed to 100 width
                      1: FlexColumnWidth(),
                      2: FixedColumnWidth(80.0),
                      3: FixedColumnWidth(80.0) //fixed to 100 width
                    },
                    // textDirection: TextDirection.rtl,
                    // defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                    // border:TableBorder.all(width: 2.0,color: Colors.red),
                    children: [
                      TableRow(children: [
                        Text(
                          "Billing Address",
                          textScaleFactor: 0.8,
                        ),
                        Text(
                          "SHIP TO",
                          textScaleFactor: 0.8,
                        ),
                        Text("", textScaleFactor: 0.2),
                        Text("", textScaleFactor: 0.2),
                      ]),
                      TableRow(children: [
                        Text(
                          "M/S. VIMAL INDUSTRIAL CORPORATION",
                          textScaleFactor: 0.5,
                        ),
                        Text("", textScaleFactor: 0.2),
                        Text("Invoice No : 22/010001", textScaleFactor: 0.5),
                        Text("Date: 29/09/2021", textScaleFactor: 0.5),
                      ]),
                      TableRow(children: [
                        Text("B.Tech", textScaleFactor: 0.5),
                        Text("ABESEC", textScaleFactor: 0.5),
                        Text("Order No: 00152821", textScaleFactor: 0.5),
                        Text("", textScaleFactor: 0.5),
                      ]),
                      TableRow(children: [
                        Text(
                          "Billing Address",
                          textScaleFactor: 0.5,
                        ),
                        Text("", textScaleFactor: 0.5),
                        Text("PO No.", textScaleFactor: 0.5),
                        Text(" ", textScaleFactor: 0.5),
                      ]),
                      TableRow(children: [
                        Text(
                          "Billing Address",
                          textScaleFactor: 0.5,
                        ),
                        Text("SHIP TO", textScaleFactor: 0.5),
                        Text("Dispatch Through:", textScaleFactor: 0.5),
                        Text("", textScaleFactor: 0.5),
                      ]),
                      TableRow(children: [
                        Text(
                          "GSTIN: 27AARFV4705E1ZY ",
                          textScaleFactor: 0.5,
                        ),
                        Text("Email : vimal_ind@hotmail.com",
                            textScaleFactor: 0.5),
                        Text("Vehicle No:", textScaleFactor: 0.5),
                        Text("Ord Date: 07/08/2021", textScaleFactor: 0.5),
                      ]),
                    ],
                  ),
                ),
              ),
            ),

            //3rd row
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.amber,
                alignment: Alignment.center,
                child: Text("Third row"),
              ),
            ),

            //4th row
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.orange,
                alignment: Alignment.center,
                child: Text("Forth row"),
              ),
            ),

            //5th row
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.yellow,
                alignment: Alignment.center,
                child: Text("fifth row"),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.print),
          onPressed: _printScreen,
        ),
      ),
    );
  }
}
