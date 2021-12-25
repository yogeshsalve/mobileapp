import 'package:flutter/material.dart';
import 'package:orderapp/drawerpages/outstanding.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:orderapp/mobile.dart';
import 'package:intl/intl.dart';

class OutstandingData extends StatefulWidget {
  const OutstandingData({Key? key}) : super(key: key);

  @override
  _OutstandingDataState createState() => _OutstandingDataState();
}

class _OutstandingDataState extends State<OutstandingData> {
  List productsdisplay = [
    {"IDCUST": "0.000"}
  ];
  List products2 = [];
  @override
  void initState() {
    super.initState();
    this.fetchProduct();
  }

  fetchProduct() async {
    final frmidcust = 'VI25';
    final toidcust = 'VI25';
    final idgrp = 'DEALER';
    final codecurn = 'INR';
    final agent = '0000';

    var userCookie = "Basic QURNSU46dmlrcmFtQGFwbDEyMw==";
    var url = Uri.parse(
        // 'http://172.16.1.101:701/AplReportsApi/api/Report/OutStandingReport?{"frmidcust" : $frmidcust, "toidcust" :$toidcust , "idgrp":$idgrp , "codecurn" :$codecurn , "agent" :$agent}');
        // 'http://172.16.1.101:701/AplReportsApi/api/Report/TaxInvoice?frmidcust=$frmidcust&toidcust=$toidcust&idgrp=$idgrp&codecurn=$codecurn&agent=$agent');

        'http://aplhome.info:701/AplReportsApi/api/Report/OutStandingReport?frmidcust=$frmidcust&toidcust=$toidcust&idgrp=$idgrp&codecurn=$codecurn&agent=$agent');

    // 'http://172.16.1.101:701/AplReportsApi/api/Report/OutStandingReport?frmidcust=$frmidcust&toidcust=$toidcust&idgrp=$idgrp&codecurn=$codecurn&agent=$agent');
    var response = await http.get(url, headers: {'Authorization': userCookie});

    if (response.statusCode == 200) {
      // var items = jsonDecode(response.body);
      // print(items);

      var items = jsonDecode(jsonDecode(response.body));

      for (var item in items) {
        products2.add(item);
      }

      print(products2);
      // print(items[].toString());

      // List products2 = [];
      // for (var item in items) {
      //   products2.add(item);
      // }

      // print(products2);
      setState(() {
        productsdisplay = products2;
      });
    }

    // else
    //   setState(() {
    //     products = [];
    //   });

    print('y');
    // print(products);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        title: const Text('Outstanding Report'),
        leading: BackButton(
            color: Colors.white,
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => Outstanding()))),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
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
                    width: size.width * 0.7,
                    child: ElevatedButton(
                      child: Row(
                        children: [
                          Icon(
                            Icons.print,
                            // color: Colors.black,
                          ),
                          Text(
                            '   Generate PDF',
                            // style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      onPressed: () {
                        _createPDF();
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          padding: EdgeInsets.symmetric(
                              horizontal: 60, vertical: 10),
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
                  'Sr. No.',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.green[600],
                      fontWeight: FontWeight.bold),
                )),
                DataColumn(
                    label: Text('Description',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.green[600],
                            fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Value',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.green[600],
                            fontWeight: FontWeight.bold))),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('1')),
                  DataCell(
                    Text("CUST ID"),
                  ),
                  DataCell(Text(productsdisplay[0]["IDCUST"].toString())),
                ]),
              ],
            ),
          ],
        ),
      ),
      // drawer: MyDrawer(),
      // bottomNavigationBar: BottomNavigation(),
    );
  }

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
    page.graphics.drawImage(image, Rect.fromLTWH(55, 0, 390, 130));

    PdfBrush solidBrush = PdfSolidBrush(PdfColor(126, 151, 173));
    Rect bounds = Rect.fromLTWH(0, 160, graphics.clientSize.width, 30);

    //Draws a rectangle to place the heading in that region
    graphics.drawRectangle(brush: solidBrush, bounds: bounds);

    //Creates a font for adding the heading in the page
    PdfFont subHeadingFont = PdfStandardFont(PdfFontFamily.timesRoman, 14);

    //Creates a text element to add the invoice number
    PdfTextElement element = PdfTextElement(
        text: "Customer ID :" + products2[0]["IDCUST"].toString(),
        font: subHeadingFont);
    element.brush = PdfBrushes.white;

    // element =
    //     PdfTextElement(text: '\nKIND ATTcnxvnxvnxnN. ', font: subHeadingFont);

    //Draws the heading on the page
    PdfLayoutResult result = element.draw(
        page: page, bounds: Rect.fromLTWH(10, bounds.top + 8, 0, 0))!;

    //Use 'intl' package for date format.
    String currentDate = 'DATE ' + DateFormat.yMMMd().format(DateTime.now());

    //Measures the width of the text to place it in the correct location
    Size textSize = subHeadingFont.measureString(currentDate);
    // Offset textPosition = Offset(
    //     graphics.clientSize.width - textSize.width - 10, result.bounds.top);

    //Draws the date by using drawString method
    graphics.drawString(currentDate, subHeadingFont,
        brush: element.brush,
        bounds: Offset(graphics.clientSize.width - textSize.width - 10,
                result.bounds.top) &
            Size(textSize.width + 2, 20));

    //Creates text elements to add the address and draw it to the page
    // element = PdfTextElement(
    //     text: 'BILL TO ',
    //     font: PdfStandardFont(PdfFontFamily.timesRoman, 10,
    //         style: PdfFontStyle.bold));
    // element.brush = PdfSolidBrush(PdfColor(126, 155, 203));
    // result = element.draw(
    //     page: page,
    //     bounds: Rect.fromLTWH(10, result.bounds.bottom + 25, 0, 0))!;

    PdfFont timesRoman = PdfStandardFont(PdfFontFamily.timesRoman, 10);

    element = PdfTextElement(
        text: 'KIND ATTN:' + products2[0]["NAMECTAC"].toString(),
        font: timesRoman);
    element.brush = PdfBrushes.black;
    result = element.draw(
        page: page,
        bounds: Rect.fromLTWH(10, result.bounds.bottom + 10, 0, 0))!;

    //COMPANY NAME
    element = PdfTextElement(
        text: products2[0]["NAMECUST"].toString(), font: timesRoman);
    element.brush = PdfBrushes.black;
    result = element.draw(
        page: page,
        bounds: Rect.fromLTWH(10, result.bounds.bottom + 10, 0, 0))!;

    //Address line one
    element = PdfTextElement(
        text: products2[0]["TEXTSTRE1"].toString() +
            '\n' +
            products2[0]["TEXTSTRE2"].toString() +
            '\n' +
            products2[0]["TEXTSTRE3"].toString() +
            '\n' +
            products2[0]["NAMECITY"].toString() +
            "" +
            products2[0]["CODEPSTL"].toString() +
            '\n' +
            products2[0]["CODESTTE"].toString() +
            '\n' +
            "PHONE NO. :" +
            products2[0]["TEXTPHON1"].toString() +
            '/' +
            products2[0]["TEXTPHON2"].toString() +
            '\n' +
            "Email :" +
            products2[0]["EMAIL2"].toString(),
        font: timesRoman);
    element.brush = PdfBrushes.black;
    result = element.draw(
        page: page,
        bounds: Rect.fromLTWH(10, result.bounds.bottom + 10, 0, 0))!;

    //Address line two
    element = PdfTextElement(
        text: products2[0]["TEXTSTRE2"].toString(), font: timesRoman);
    element.brush = PdfBrushes.black;
    result = element.draw(
        page: page,
        bounds: Rect.fromLTWH(10, result.bounds.bottom + 10, 0, 0))!;

    // element = PdfTextElement(
    //     text: '2, rue du Commerce, Lyon, France ', font: timesRoman);
    // element.brush = PdfBrushes.black;
    // result = element.draw(
    //     page: page,
    //     bounds: Rect.fromLTWH(10, result.bounds.bottom + 10, 0, 0))!;

    element = PdfTextElement(
        text: 'SUB: Outstanding receivable statement ', font: timesRoman);
    element.brush = PdfBrushes.black;
    result = element.draw(
        page: page,
        bounds: Rect.fromLTWH(10, result.bounds.bottom + 10, 0, 0))!;

    element = PdfTextElement(text: 'Dear Sir / Madam,', font: timesRoman);
    element.brush = PdfBrushes.black;
    result = element.draw(
        page: page,
        bounds: Rect.fromLTWH(10, result.bounds.bottom + 10, 0, 0))!;

    element = PdfTextElement(
        text:
            'It has come to our attention that a portion of the balance of your account is outstanding \nthat is a total of INR :' +
                products2[0]["AMTDUETC"].toString(),
        font: timesRoman);
    element.brush = PdfBrushes.black;
    result = element.draw(
        page: page,
        bounds: Rect.fromLTWH(10, result.bounds.bottom + 10, 0, 0))!;

    element = PdfTextElement(
        text:
            'We wish to point out that our terms of payment are against performa invoice , and hence we request you to send the same.',
        font: timesRoman);
    element.brush = PdfBrushes.black;
    result = element.draw(
        page: page,
        bounds: Rect.fromLTWH(10, result.bounds.bottom + 10, 0, 0))!;

    //IF PAID BY RTGS line
    element = PdfTextElement(
        text:
            'IF PAID BY RTGS OR NEFT OR DEPOSITED IN OUR ACCOUNT & BILLS SHOWN OUTSTANDING \nTHEN PLEASE SEND DETAIL TO sales@aplhome.com OR accounts@aplhome.com OR BY FAX NO: \n0250-2481147 & 48 / 9594440297',
        font: timesRoman);
    element.brush = PdfBrushes.black;
    result = element.draw(
        page: page,
        bounds: Rect.fromLTWH(10, result.bounds.bottom + 10, 0, 0))!;

    //Draws a line at the bottom of the address
    // graphics.drawLine(
    //     PdfPen(PdfColor(126, 151, 173), width: 0.7),
    //     Offset(0, result.bounds.bottom + 3),
    //     Offset(graphics.clientSize.width, result.bounds.bottom + 3));

    //Creates a PDF grid
    PdfGrid grid = PdfGrid();

