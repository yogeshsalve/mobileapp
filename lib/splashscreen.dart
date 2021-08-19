import 'package:flutter/material.dart';
import 'package:orderapp/dashboard.dart';
import 'dart:async';
import 'package:orderapp/loginscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color color = Colors.white;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? userName;
  @override
  void initState() {
    super.initState();
    getUserName();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => (userName == null ? LoginScreen() : Dashboard())));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo here
              // Image.asset(
              //   'images/logo3.png',
              //   height: size.height * 0.15,
              // ),
              Container(
                margin: EdgeInsets.all(10),
                // width: size.width * 0.5,
                height: size.height * 0.5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('images/splash1.png'),
                      fit: BoxFit.fill),
                ),
              ),

              SizedBox(height: size.height * 0.05),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              )
            ],
          ),
        ),
      ),
    );
  }

  void getUserName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    userName = pref.getString('usernamekey')!;
    setState(() {});
  }
}
