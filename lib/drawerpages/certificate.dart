import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/dashboard.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:http/http.dart' as http;
import '../mobile.dart';
//import 'package:orderapp/drawer.dart';
//import 'package:date_field/date_field.dart';

class Certificate extends StatefulWidget {
  @override
  _CertificateState createState() => _CertificateState();
}

class _CertificateState extends State<Certificate> {
  List products3 = [];
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  fetchCertificate() async {
    //final shinumber = products[0]["invoice_id"];
    final invnumber = myController1.text;
    final itemno = myController2.text;
    //final invnumber = "P20/011745";
    //final itemno = "0933040825";
    var userCookie = "Basic QURNSU46dmlrcmFtQGFwbDEyMw==";
    var url = Uri.parse(
        'http://aplhome.info:701/AplReportsApi/api/Report/TcFromInvoiceReport?invnumber=$invnumber&itemno=$itemno');
    //'http://aplhome.info:701/AplReportsApi/api/Report/TaxInvoice?shinumber=$shinumber');
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
    // int _radioValue = 0;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: const Text('Certificate'),
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

              Center(
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // new Radio(
                    //   value: 0,
                    //   groupValue: _radioValue,
                    //   onChanged: null,
                    // ),
                    SizedBox(height: size.height * 0.05),
                    new Text(
                      'Enter Invoice number and Item Number',
                      style: new TextStyle(fontSize: 16.0),
                    ),
                    // new Radio(
                    //   value: 1,
                    //   groupValue: _radioValue,
                    //   onChanged: null,
                    // ),
                    // new Text(
                    //   'Batch Wise',
                    //   style: new TextStyle(
                    //     fontSize: 16.0,
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                //color: Colors.white,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Center(
                  child: TextField(
                    controller: myController1..text,
                    decoration: InputDecoration(
                      labelText: "Invoice No.",
                      // prefixIcon: Icon(Icons.search),
                      // suffixIcon: Icon(Icons.search),
                      // border: InputBorder.none,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                //color: Colors.white,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Center(
                  child: TextField(
                    controller: myController2..text,
                    decoration: InputDecoration(
                      labelText: "Item No.",
                      // prefixIcon: Icon(Icons.search),
                      // suffixIcon: Icon(Icons.search),
                      // border: InputBorder.none,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ),
              // Container(
              //   alignment: Alignment.center,
              //   margin: EdgeInsets.symmetric(horizontal: 50),
              //   width: 420,
              //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(5),
              //       border: Border.all(
              //           color: Colors.blueGrey,
              //           width: 1,
              //           style: BorderStyle.solid)),
              //   child: DropdownButton<String>(
              //     isExpanded: true,
              //     icon: Icon(Icons.arrow_drop_down_circle),
              //     style: TextStyle(color: Colors.green, fontSize: 22),
              //     // hint: Text("Select item"),
              //     items: [
              //       DropdownMenuItem<String>(
              //         child: Text('Product 1'),
              //         value: 'one',
              //       ),
              //       DropdownMenuItem<String>(
              //         child: Text('Product 2'),
              //         value: 'two',
              //       ),
              //       DropdownMenuItem<String>(
              //         child: Text('Product 3'),
              //         value: 'three',
              //       ),
              //     ],
              //     onChanged: (String? value) {},
              //     hint: Text('Select Product'),
              //     //value: _value,
              //   ),
              // ),

              // Container(
              //     alignment: Alignment.center,
              //     padding: EdgeInsets.all(10),
              //     margin: const EdgeInsets.only(top: 50),
              //     child: Text(
              //       'Radio Button',
              //       style: TextStyle(
              //           color: Colors.red,
              //           fontWeight: FontWeight.w500,
              //           fontSize: 30),
              //     )),

              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                alignment: Alignment.center,
                //color: Colors.white,
                child: ElevatedButton(
                  child: Text('Generate Cerificate'),
                  // onPressed: () {
                  //   print('Pressed');
                  // },
                  onPressed: () {
                    fetchCertificate();
                    _createPDF();
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      textStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      shape: StadiumBorder()),
                ),
              ),
              SizedBox(height: size.height * 0.05),
            ],
          ),
        ),
      ),
      // drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigation(),
    );
  }

  Future<void> _createPDF() async {
    PdfDocument document = PdfDocument();

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
    page.graphics.drawImage(image, Rect.fromLTWH(0, 0, 450, 100));

//SECOND IMAGE
//Loads the image from base64 string
    PdfImage image1 = PdfBitmap.fromBase64String(
        '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');

//Draws the image to the PDF page
    page.graphics.drawImage(image1, Rect.fromLTWH(15, 102, 450, 100));

    Rect bounds = Rect.fromLTWH(0, 182, graphics.clientSize.width, 30);

    PdfFont subHeadingFont = PdfStandardFont(PdfFontFamily.timesRoman, 10);

    PdfFont subHeadingFont1 = PdfStandardFont(PdfFontFamily.timesRoman, 8);

//Create a PdfGrid
    PdfGrid grid = PdfGrid();

//Add the columns to the grid
    grid.columns.add(count: 4);

//Add rows to grid
    PdfGridRow row = grid.rows.add();
    row.cells[0].value = "INSPECTION CERTIFICATE EN 10204 - 3.1";
    row.cells[1].value = "";
    row.cells[2].value = "";
    row.cells[3].value = "";

    PdfGridRow row1 = grid.rows.add();
    row1.cells[0].value = "Certificate No :";
    row1.cells[1].value = products3[0]["InspCertNo"].toString();
    row1.cells[2].value = "Certificate Date :";
    row1.cells[3].value = products3[0]["CertDate"].toString();

    PdfGridRow row2 = grid.rows.add();
    row2.cells[0].value = "Invoice No :";
    row2.cells[1].value = products3[0]["invnum"].toString();
    row2.cells[2].value = "Invoice Date :";
    row2.cells[3].value = products3[0]["SHIDATE"].toString();

    PdfGridRow row3 = grid.rows.add();
    row3.cells[0].value = "PO No :";
    row3.cells[1].value = products3[0]["orderno"].toString();
    row3.cells[2].value = "Lot Qty :";
    row3.cells[3].value = products3[0]["ORDQTYORD"].toString();

    PdfGridRow row4 = grid.rows.add();
    row4.cells[0].value = "Item No :";
    row4.cells[1].value = products3[0]["itemno"].toString();
    row4.cells[2].value = "Lot No :";
    row4.cells[3].value = products3[0]["heatno"].toString();

    PdfGridRow row5 = grid.rows.add();
    row5.cells[0].value = "Commodity : ";
    row5.cells[1].value = products3[0]["DESC1"].toString();
    row5.cells[3].value = "";

    PdfGridRow row6 = grid.rows.add();
    row6.cells[0].value = "STANDARD :";
    row6.cells[1].value = products3[0]["DIN"].toString();
    row6.cells[2].value = "GRADE :";
    row6.cells[3].value = products3[0]["Grade"].toString();

    //Set the column span
    row.cells[0].columnSpan = 2;
    row5.cells[1].columnSpan = 3;

//Set padding for grid cells
    grid.style.cellPadding = PdfPaddings(left: 2, right: 2, top: 2, bottom: 2);

//Creates the grid cell styles
    PdfGridCellStyle cellStyle = PdfGridCellStyle();
    cellStyle.borders.all = PdfPens.white;
    cellStyle.borders.bottom = PdfPen(PdfColor(256, 256, 256), width: 0.70);
    cellStyle.font = PdfStandardFont(PdfFontFamily.timesRoman, 10);
    cellStyle.textBrush = PdfSolidBrush(PdfColor(0, 0, 0));
//Adds cell customizations
    for (int i = 0; i < grid.rows.count; i++) {
      PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        row.cells[j].style = cellStyle;
        if (j == 0 || j == 2) {
          row.cells[j].stringFormat = PdfStringFormat(
              alignment: PdfTextAlignment.right,
              lineAlignment: PdfVerticalAlignment.top);
        } else {
          row.cells[j].stringFormat = PdfStringFormat(
              alignment: PdfTextAlignment.left,
              lineAlignment: PdfVerticalAlignment.top);
        }
      }
    }