//Add the columns to the grid
    grid.columns.add(count: 7);

//Add header to the grid
    grid.headers.add(1);

//Set values to the header cells
    PdfGridRow header = grid.headers[0];
    header.cells[0].value = 'Inv No';
    header.cells[1].value = 'Inv Date';
    header.cells[2].value = 'Due Date';
    header.cells[3].value = 'Party PO Number';
    header.cells[4].value = 'Inv Amount';
    header.cells[5].value = 'Overvue Days';
    header.cells[6].value = 'Outstanding Amount';

//Creates the header style
    PdfGridCellStyle headerStyle = PdfGridCellStyle();
    headerStyle.borders.all = PdfPen(PdfColor(126, 151, 173));
    headerStyle.backgroundBrush = PdfSolidBrush(PdfColor(126, 151, 173));
    headerStyle.textBrush = PdfBrushes.white;
    headerStyle.font = PdfStandardFont(PdfFontFamily.timesRoman, 10,
        style: PdfFontStyle.regular);

//Adds cell customizations
    for (int i = 0; i < header.cells.count; i++) {
      if (i == 0 || i == 1) {
        header.cells[i].stringFormat = PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.middle);
      } else {
        header.cells[i].stringFormat = PdfStringFormat(
            alignment: PdfTextAlignment.right,
            lineAlignment: PdfVerticalAlignment.middle);
      }
      header.cells[i].style = headerStyle;
    }

