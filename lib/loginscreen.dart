// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:orderapp/dashboard.dart';
import 'package:orderapp/drawerpages/color.dart';
import 'package:orderapp/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ApiService.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  bool changeButton = false;
  final emailText = TextEditingController();
  final passwordText = TextEditingController();
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  //:API Call
  callLoginApi(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final service = ApiServices();
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        changeButton = true;
      });
      service.apiCallLogin(
        {
          "email": emailText.text,
          "password": passwordText.text,
        },
      ).then((value) {
        if (value.error == "200") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Dashboard()));
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Alert'),
              content: const Text('Please enter correct email and password.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen())),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
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
                  controller: emailText,
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Username cannot be empty";
                    }
                    return null;
                  },
                  onChanged: (value) {
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
                  controller: passwordText,
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

                  onTap: () {
                    callLoginApi(context);
                    setUserName(emailText.text);
                  },
                  // onTap: () async {
                  //   print('posting data');
                  //   await postData().then((value) {
                  //     print(value);
                  //   });
                  // },

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
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                child: InkWell(
                  child: Text(
                    "Not Registered? SignUp Here",
                    style: TextStyle(fontSize: 22, color: Color(0XFF2661FA)),
                  ),
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => Register()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> setUserName(userName) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('usernamekey', userName);
  }
}
