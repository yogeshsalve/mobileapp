import 'dart:convert';
// import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';

import 'package:orderapp/drawer.dart';
import 'package:orderapp/drawerpages/printinvoice.dart';
import 'package:orderapp/mobile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdf/pdf.dart';
// import 'package:intl/intl.dart';

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

  List products3 = [];
  List productsdisplay = [];
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

  fetchInvoice() async {
    //final shinumber = products[0]["invoice_id"];
    final shinumber = "22/010001";
    var userCookie = "Basic QURNSU46dmlrcmFtQGFwbDEyMw==";
    var url = Uri.parse(
        'http://aplhome.info:701/AplReportsApi/api/Report/TaxInvoice?shinumber=$shinumber');
    //'http://172.16.1.101:701/AplReportsApi/api/Report/TaxInvoice?shinumber=$shinumber');
    var response = await http.get(url, headers: {'Authorization': userCookie});

    if (response.statusCode == 200) {
      var items = jsonDecode(jsonDecode(response.body));

      for (var item in items) {
        products3.add(item);
      }

      print(products3);
    }
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

              //FOR DOWNLOAD ICON BUTTON ON APPBAR
              // Container(
              //   child: Row(
              //     children: <Widget>[
              //       Container(
              //         //width: size.width * 0.5,
              //         child: IconButton(
              //           icon: Icon(Icons.file_download, color: Colors.white),
              //           onPressed: () {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) => InvoiceData()),
              //             );

              //             // _createPDF();
              //           },
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ]),
        leading: BackButton(
            color: Colors.white,
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => PrintInvoice()))),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.02),
            Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Text('hii'),

                  //---------------------------------------------
                  Container(
                    alignment: Alignment.center,
                    //color: Colors.white,
                    width: size.width * 0.8,
                    child: ElevatedButton(
                      child: Row(
                        children: [
                          // Icon(
                          //   Icons.print,
                          //   // color: Colors.black,
                          // ),
                          Text(
                            'Double Tap to Generate Invoice',
                            // style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      onPressed: () {
                        _createPDF();
                        fetchInvoice();
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          padding:
                              EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                          textStyle: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          shape: StadiumBorder()),
                    ),
                  ),
                  //---------------------------------------------
                  // Text(productsdisplay[0]["IDCUST"].toString()),
                  //----------------
                ],
              ),
            ),
            Visibility(
              visible: false,
              child: Container(
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
            ),
            SizedBox(height: size.height * 0.02),
            const Divider(
              // height: 20,
              thickness: 2,
              indent: 0,
              endIndent: 0,
              color: Colors.grey,
            ),
            // SizedBox(height: size.height * 0.05),
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

  //FOR PDF
  Future<void> _createPDF() async {
    PdfDocument document = new PdfDocument();

    //Adds page settings
    document.pageSettings.orientation = PdfPageOrientation.portrait;
    document.pageSettings.margins.all = 50;

    //Adds a page to the document
    PdfPage page = document.pages.add();
    PdfGraphics graphics = page.graphics;

    //Loads the image from base64 string
    PdfImage image = PdfBitmap.fromBase64String(
        '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');

    //Draws the image to the PDF page
    //for portrait
    page.graphics.drawImage(image, Rect.fromLTWH(0, 0, 450, 100));

    //for landscape
    //page.graphics.drawImage(image, Rect.fromLTWH(176, 0, 390, 130));

    // PdfBrush solidBrush = PdfSolidBrush(PdfColor(126, 151, 173));
    //PdfBrush solidBrush = PdfSolidBrush(PdfColor(256, 256, 173));

    Rect bounds = Rect.fromLTWH(0, 80, graphics.clientSize.width, 30);

    //Draws a rectangle to place the heading in that region
    // graphics.drawRectangle(brush: solidBrush, bounds: bounds);

    //Creates a font for adding the heading in the page
    PdfFont subHeadingFont = PdfStandardFont(PdfFontFamily.timesRoman, 10);

    PdfFont subHeadingFont1 = PdfStandardFont(PdfFontFamily.timesRoman, 8);

    //Creates a PDF grid
    PdfGrid grid = PdfGrid();

//Add the columns to the grid
    grid.columns.add(count: 3);

//Add rows to grid
    PdfGridRow row = grid.rows.add();
    row.cells[0].value =
        "Billing Address :\n" + products3[0]["SHPNAME"].toString();
    row.cells[1].value = "SHIP TO :";
    row.cells[2].value = "Invoice No.:" +
        products3[0]["SHINUMBER"].toString() +
        "Date:" +
        products3[0]["SHIDATE"].toString();

    PdfGridRow row1 = grid.rows.add();
    // // row1.cells[0].value = "";
    // // row1.cells[1].value = "";
    row1.cells[2].value = "INVOICE NO. 22/010001";

    PdfGridRow row2 = grid.rows.add();
    row2.cells[0].value = products3[0]["BILADDR1"].toString() +
        products3[0]["BILADDR2"].toString() +
        products3[0]["BILCITY"].toString() +
        products3[0]["BILSTATE"].toString() +
        products3[0]["BILZIP"].toString() +
        products3[0]["BILPHONE"].toString();
    row2.cells[1].value = "";
    row2.cells[2].value = "ORDER NO.:";

    PdfGridRow row3 = grid.rows.add();
    row3.cells[0].value = "";
    row3.cells[1].value = "";
    row3.cells[2].value = "PO NO. :";

    PdfGridRow row4 = grid.rows.add();
    row4.cells[0].value = "";
    row4.cells[1].value = "";
    row4.cells[2].value =
        "DISPATCH THROUGH " + products3[0]["VIADESC"].toString();

    PdfGridRow row5 = grid.rows.add();
    row5.cells[0].value = "GSTIN " + products3[0]["VALUE-Vw_GSTIN"].toString();

    row5.cells[1].value = "EMAIL " +
        products3[0]["BILEMAILC"].toString() +
        "STATE CODE :" +
        products3[0]["VALUE-Vw_StateCode"].toString();
    row5.cells[2].value =
        "VEHICLE NO." "\nORD DATE" + products3[0]["ORDDATE"].toString();

    //Set the row span
    row.cells[0].rowSpan = 2;
    row.cells[1].rowSpan = 2;
    row.cells[2].rowSpan = 2;
    row2.cells[0].rowSpan = 3;
    row2.cells[1].rowSpan = 3;

//Set the width
    grid.columns[0].width = 200;

    row.height = 10;

//Set padding for grid cells
    grid.style.cellPadding = PdfPaddings(left: 2, right: 2, top: 2, bottom: 2);

//Creates the grid cell styles
    PdfGridCellStyle cellStyle = PdfGridCellStyle();
    cellStyle.borders.all = PdfPens.black;
    cellStyle.borders.bottom = PdfPen(PdfColor(0, 0, 0), width: 0.70);
    cellStyle.font = PdfStandardFont(PdfFontFamily.timesRoman, 10);
    cellStyle.textBrush = PdfSolidBrush(PdfColor(0, 0, 0));
//Adds cell customizations
    for (int i = 0; i < grid.rows.count; i++) {
      PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        row.cells[j].style = cellStyle;
        if (j == 0 || j == 1) {
          row.cells[j].stringFormat = PdfStringFormat(
              alignment: PdfTextAlignment.left,
              lineAlignment: PdfVerticalAlignment.top);
        } else {
          row.cells[j].stringFormat = PdfStringFormat(
              alignment: PdfTextAlignment.left,
              lineAlignment: PdfVerticalAlignment.top);
        }
      }
    }

    PdfGrid grid2 = PdfGrid();

//Add columns to second grid
    grid2.columns.add(count: 8);
    grid2.headers.add(1);
    PdfGridRow header1 = grid2.headers[0];
    header1.cells[0].value = 'Sr. No.';
    header1.cells[1].value = 'PRODUCT CODE';
    header1.cells[2].value = 'DECRIPTION';
    header1.cells[3].value = 'BATCH NO';
    header1.cells[4].value = 'QUANTITY';
    header1.cells[5].value = 'UOM';
    header1.cells[6].value = 'RATE';
    header1.cells[7].value = 'AMOUNT';

//Add rows to grid
    PdfGridRow row11 = grid2.rows.add();
    row11.cells[0].value = '1';
    row11.cells[1].value = products3[0]["ITEM"].toString();

    row11.cells[2].value = products3[0]["DESC_OESHID"].toString();
    row11.cells[3].value = products3[0]["PROJECT"].toString();
    row11.cells[4].value = products3[0]["QTYSHIPPED"].toString();
    row11.cells[5].value = products3[0]["PRICEUNIT"].toString();
    row11.cells[6].value = products3[0]["QTYSHIPPED"].toString();
    row11.cells[7].value = products3[0]["TBASE1_OESHID"].toString();

    //Set the row height
    row11.height = 130;

    grid2.columns[0].width = 30;
    grid2.columns[1].width = 50;
    grid2.columns[2].width = 190;
    grid2.columns[3].width = 40;

//third table start
    PdfGrid grid3 = PdfGrid();

//Add columns to second grid
    grid3.columns.add(count: 2);
    // grid3.headers.add(1);
    // PdfGridRow header2 = grid2.headers[0];
    // header2.cells[0].value = 'Employee ID';
    // header2.cells[1].value = 'Employee Name';
    // header2.cells[2].value = 'Salary';
    // header2.cells[3].value = 'Salary';
    // header2.cells[4].value = 'Salary';
    // header2.cells[5].value = 'Salary';
    // header2.cells[6].value = 'Salary';
    // header2.cells[7].value = 'Salary';

//Add rows to grid
    PdfGridRow row21 = grid3.rows.add();
    row21.cells[0].value = 'Invoice Amount :' +
        products3[0]["GRAND_TOTAL_IN_WORDS"].toString() +
        '\nI / We hereby certify that my/our registration certificated under the GST ACT 2017 is in force on the date on which the sale of goods specified in this tax invoice is made by me/us and that the transaction of sales covered by this tax invoice has been effected by me/us and it shall be accounted for in the turnover of sales while filing of return and the due tax,if any, payable on the sale has been paid or shall be paid Certify that particulars given above are true and correct and the amount indicated represents the prise actully charged \nand that there is no flow additional consideration directly of indirectly from the buyer \n\n';
    row21.cells[1].value = 'Amount :                                         ' +
        products3[0]["TBASE1_OESHID"].toString();

    //Add rows to grid
    PdfGridRow row31 = grid3.rows.add();
    row31.cells[0].value = '';
    row31.cells[1].value =
        'Sub Total :                                         ' +
            products3[0]["TBASE1"].toString();

    //Add rows to grid
    PdfGridRow row41 = grid3.rows.add();
    row41.cells[0].value = '';
    row41.cells[1].value = "CGST @ 9.00 %                                " +
        products3[0]["TEAMOUNT1"].toString() +
        "\nSGST @ 9.00 %                                " +
        products3[0]["TEAMOUNT2"].toString();

    //Add rows to grid
    PdfGridRow row51 = grid3.rows.add();
    row51.cells[0].value = '';
    row51.cells[1].value =
        'SubTotal :                                          ' +
            products3[0]["SHINETWTX"].toString() +
            "\n                                           @            " +
            products3[0]["SHIDISCAMT"].toString();

    //Add rows to grid
    PdfGridRow row61 = grid3.rows.add();
    row61.cells[0].value = '';
    row61.cells[1].value =
        'Grand Total :                                      ' +
            products3[0]["SHINETWTX"].toString();

    //last row
    //Add rows to grid
    PdfGridRow row71 = grid3.rows.add();
    row71.cells[0].value = products3[0]["SALESPER1"].toString() +
        "                              BOXES : " +
        products3[0]["BoxPacked"].toString() +
        "\n\n1.  Receive the above goods in order and perfect condition. \n\n2. Our responsibility ceases after material delivered to shipping or dispatching authorized \n    and no claim will be accepted for any loss damage or non-delivery during transit. \n\n3. Goods once sold will not be accepted back. \n\n4. 18% Interest will be charged on all accounts remaining unpaid afer the expiry of 30 days.                    Authorised Signature  \n\n\n                                                                                   Subject to Mumbai Jurisdiction.";

    //Set the width
    grid3.columns[0].width = 320;

    row21.cells[0].rowSpan = 5;
    row71.cells[0].columnSpan = 2;

//third table ends

//fourth table starts

//fourth table ends

//Creates layout format settings to allow the table pagination
    PdfLayoutFormat layoutFormat =
        PdfLayoutFormat(layoutType: PdfLayoutType.paginate);

//Draws the grid to the PDF page
    PdfLayoutResult gridResult = grid.draw(
        page: page,
        bounds: Rect.fromLTWH(0, bounds.bottom + 1, graphics.clientSize.width,
            graphics.clientSize.height - 50),
        format: layoutFormat)!;

//Draws the grid2 to the PDF page
    PdfLayoutResult gridResult1 = grid2.draw(
        page: page,
        bounds: Rect.fromLTWH(0, bounds.bottom + 170, graphics.clientSize.width,
            graphics.clientSize.height - 50),
        format: layoutFormat)!;

//Draws the grid3 to the PDF page
    PdfLayoutResult gridResult2 = grid3.draw(
        page: page,
        bounds: Rect.fromLTWH(0, bounds.bottom + 350, graphics.clientSize.width,
            graphics.clientSize.height - 50),
        format: layoutFormat)!;

    // gridResult1.page.graphics.drawString(
    //     'Total Outstanding Amount: INR  ', subHeadingFont,
    //     brush: PdfSolidBrush(PdfColor(126, 155, 203)),
    //     bounds: Rect.fromLTWH(250, gridResult.bounds.bottom + 10, 0, 0));

    gridResult1.page.graphics.drawString(
        'Total Quantity :' + products3[0]["QTYSHIPPED"].toString(),
        subHeadingFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(245, gridResult.bounds.bottom + 165, 0, 0));

    gridResult2.page.graphics.drawString(
        'FOR: AGARWAL FASTNERS PVT. LTD.', subHeadingFont1,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(350, gridResult.bounds.bottom + 320, 0, 0));

    // gridResult.page.graphics.drawString(
    //     'COMPUTER GENERATED HENCE 1233 SIGNED', subHeadingFont,
    //     brush: PdfBrushes.black,
    //     bounds: Rect.fromLTWH(0, gridResult.bounds.bottom + 105, 0, 0));

    List<int> bytes = document.save();
    document.dispose();
    saveAndLaunchFile(bytes, 'Invoice.pdf');
  }
}
