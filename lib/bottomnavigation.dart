import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

String disp = '';

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      // key: _bottomNavigationKey,
      index: 0,
      height: 60.0,
      items: <Widget>[
        Icon(Icons.favorite, size: 30, color: Colors.white),
        Icon(Icons.home, size: 60, color: Colors.white),
        Icon(Icons.shopping_cart, size: 30, color: Colors.white),
      ],
      color: Colors.blueAccent.shade700,
      buttonBackgroundColor: Colors.deepOrange[400],
      backgroundColor: Colors.white,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 600),

      // onTap: (index) {
      //   setState(() {
      //     if (index == 0) {
      //       disp = 'Store';
      //     } else if (index == 1) {
      //       disp = 'Store';
      //     }
      //     else if (index == 2) {
      //       disp = 'Store';
      //     }
      //     else if (index == 3) {
      //       disp = 'Store';
      //     }
      //     else
      //       disp = 'Store';
      //   });
      // },
      //   _page = index;
    );
    // letIndexChange: (index) => true,

    //BOTTOM NAVIGATION
  }
}
