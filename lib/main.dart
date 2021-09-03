import 'package:flutter/material.dart';
import 'package:orderapp/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "APL ORDER APP",
      home: SplashScreen(),
    );
  }
}
