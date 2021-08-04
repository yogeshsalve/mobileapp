import 'package:flutter/material.dart';
import 'dart:async';
import 'package:orderapp/loginscreen.dart';

Color color = Colors.white;

// class SplashScreenPage extends StatefulWidget {
//   @override
//   _SplashScreenPageState createState() => _SplashScreenPageState();
// }

// class _SplashScreenPageState extends State<SplashScreenPage> {
//   @override
//   void initState() {
//     super.initState();
//     startSplashScreen();
//   }

//   startSplashScreen() async {
//     var duration = const Duration(seconds: 05);
//     return Timer(duration, () {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (_) {
//           return LoginScreen();
//         }),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Color(0xff329cef),
//       backgroundColor: color,
//       body: Center(
//         child: Column(
//           children: <Widget>[
//             Expanded(
//               child: Container(
//                 // color: Theme.of(context).primaryColor,
//                 margin: EdgeInsets.only(top: 100, bottom: 5),
//                 width: 150,
//                 height: 150,
//                 decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     image: DecorationImage(
//                       image: new AssetImage("images/logo3.png"),
//                     )),
//               ),
//             ),
//             // Divider(
//             //   thickness: 2,
//             //   color: Colors.deepPurpleAccent[300],
//             // ),
//             Expanded(
//               child: Container(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Text(
//                       "Agarwal Fastners Pvt Ltd",
//                       style: TextStyle(
//                           fontSize: 25,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blue),
//                     ),
//                     Column(
//                       children: [
//                         Text(
//                           "For Those Who Want The Best",
//                           style: TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.blueAccent),
//                         ),
//                       ],
//                     ),
//                     // GFListTile(
//                     //   color: Colors.blue,
//                     //   icon: Icon(Icons.favorite),
//                     //   titleText: 'WELCOME',
//                     // ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),

//         //     child: Image.asset(
//         //     "images/logo2.png",
//         //   width: 200.0,
//         //   height: 100.0,
//         // ),
//       ),
//     );
//   }
// }

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
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
                    image: AssetImage('images/splash1.png'), fit: BoxFit.fill),
              ),
            ),
            // SizedBox(height: size.height * 0.02),
            // Text(
            //   "AGARWAL FASTNERS PVT. LTD.",
            //   style: GoogleFonts.lato(
            //       color: Colors.blue,
            //       fontSize: 21,
            //       fontWeight: FontWeight.bold),
            // ),
            SizedBox(height: size.height * 0.05),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            )
          ],
        ),
      ),
    );
  }
}
