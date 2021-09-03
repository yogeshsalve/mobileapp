// // import 'package:amazon/UI/product_list.dart';

// import 'package:flutter/material.dart';
// import 'package:orderapp/homepage/homefourth.dart';
// import 'package:orderapp/homepage/top_bar.dart';
// import 'package:orderapp/models/global.dart';

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         drawer: Drawer(child: DrawerTab()),
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: dark_blue,
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Container(
//                 child: Row(
//                   children: <Widget>[
//                     Container(
//                       width: 100,
//                       child: Image(
//                           image: AssetImage('images/assets/topbarlogo.png')),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 child: Row(
//                   children: <Widget>[
//                     IconButton(
//                       icon: Icon(Icons.mic, color: Colors.white),
//                       onPressed: () {},
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.shopping_cart, color: Colors.white),
//                       onPressed: () {},
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//         body: Container(
//             constraints: BoxConstraints.expand(),
//             color: Colors.white,
//             child: Column(
//               children: <Widget>[
//                 TopBar(),
//                 Container(
//                   height: MediaQuery.of(context).size.height - 170,
//                   // child: ProductList(),
//                 )
//               ],
//             )));
//   }
// }
