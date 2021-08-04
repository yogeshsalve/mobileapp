import 'package:flutter/material.dart';
import 'package:orderapp/drawerpages/store.dart';

class BuyForm extends StatelessWidget {
  const BuyForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // String abc=ModalRoute.of(context)!.settings.arguments;
    final args = ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text("Buy Form"),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Store()),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Text(args),
      ),
    );
  }
}
