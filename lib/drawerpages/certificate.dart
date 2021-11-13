import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/dashboard.dart';
//import 'package:orderapp/drawer.dart';
//import 'package:date_field/date_field.dart';

class Certificate extends StatefulWidget {
  @override
  _CertificateState createState() => _CertificateState();
}

class _CertificateState extends State<Certificate> {
  @override
  Widget build(BuildContext context) {
    int _radioValue = 0;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        title: const Text('Certificate'),
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

            Center(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Radio(
                    value: 0,
                    groupValue: _radioValue,
                    onChanged: null,
                  ),
                  new Text(
                    'Inovice Wise',
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  new Radio(
                    value: 1,
                    groupValue: _radioValue,
                    onChanged: null,
                  ),
                  new Text(
                    'Batch Wise',
                    style: new TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
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
                  decoration: InputDecoration(
                    labelText: "Search",
                    // prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.search),
                    // border: InputBorder.none,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 50),
              width: 420,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: Colors.blueGrey,
                      width: 1,
                      style: BorderStyle.solid)),
              child: DropdownButton<String>(
                isExpanded: true,
                icon: Icon(Icons.arrow_drop_down_circle),
                style: TextStyle(color: Colors.green, fontSize: 22),
                // hint: Text("Select item"),
                items: [
                  DropdownMenuItem<String>(
                    child: Text('Product 1'),
                    value: 'one',
                  ),
                  DropdownMenuItem<String>(
                    child: Text('Product 2'),
                    value: 'two',
                  ),
                  DropdownMenuItem<String>(
                    child: Text('Product 3'),
                    value: 'three',
                  ),
                ],
                onChanged: (String? value) {},
                hint: Text('Select Product'),
                //value: _value,
              ),
            ),
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
              height: size.height * 0.20,
            ),
            Container(
              alignment: Alignment.center,
              //color: Colors.white,
              child: ElevatedButton(
                child: Text('Generate'),
                // onPressed: () {
                //   print('Pressed');
                // },
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    shape: StadiumBorder()),
              ),
            ),
            SizedBox(height: size.height * 0.05),
          ],
        ),
      ),
      // drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
