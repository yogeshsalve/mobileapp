import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/dashboard.dart';
import 'package:orderapp/drawer.dart';
import 'package:orderapp/drawerpages/color.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String userName = "";
  @override
  void initState() {
    super.initState();
    getUserName();
  }

  bool _obscureText1 = true;
  bool _obscureText2 = true;
  // bool _obscureText3 = true;

  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();

  postData() async {
    try {
      var response = await http.post(
          Uri.parse("https://yogeshsalve.com/API/users/updatepassword.php"),
          body: {
            "email": myController1.text,
            "current": myController2.text,
            "new": myController3.text,
          });
      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  final _formKey = GlobalKey<FormState>();

  updatepassword(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // setState(() {
      //   changeButton = true;
      // });

      await Future.delayed(Duration(seconds: 2));
      postData();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => Dashboard()));
    }
  }

  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  // void _toggle3() {
  //   setState(() {
  //     _obscureText3 = !_obscureText3;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        title: const Text('Change Password'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // SizedBox(height: size.height * 0.01),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'images/changepassword.png',
                    fit: BoxFit.cover,
                    height: size.height * 0.2,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  readOnly: true,
                  controller: myController1..text = userName,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    labelText: "email",
                    // prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.email),
                    // border: InputBorder.none,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: myController2,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    labelText: "Current Password",
                    suffixIcon: IconButton(
                      icon: Icon(_obscureText1 == true
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_rounded),
                      onPressed: () {
                        _toggle1();
                      },
                    ),
                    // border: InputBorder.none,
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
                  obscureText: _obscureText1,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: myController3,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    labelText: "New Password",
                    suffixIcon: IconButton(
                      icon: Icon(_obscureText2 == true
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_rounded),
                      onPressed: () {
                        _toggle2();
                      },
                    ),
                    // border: InputBorder.none,
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
                  obscureText: _obscureText2,
                ),
              ),
              // SizedBox(
              //   height: size.height * 0.02,
              // ),

              // Container(
              //   alignment: Alignment.center,
              //   margin: EdgeInsets.symmetric(horizontal: 40),
              //   child: TextFormField(
              //     //controller: passwordText,
              //     style: TextStyle(fontSize: 20),
              //     decoration: InputDecoration(
              //       labelText: "Re-Enter New Password",
              //       suffixIcon: IconButton(
              //         icon: Icon(_obscureText3 == true
              //             ? Icons.visibility_off_outlined
              //             : Icons.visibility_rounded),
              //         onPressed: () {
              //           _toggle3();
              //         },
              //       ),
              //       // border: InputBorder.none,
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(5.0),
              //       ),
              //     ),
              //     validator: (value) {
              //       if (value!.isEmpty) {
              //         return "Password cannot be empty";
              //       } else if (value.length < 6) {
              //         return "Password length should be atleast 6";
              //       }
              //       return null;
              //     },
              //     obscureText: _obscureText3,
              //   ),
              // ),

              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                color: Colors.white,
                child: ElevatedButton(
                  child: Text('Submit'),
                  // onPressed: () {
                  //   print('Pressed');
                  // },
                  onPressed: () {
                    updatepassword(context);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      textStyle:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      shape: StadiumBorder()),
                ),
              ),
              SizedBox(height: size.height * 0.05),
            ],
          ),
        ),
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigation(),
    );
  }

  void getUserName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    userName = pref.getString('usernamekey')!;
    setState(() {});
  }
}
