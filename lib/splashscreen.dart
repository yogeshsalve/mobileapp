import 'package:flutter/material.dart';
import 'package:orderapp/dashboard.dart';
import 'dart:async';
import 'package:orderapp/loginscreen.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Color color = Colors.white;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? userName;
  String? isLogin;
  String userCookie = '';
  var url = Uri.parse('http://114.143.151.6:901/categories');
  @override
  void initState() {
    super.initState();
    fetchData();
    getUserName();

    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => (isLogin == 'false' ? LoginScreen() : Dashboard())));
    });
  }

  Future fetchData() async {
// ---------------token-------------------
    final SharedPreferences pref = await SharedPreferences.getInstance();
    userCookie = pref.getString('userCookiekey')!;
    setState(() {});
    //print(userCookie);
    // -------------token ------------------------
    http.Response response;
    response = await http.get(url, headers: {'Cookie': userCookie});
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        isLogin = 'true';
      });
    } else
      setState(() {
        isLogin = 'false';
      });

    //print('***********************************');
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
