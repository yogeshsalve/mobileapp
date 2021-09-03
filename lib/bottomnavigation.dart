import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:orderapp/dashboard.dart';
import 'package:orderapp/drawerpages/cart.dart';
import 'package:orderapp/drawerpages/fevstore.dart';
import 'package:orderapp/drawerpages/profile.dart';
import 'package:orderapp/drawerpages/store.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

// Color color = Colors.blueAccent;

String disp = '';

int _page = 0;

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      // key: _bottomNavigationKey,
      index: _page,
      height: 60.0,
      items: <Widget>[
        Icon(Icons.favorite, size: 30, color: Colors.white),
        Icon(Icons.shop, size: 30, color: Colors.white),
        Icon(Icons.home, size: 50, color: Colors.white),
        Icon(Icons.shopping_cart, size: 30, color: Colors.white),
        Icon(Icons.person_outlined, size: 30, color: Colors.white),
      ],
      color: Colors.blueAccent.shade700,
      buttonBackgroundColor: Colors.black,
      backgroundColor: Colors.white,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 600),

      onTap: (index) {
        setState(() {
          if (index == 0) {
            _page = index;
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => FavStore()));
          } else if (index == 1) {
            _page = index;
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) => Store()));
          } else if (index == 2) {
            _page = index;
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => Dashboard()));
          } else if (index == 3) {
            _page = index;
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) => Cart()));
          } else {
            _page = index;
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => Profile()));
          }
        });
      },

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
    //letIndexChange: (index) => true,

    //BOTTOM NAVIGATION
  }
}
