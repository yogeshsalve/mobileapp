import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/drawer.dart';
import 'package:orderapp/mobile.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class TabletoPdf extends StatefulWidget {
  @override
  _TabletoPdfState createState() => _TabletoPdfState();
}

class _TabletoPdfState extends State<TabletoPdf> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        title: const Text('TabletoPdf'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Create Pdf"),
          onPressed: () {
            _createPDF();
          },
        ),
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigation(),
    );
  }

  Future<void> _createPDF() async {
    PdfDocument document = PdfDocument();
    document.pages.add();
    List<int> bytes = document.save();
    document.dispose();
    saveAndLaunchFile(bytes, 'Output.pdf');
  }
}