//first table ends here

//second table starts
    PdfGrid grid2 = PdfGrid();
    grid2.style.cellPadding = PdfPaddings(left: 2, right: 2, top: 2, bottom: 2);
//Add columns to second grid
    grid2.columns.add(count: 3);
    grid2.headers.add(1);
    PdfGridRow header1 = grid2.headers[0];
    header1.cells[0].value = 'DIMENSIONAL INSPECTIONS CHARACTERISTICS';
    header1.cells[1].value = 'SPECIFICATIONS : (mm)';
    header1.cells[2].value = 'ACTUAL RESULT';

//Add rows to grid
    PdfGridRow row11 = grid2.rows.add();
    row11.cells[0].value = products3[0]["Diamentinoal_Inspection"].toString();
    row11.cells[1].value = products3[0]["ItemValue"].toString() +
        " - " +
        products3[0]["ItemValue1"].toString();

    row11.cells[2].value = products3[0]["CurValue"].toString() +
        " - " +
        products3[0]["CurrValue1"].toString();

    PdfGridRow row12 = grid2.rows.add();
    row12.cells[0].value = products3[3]["Diamentinoal_Inspection"].toString();
    row12.cells[1].value = products3[3]["ItemValue"].toString() +
        " - " +
        products3[3]["ItemValue1"].toString();
    row12.cells[2].value = products3[3]["CurValue"].toString() +
        " - " +
        products3[3]["CurrValue1"].toString();

    PdfGridRow row13 = grid2.rows.add();
    row13.cells[0].value = products3[6]["Diamentinoal_Inspection"].toString();
    row13.cells[1].value = products3[6]["ItemValue"].toString() +
        " - " +
        products3[6]["ItemValue1"].toString();
    row13.cells[2].value = products3[6]["CurValue"].toString() +
        " - " +
        products3[6]["CurrValue1"].toString();

    PdfGridRow row14 = grid2.rows.add();
    row14.cells[0].value = products3[9]["Diamentinoal_Inspection"].toString();
    row14.cells[1].value = products3[9]["ItemValue"].toString() +
        " - " +
        products3[9]["ItemValue1"].toString();
    row14.cells[2].value = products3[9]["CurValue"].toString() +
        " - " +
        products3[9]["CurrValue1"].toString();

    PdfGridRow row15 = grid2.rows.add();
    row15.cells[0].value = products3[12]["Diamentinoal_Inspection"].toString();
    row15.cells[1].value = products3[12]["ItemValue"].toString() +
        " - " +
        products3[12]["ItemValue1"].toString();
    row15.cells[2].value = products3[12]["CurValue"].toString() +
        " - " +
        products3[12]["CurrValue1"].toString();

    PdfGridRow row16 = grid2.rows.add();
    row16.cells[0].value = products3[15]["Diamentinoal_Inspection"].toString();
    row16.cells[1].value = products3[15]["ItemValue"].toString() +
        " - " +
        products3[15]["ItemValue1"].toString();
    row16.cells[2].value = products3[15]["CurValue"].toString() +
        " - " +
        products3[15]["CurrValue1"].toString();

    PdfGridRow row17 = grid2.rows.add();
    row17.cells[0].value = products3[18]["Diamentinoal_Inspection"].toString();
    row17.cells[1].value = products3[18]["ItemValue"].toString() +
        " - " +
        products3[18]["ItemValue1"].toString();
    row17.cells[2].value = products3[18]["CurValue"].toString() +
        " - " +
        products3[18]["CurrValue1"].toString();

