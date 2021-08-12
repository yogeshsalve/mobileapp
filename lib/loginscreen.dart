//import 'dart:convert';

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:orderapp/dashboard.dart';
// import 'package:orderapp/dashboard.dart';
//import 'dart:convert';

//new login screen
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  bool changeButton = false;
  var emailController = TextEditingController();
  var passController = TextEditingController();
  String message = '';

  //DIO COD STARTED //
  Dio dio = new Dio();

  Future postData(BuildContext context) async {
    var response = await dio.post('https://yogeshsalve.com/API/login.php',
        data: {'email': emailController.text, 'password': passController.text});

    // var items = jsonDecode(response.data)['result'];
    return response;

    // if (response.statusCode == 200) {
    //   var jsonResponse = json.decode(response.data);
    //   return jsonResponse.sta
    //   // if (jsonResponse != null) {
    //   //   Navigator.push(
    //   //       context, MaterialPageRoute(builder: (context) => Dashboard()));
    //   // }
    // }

    // var result = jsonDecode(response.result).toString();
    // return result;
    // if (response != null) {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => Dashboard()));
    // } else {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(content: Text("Invalid Credentials")));
    // }
    // var result = jsonDecode(response['status']);
    //                     if (result == 406) {
    //                       Navigator.of(context).pushReplacement(
    //                           MaterialPageRoute(
    //                               builder: (BuildContext context) =>
    //                                   Dashboard()));
    //                     }
    // var items = await jsonDecode(response.data)['result'];
    // return items;
    // var result = jsonDecode(response.data);
    // if (response.statusCode == 200) {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => Dashboard()));
    // } else {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(content: Text("Invalid Credentials")));
    // }
  }
  //DIO CODE ENDS HERE //

// Future<void> login() async {
  //   if (passController.text.isNotEmpty && emailController.text.isNotEmpty) {
  //     var response = await http.post(
  //         Uri.parse('https://yogeshsalve.com/API/login.php'),
  //         // Uri.parse('https://reqres.in/api/login'),
  //         body: ({
  //           'email': emailController.text,
  //           'password': passController.text
  //         }));
  //     if (response.statusCode == 200) {
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => Dashboard()));
  //     } else {
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text("Invalid Credentials")));
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text("Blank field not allowed")));
  //   }
  // }

  // final _formKey = GlobalKey<FormState>();

  // moveToDashboard(BuildContext context) async {
  //   if (_formKey.currentState!.validate()) {
  //     setState(() {
  //       changeButton = true;
  //     });

  //     await Future.delayed(Duration(seconds: 1));
  //     Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(builder: (BuildContext context) => Dashboard()));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.05),
              Container(
                child: Image.asset(
                  'images/loginimage.jpg',
                  fit: BoxFit.cover,
                  height: size.height * 0.5,
                ),
              ),
              Container(
                color: Colors.white,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Center(
                  child: Text(
                    "Welcome $username",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2661FA),
                        fontSize: 22),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: emailController,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(labelText: "Username"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Username cannot be empty";
                    }
                    return null;
                  },
                  onChanged: (value) async {
                    username = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: passController,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(labelText: "Password"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password cannot be empty";
                    } else if (value.length < 6) {
                      return "Password length should be atleast 6";
                    }
                    return null;
                  },
                  obscureText: true,
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                child: Text(
                  "Forgot your password?",
                  style: TextStyle(fontSize: 12, color: Color(0XFF2661FA)),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Material(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(changeButton ? 50 : 10),
                child: InkWell(
                  // onTap: () => moveToDashboard(context),

                  // onTap: () {
                  //   callLoginApi();
                  // },

                  // onTap: () {
                  //   login();
                  // },
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );

                      await postData(context).then((value) {
                        print(value);

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => Dashboard()));

                        // var result = jsonDecode(value);
                        // print(result);
                        // if (result['success'] == 1) {
                        //   print("good");
                        // }

                        setState(() {
                          changeButton = true;
                        });
                      });
                    } else {}
                  },

                  child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    width: changeButton ? 50 : 150,
                    height: 50,
                    alignment: Alignment.center,
                    child: changeButton
                        ? Icon(
                            Icons.done,
                            color: Colors.white,
                          )
                        : Text("Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                  ),
                ),
              ),
              Text(message),
            ],
          ),
        ),
      ),
    );
  }

  //create function to call post login api
  // Future<void> login() async {
  //   if (passController.text.isNotEmpty && emailController.text.isNotEmpty) {
  //     var response = await http.post(
  //         Uri.parse('https://yogeshsalve.com/API/login.php'),
  //         // Uri.parse('https://reqres.in/api/login'),
  //         body: ({
  //           'email': emailController.text,
  //           'password': passController.text
  //         }));
  //     if (response.statusCode == 200) {
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => Dashboard()));
  //     } else {
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text("Invalid Credentials")));
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text("Blank field not allowed")));
  //   }
  // }
}
