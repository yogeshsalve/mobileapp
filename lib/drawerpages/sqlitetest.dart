import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/dashboard.dart';
import 'package:orderapp/drawer.dart';
import 'package:orderapp/drawerpages/dbhelper.dart';

class SqliteTest extends StatefulWidget {
  @override
  _SqliteTestState createState() => _SqliteTestState();
}

class _SqliteTestState extends State<SqliteTest> {
  final _formKey = GlobalKey<FormState>();
  var selectedLocation;
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final dbhelper = Databasehelper.instance;
  void insertdata() async {
    Map<String, dynamic> row = {
      Databasehelper.columnDesc: myController1.text,
      Databasehelper.columnQuantity: myController2.text,
    };
    final id = await dbhelper.insert(row);

    print(id);
  }

//************************ */
  Future<void> showData() async {
    var allrows = await dbhelper.showData();
    allrows.forEach((row) {
      print(row);
    });
  }

//************************ */
  void queryspecific() async {
    var allrow = await dbhelper.queryspecific(20);
    print(allrow);
  }

//************************ */
  void delete() async {
    var id = await dbhelper.deletedata(1);
    print(id);
  }

//************************ */
  void update() async {
    var row = await dbhelper.update(2);
    print(row);
  }

//************************ */
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        title: const Text('SqliteTest'),
        leading: BackButton(
            color: Colors.white,
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Dashboard()))),
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: size.height * 0.05),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      child: TextFormField(
                        //readOnly: true,
                        //controller: _controller,
                        controller: myController1..text,
                        // controller: passwordText,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          labelText: "Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      child: TextFormField(
                        //readOnly: true,
                        //controller: _controller,
                        controller: myController2..text,
                        // controller: passwordText,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          labelText: "Age",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                  ]),
            ),
            //##################################################
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              //color: Colors.white,
              child: ElevatedButton(
                child: Text('INSERT'),
                onPressed: () {
                  insertdata();
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    shape: StadiumBorder()),
              ),
            ),
            //##################################################
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              //color: Colors.white,
              child: ElevatedButton(
                child: Text('QUERY'),
                onPressed: () {
                  showData();
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    shape: StadiumBorder()),
              ),
            ),
            //##################################################
            SizedBox(height: size.height * 0.03),

            Container(
              alignment: Alignment.center,
              //color: Colors.white,
              child: ElevatedButton(
                child: Text('QUERY SPECIFIC'),
                onPressed: () {
                  queryspecific();
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    shape: StadiumBorder()),
              ),
            ),
            //##################################################
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              //color: Colors.white,
              child: ElevatedButton(
                child: Text('UPDATE'),
                onPressed: () {
                  update();
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    shape: StadiumBorder()),
              ),
            ),
            //##################################################
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              //color: Colors.white,
              child: ElevatedButton(
                child: Text('DELETE'),
                onPressed: () {
                  delete();
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    shape: StadiumBorder()),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
