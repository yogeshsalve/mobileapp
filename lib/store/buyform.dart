import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/drawerpages/cart.dart';
import 'package:orderapp/drawerpages/store.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BuyForm extends StatefulWidget {
  // const BuyForm({Key? key}) : super(key: key);

  @override
  _BuyFormState createState() => _BuyFormState();
}

// String? _value;

class _BuyFormState extends State<BuyForm> {
  String? userName;
  // get myController => null;
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();
  final myController5 = TextEditingController();
  //var a = myController2.value;
  //var b = myController4.value;
  // final myController5 = TextEditingController();
  @override
  void initState() {
    super.initState();
    getUserName();
  }

  postData() async {
    //print('function executed successfully..!!');
    try {
      var response = await http.post(
          Uri.parse("http://yogeshsalve.com/API/products/cart.php"),
          body: {
            "item_name": myController1.text,
            "available": myController2.text,
            "uom": myController3.text,
            "quantity": myController4.text,
            "email": myController5.text
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

      var available1 = myController2.text;
      var quantity1 = myController4.text;

      var a = int.parse(available1);
      var b = int.parse(quantity1);

      if (a > b) {
        await Future.delayed(Duration(seconds: 2));
        postData();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => Cart()));
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('Alert'),
                  content: const Text('Quantity should be less than available'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Ok'),
                    ),
                  ],
                ));
      }
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

                    hint: Text('Select Item'),
                    // value: "1",
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  child: TextFormField(
                    readOnly: true,
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
                SizedBox(height: size.height * 0.01),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  child: Visibility(
                    visible: false,
                    child: TextFormField(
                      controller: myController5..text = userName!,
                      // controller: passwordText,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        labelText: "Username",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
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

  void getUserName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    userName = pref.getString('usernamekey')!;
    setState(() {});
  }
}
