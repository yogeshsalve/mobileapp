import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';

import 'package:http/http.dart' as http;
import 'package:orderapp/loginscreen.dart';

class Register extends StatefulWidget {
  // const BuyForm({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

// String? _value;

class _RegisterState extends State<Register> {
  // get myController => null;
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();
  final myController5 = TextEditingController();
  final myController6 = TextEditingController();
  final myController7 = TextEditingController();
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  postData() async {
    //print('function executed successfully..!!');
    try {
      var response = await http.post(
          Uri.parse("http://yogeshsalve.com/API/users/register.php"),
          body: {
            "username": myController1.text,
            "email": myController2.text,
            "password": myController3.text,
            "companyname": myController4.text,
            "address": myController5.text,
            "contactno": myController6.text,
            "Userstatus": "Inactive"
          });
      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  final _formKey = GlobalKey<FormState>();

  user(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // setState(() {
      //   changeButton = true;
      // });

      await Future.delayed(Duration(seconds: 2));
      postData();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // String abc=ModalRoute.of(context)!.settings.arguments;
    // final args = ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Registration"),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: size.height * 0.02),
              Container(
                child: Image.asset(
                  'images/register.png',
                  fit: BoxFit.cover,
                  height: size.height * 0.3,
                ),
              ),

              // TEXT
              Container(
                color: Colors.white,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Center(
                  child: Text(
                    "REGISTER USER",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2661FA),
                        fontSize: 22),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.01),

              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: myController1,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    labelText: "username",
                    // prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.person),
                    // border: InputBorder.none,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Username cannot be empty";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: size.height * 0.01),

              //for email
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: myController2,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    labelText: "Email",
                    // prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.email),
                    // border: InputBorder.none,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email cannot be empty";
                    }
                    return null;
                  },
                ),
              ),

              SizedBox(height: size.height * 0.01),

              //for password
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: myController3,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    labelText: "Password",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.visibility_off_outlined),
                      onPressed: () {
                        _toggle();
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password cannot be empty";
                    } else if (value.length < 6) {
                      return "Password length should be atleast 6";
                    }
                    return null;
                  },
                  obscureText: _obscureText,
                ),
              ),

              SizedBox(height: size.height * 0.01),

              //for companyname
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: myController4,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    labelText: "Company Name",
                    // prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.email),
                    // border: InputBorder.none,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Company name cannot be empty";
                    }
                    return null;
                  },
                ),
              ),

              SizedBox(height: size.height * 0.01),

              //for address
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: myController5,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    labelText: "Address",
                    // prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.email),
                    // border: InputBorder.none,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Address name cannot be empty";
                    }
                    return null;
                  },
                ),
              ),

              SizedBox(height: size.height * 0.01),

//for contact no
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: myController6,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    labelText: "Contact No",
                    // prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.email),
                    // border: InputBorder.none,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Contact no. cannot be empty";
                    }
                    return null;
                  },
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
                    user(context);
                  },
                  child: Container(
                    width: 150,
                    height: 50,
                    alignment: Alignment.center,
                    child: Text("Register",
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
    );
  }
}
