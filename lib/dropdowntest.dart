import 'package:flutter/material.dart';
import 'package:orderapp/bottomnavigation.dart';
import 'package:orderapp/drawer.dart';

class Dropdown extends StatefulWidget {
  const Dropdown({Key? key}) : super(key: key);

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String value = "";
  bool disableddropdown = true;

  List<DropdownMenuItem<String>> menuitems = [];
  final web = {
    "1": "PHP",
    "2": "Python",
    "3": "Node",
  };
  final app = {
    "4": "Java",
    "5": "Flutter",
    "6": "React",
  };
  final desktop = {
    "1": "JavaFX",
    "2": "Electron",
    "3": "Tkinter",
  };

  void populateweb() {
    for (String key in web.keys) {
      menuitems.add(DropdownMenuItem<String>(
        value: web[key],
        child: Center(
          child: Text(
            value,
          ),
        ),
      ));
    }
  }

  void valuechanged(_value) {
    if (_value == "Web") {
      populateweb();
    }
    setState(() {
      value = _value;
      disableddropdown = false;
    });
  }

  void secondvaluechanged(_value) {
    setState(() {
      value = _value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[700],
        title: const Text('Dropdown'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: EdgeInsets.all(5.0),
            child: DropdownButton<String>(
              items: [
                DropdownMenuItem<String>(
                  value: "Web",
                  child: Center(
                    child: Text("Web"),
                  ),
                ),
                DropdownMenuItem<String>(
                  value: "App",
                  child: Center(
                    child: Text("App"),
                  ),
                ),
                DropdownMenuItem<String>(
                  value: "Desktop",
                  child: Center(
                    child: Text("Desktop"),
                  ),
                ),
              ],
              onChanged: (_value) => valuechanged(_value),
              hint: Text("Select any No."),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: DropdownButton<String>(
              items: menuitems,
              onChanged: disableddropdown
                  ? null
                  : (_value) => secondvaluechanged(_value),
              hint: Text("Select any Technology."),
              disabledHint: Text("First select any field"),
            ),
          ),
          Text(
            "$value",
          )
        ]),
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:orderapp/bottomnavigation.dart';
// import 'package:orderapp/drawer.dart';

// class Dropdown extends StatefulWidget {
//   @override
//   _DropdownState createState() => _DropdownState();
// }

// class _DropdownState extends State<Dropdown> {
//   String value = "";
//   bool disableddropdown = true;
//   List<DropdownMenuItem<String>> menuitems = [];
//   final web = {
//     "1": "PHP",
//     "2": "Python",
//     "3": "Node",
//   };
//   final app = {
//     "4": "Java",
//     "5": "Flutter",
//     "6": "React",
//   };
//   final desktop = {
//     "1": "JavaFX",
//     "2": "Electron",
//     "3": "Tkinter",
//   };
//   void populateweb() {
//     for (String key in web.keys) {
//       menuitems.add(DropdownMenuItem<String>(
//         value: web[key],
//         child: Center(
//           child: Text(key),
//         ),
//       ));
//     }
//   }

//   void populateapp() {
//     for (String value in app.values) {
//       menuitems.add(DropdownMenuItem<String>(
//         value: app[value],
//         child: Center(
//           child: Text(value),
//         ),
//       ));
//     }
//   }

//   void populatedesktop() {
//     for (String key in desktop.keys) {
//       menuitems.add(DropdownMenuItem<String>(
//         value: desktop[key],
//         child: Center(
//           child: Text(key),
//         ),
//       ));
//     }
//   }

//   void valuechanged(_value) {
//     if (value == "web") {
//       menuitems = [];
//       populateweb();
//     } else if (value == "app") {
//       menuitems = [];
//       populateapp();
//     } else if (value == "desktop") {
//       menuitems = [];
//       populatedesktop();
//     }
//     setState(() {
//       value = _value;
//       disableddropdown = false;
//     });
//   }

//   void secondvaluechanged(_value) {
//     setState(() {
//       value = _value;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blueAccent[700],
//         title: const Text('Dropdown'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Padding(
//               padding: EdgeInsets.all(5.0),
//               child: DropdownButton<String>(
//                 items: [
//                   DropdownMenuItem<String>(
//                     value: "web",
//                     child: Center(
//                       child: Text('Web'),
//                     ),
//                   ),
//                   DropdownMenuItem<String>(
//                     value: "app",
//                     child: Center(
//                       child: Text('App'),
//                     ),
//                   ),
//                   DropdownMenuItem<String>(
//                     value: "desktop",
//                     child: Center(
//                       child: Text('Desktop'),
//                     ),
//                   ),
//                 ],
//                 onChanged: (_value) => valuechanged(_value),
//                 hint: Text("Select item"),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(5.0),
//               child: DropdownButton<String>(
//                 items: menuitems,
//                 onChanged: disableddropdown
//                     ? null
//                     : (_value) => secondvaluechanged(_value),
//                 hint: Text("Select any field"),
//                 disabledHint: Text("first select any field"),
//               ),
//             ),
//             Text("$value"),
//           ],
//         ),
//       ),
//       drawer: MyDrawer(),
//       bottomNavigationBar: BottomNavigation(),
//     );
//   }
// }
