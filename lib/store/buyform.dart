import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/drawerpages/cart.dart';
import 'package:orderapp/drawerpages/store.dart';
import 'package:http/http.dart' as http;

class BuyForm extends StatefulWidget {
  // const BuyForm({Key? key}) : super(key: key);

  @override
  _BuyFormState createState() => _BuyFormState();
}

// String? _value;

class _BuyFormState extends State<BuyForm> {
  // get myController => null;
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();
  // final myController5 = TextEditingController();

  postData() async {
    //print('function executed successfully..!!');
    try {
      var response = await http.post(
          Uri.parse("http://yogeshsalve.com/API/products/cart.php"),
          body: {
            "item_name": myController1.text,
            "available": myController2.text,
            "uom": myController3.text,
            "quantity": myController4.text
          });
      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  final _formKey = GlobalKey<FormState>();

  cart(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // setState(() {
      //   changeButton = true;
      // });

      await Future.delayed(Duration(seconds: 2));
      postData();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => Cart()));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // String abc=ModalRoute.of(context)!.settings.arguments;
    final args = ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text("Buy Form"),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Store()),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
      body: Material(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: size.height * 0.03),
                // Container(
                //   color: Colors.white,
                //   alignment: Alignment.centerLeft,
                //   padding: EdgeInsets.symmetric(horizontal: 40),
                //   child: Center(
                //     child: Text(
                //       args,
                //       style: TextStyle(
                //           fontWeight: FontWeight.bold,
                //           color: Color(0xFF2661FA),
                //           fontSize: 22),
                //     ),
                //   ),
                // ),
                // SizedBox(height: size.height * 0.01),

                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  child: TextFormField(
                    readOnly: true,
                    controller: myController1..text = args,
                    // controller: passwordText,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(labelText: "category"),
                  ),
                ),

                SizedBox(height: size.height * 0.01),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down_circle),
                    style: TextStyle(color: Colors.green, fontSize: 22),
                    // hint: Text("Select item"),
                    items: [
                      DropdownMenuItem<String>(
                        child: Text('Item 1'),
                        value: 'qwerty',
                      ),
                      DropdownMenuItem<String>(
                        child: Text('Item 2'),
                        value: 'two',
                      ),
                      DropdownMenuItem<String>(
                        child: Text('Item 3'),
                        value: 'three',
                      ),
                    ],
                    // onChanged: (String? value) {
                    //   setState(() {
                    //     _value = value!;
                    //   });
                    // },
                    hint: Text('Select Item'),
                    // value: "1",
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  child: TextFormField(
                    readOnly: false,
                    controller: myController1,
                    //  controller: myController1..text = _value,
                    // controller: passwordText,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      labelText: "Item Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  child: TextFormField(
                    controller: myController2,
                    // controller: passwordText,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      labelText: "Available",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  child: TextFormField(
                    controller: myController3,
                    // controller: passwordText,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      labelText: "UOM",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please select UOM";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  child: TextFormField(
                    controller: myController4,
                    // controller: passwordText,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      labelText: "Quantity",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter quantity";
                      }
                      return null;
                    },
                  ),
                ),
                // Container(
                //   alignment: Alignment.centerRight,
                //   margin: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                //   child: Text(
                //     "Enter Quantity",
                //     style: TextStyle(fontSize: 12, color: Color(0XFF2661FA)),
                //   ),
                // ),
                SizedBox(height: size.height * 0.03),
                Material(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //     builder: (BuildContext context) => Cart()));
                      cart(context);
                    },
                    child: Container(
                      width: 150,
                      height: 50,
                      alignment: Alignment.center,
                      child: Text("Add To Cart",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // child: Text(args),
  }
}