//Add rows to grid
    PdfGridRow row = grid.rows.add();
    row.cells[0].value = productsdisplay[0]['IDINVC'].toString();
    row.cells[1].value = productsdisplay[0]['DATEINVC'].toString();
    row.cells[2].value = productsdisplay[0]['DATEDUE'].toString();
    row.cells[3].value = "";
    row.cells[4].value = productsdisplay[0]['AMTINVCTC'].toString();
    row.cells[5].value = "";
    row.cells[6].value = productsdisplay[0]['AMTINVCTC'].toString();

//Set padding for grid cells
    grid.style.cellPadding = PdfPaddings(left: 2, right: 2, top: 2, bottom: 2);

//Creates the grid cell styles
    PdfGridCellStyle cellStyle = PdfGridCellStyle();
    cellStyle.borders.all = PdfPens.white;
    cellStyle.borders.bottom = PdfPen(PdfColor(217, 217, 217), width: 0.70);
    cellStyle.font = PdfStandardFont(PdfFontFamily.timesRoman, 12);
    cellStyle.textBrush = PdfSolidBrush(PdfColor(131, 130, 136));
//Adds cell customizations
    for (int i = 0; i < grid.rows.count; i++) {
      PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        row.cells[j].style = cellStyle;
        if (j == 0 || j == 1) {
          row.cells[j].stringFormat = PdfStringFormat(
              alignment: PdfTextAlignment.left,
              lineAlignment: PdfVerticalAlignment.middle);
        } else {
          row.cells[j].stringFormat = PdfStringFormat(
              alignment: PdfTextAlignment.right,
              lineAlignment: PdfVerticalAlignment.middle);
        }
      }
    }

//Creates layout format settings to allow the table pagination
    PdfLayoutFormat layoutFormat =
        PdfLayoutFormat(layoutType: PdfLayoutType.paginate);

//Draws the grid to the PDF page
    PdfLayoutResult gridResult = grid.draw(
        page: page,
        bounds: Rect.fromLTWH(0, result.bounds.bottom + 20,
            graphics.clientSize.width, graphics.clientSize.height - 100),
        format: layoutFormat)!;

    gridResult.page.graphics.drawString(
        'Grand Total :                             \$386.91', subHeadingFont,
        brush: PdfSolidBrush(PdfColor(126, 155, 203)),
        bounds: Rect.fromLTWH(520, gridResult.bounds.bottom + 30, 0, 0));

    gridResult.page.graphics.drawString(
        'Thank you for your business !', subHeadingFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(520, gridResult.bounds.bottom + 60, 0, 0));

    List<int> bytes = document.save();
    document.dispose();
    saveAndLaunchFile(bytes, 'Outstanding Report.pdf');
  }
}