//third table start
    PdfGrid grid3 = PdfGrid();

//Add columns to second grid
    grid3.columns.add(count: 10);

//Add rows to grid
    PdfGridRow row21 = grid3.rows.add();
    row21.cells[0].value = 'Heat No';
    row21.cells[1].value = 'c';
    row21.cells[2].value = 'Si';
    row21.cells[3].value = 'Mn';
    row21.cells[4].value = 'P';
    row21.cells[5].value = 'S';
    row21.cells[6].value = 'Cr';
    row21.cells[7].value = 'Mo';
    row21.cells[8].value = 'Ni';
    row21.cells[9].value = 'cu';

    //Add rows to grid
    PdfGridRow row31 = grid3.rows.add();
    row31.cells[0].value = products3[0]["tbl_chemdet_HeatNo"].toString();
    row31.cells[1].value = products3[0]["cval"].toString();
    row31.cells[2].value = products3[0]["sival"].toString();
    row31.cells[3].value = products3[0]["mnval"].toString();
    row31.cells[4].value = products3[0]["pval"].toString();
    row31.cells[5].value = products3[0]["sval"].toString();
    row31.cells[6].value = products3[0]["crval"].toString();
    row31.cells[7].value = products3[0]["moval"].toString();
    row31.cells[8].value = products3[0]["nival"].toString();
    row31.cells[9].value = products3[0]["cuval"].toString();

    //Set the width
    //grid3.columns[0].width = 320;

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
        bounds: Rect.fromLTWH(0, bounds.bottom + 150, graphics.clientSize.width,
            graphics.clientSize.height - 50),
        format: layoutFormat)!;

