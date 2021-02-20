import 'package:flutter/material.dart';
import 'package:stock_app/prefsController.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  List<String> symbols;

  @override
  initState() {
    super.initState();
    SharedPrefs.getSymbols('Watch').then((result) {
      this.symbols = result;
      print(symbols);
    });
  }

  @override
  Widget build(BuildContext context) {
    Color background = Color(0xff181818);
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          centerTitle: true,
          backgroundColor: background,
        ),
        body: Container(
          
          color: background,
          child: Column(
            children: [
              Text("test"),
              Text("test"),
              Text("test"),
            ],
          ),
        ));
  }
}
