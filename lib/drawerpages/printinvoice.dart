import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
// import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/dashboard.dart';
// import 'package:orderapp/splashscreen.dart';
// import 'package:orderapp/drawer.dart';

class PrintInvoice extends StatelessWidget {
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
                    decoration: InputDecoration(
                      labelText: "Inovice Search",
                      suffixIcon: Icon(Icons.search),
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
              Container(
                child: Text(
                  "--- Search Invoice Data By Date ---",
                  style: TextStyle(color: Colors.green, fontSize: 18),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              // from date to date in a single line
              Container(
                color: Colors.white,
                child: Row(
                  // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: new Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: DateTimeFormField(
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.black45),
                            errorStyle: TextStyle(color: Colors.redAccent),
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.event_note),
                            labelText: 'From Date:',
                          ),
                          mode: DateTimeFieldPickerMode.date,
                          autovalidateMode: AutovalidateMode.always,
                          validator: (e) => (e?.day ?? 0) == 1
                              ? 'Please not the first day'
                              : null,
                          onDateSelected: (DateTime value) {
                            print(value);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: new Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: DateTimeFormField(
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.black45),
                            errorStyle: TextStyle(color: Colors.redAccent),
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.event_note),
                            labelText: 'To Date:',
                          ),
                          mode: DateTimeFieldPickerMode.date,
                          autovalidateMode: AutovalidateMode.always,
                          validator: (e) => (e?.day ?? 0) == 1
                              ? 'Please not the first day'
                              : null,
                          onDateSelected: (DateTime value) {
                            print(value);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                alignment: Alignment.center,
                //color: Colors.white,
                width: size.width * 0.8,
                child: ElevatedButton(
                  child: Row(
                    children: [
                      Icon(
                        Icons.download,
                        // color: Colors.black,
                      ),
                      Text(
                        '   Get Invoice Data',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  onPressed: () {
                    // _createPDF();
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      padding:
                          EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                      textStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      shape: StadiumBorder()),
                ),
              ),

              SizedBox(height: size.height * 0.02),

              //----

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
                        ],
                        rows: <DataRow>[
                          // for (var p in products)
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text("12323450")),
                              DataCell(Text("12/12/2021")),
                              DataCell(Text("02/03/2022")),
                              DataCell(Text("PO093456")),
                              DataCell(Text("30500")),
                              DataCell(Text("12")),
                              DataCell(Text("30500")),
                            ],
                          ),

                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text("12323450")),
                              DataCell(Text("12/12/2021")),
                              DataCell(Text("02/03/2022")),
                              DataCell(Text("PO093456")),
                              DataCell(Text("30500")),
                              DataCell(Text("12")),
                              DataCell(Text("30500")),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text("12323450")),
                              DataCell(Text("12/12/2021")),
                              DataCell(Text("02/03/2022")),
                              DataCell(Text("PO093456")),
                              DataCell(Text("30500")),
                              DataCell(Text("12")),
                              DataCell(Text("30500")),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text("12323450")),
                              DataCell(Text("12/12/2021")),
                              DataCell(Text("02/03/2022")),
                              DataCell(Text("PO093456")),
                              DataCell(Text("30500")),
                              DataCell(Text("12")),
                              DataCell(Text("30500")),
                            ],
                          ),
                        ],
                        columnSpacing: 30,
                        horizontalMargin: 10,
                        // rowsPerPage: 8,
                        showCheckboxColumn: false,
                      )),

                  //----
                  const Divider(
                    // height: 20,
                    thickness: 2,
                    indent: 0,
                    endIndent: 0,
                    color: Colors.grey,
                  ),
                  Container(
                    alignment: Alignment.center,
                    //color: Colors.white,
                    width: size.width * 0.8,
                    child: ElevatedButton(
                      child: Row(
                        children: [
                          Icon(
                            Icons.download,
                            // color: Colors.black,
                          ),
                          Text(
                            '   Get Invoice Report',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      onPressed: () {
                        // _createPDF();
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
                ],
              ),
            ],
          ),
          // drawer: MyDrawer(),
          // bottomNavigationBar: BottomNavigation(),
        ));
  }
}