//Draws the grid3 to the PDF page
    PdfLayoutResult gridResult2 = grid3.draw(
        page: page,
        bounds: Rect.fromLTWH(0, bounds.bottom + 320, graphics.clientSize.width,
            graphics.clientSize.height - 50),
        format: layoutFormat)!;

    // gridResult1.page.graphics.drawString(
    //     'Total Outstanding Amount: INR  ', subHeadingFont,
    //     brush: PdfSolidBrush(PdfColor(126, 155, 203)),
    //     bounds: Rect.fromLTWH(250, gridResult.bounds.bottom + 10, 0, 0));
    gridResult1.page.graphics.drawString(
        '------------------------------------------------------------------------------------------------------------------------------------------------',
        subHeadingFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(0, gridResult.bounds.bottom + 280, 0, 0));

    gridResult1.page.graphics.drawString(
        '------------------------- \n    Q.A. Executive', subHeadingFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(0, gridResult.bounds.bottom + 320, 0, 0));

    gridResult1.page.graphics.drawString(
        '------------------------- \n          Date', subHeadingFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(200, gridResult.bounds.bottom + 320, 0, 0));

    gridResult1.page.graphics.drawString(
        '------------------------- \n          Page', subHeadingFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(350, gridResult.bounds.bottom + 320, 0, 0));

    gridResult2.page.graphics.drawString(
        'THIS REPORT MUST NOT BE REPRODUCTED EXCEPT IN FULL AND TO THE ITEMS TESTED ONLY. \nHE ASTNERS HAVE BEEN MANUFACTURED ACCORDING TO THE REQUIREMENT OF THE APPLICABLE \nSTANDARD AND FOUND CONFORM WITH ITS REQUIREMENT.',
        subHeadingFont1,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(0, gridResult.bounds.bottom + 350, 0, 0));

    // gridResult.page.graphics.drawString(
    //     'COMPUTER GENERATED HENCE 1233 SIGNED', subHeadingFont,
    //     brush: PdfBrushes.black,
    //     bounds: Rect.fromLTWH(0, gridResult.bounds.bottom + 105, 0, 0));

    List<int> bytes = document.save();
    document.dispose();
    saveAndLaunchFile(bytes, 'Certificate.pdf');
  }
}
