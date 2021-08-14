import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/drawer.dart';
import 'package:orderapp/drawerpages/changepassword.dart';
import 'package:orderapp/loginscreen.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void handleClick(String value) {
      switch (value) {
        case 'Change Password':
          {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => ChangePassword()));
          }
          break;
        case 'Logout':
          {
            {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => LoginScreen()));
            }
          }
          break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        title: const Text('DashBoard'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Change Password', 'Logout'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
