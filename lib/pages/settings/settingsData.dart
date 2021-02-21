import 'package:flutter/material.dart';
import '../../services/prefsController.dart';

class Data extends StatefulWidget {
  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {
  @override
  Widget build(BuildContext context) {
    Color background = Color(0xff181818);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        title: Text(
          "Data settings",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        color: background,
        child: Column(
          children: [
            customTile("Clear data", Icons.clear, SharedPrefs.deleteAll)
          ],
        ),
      ),
    );
  }
}

customTile(String title, IconData leadingIcon, Function callback) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    color: Color(0xff222222),
    child: ListTile(
      onTap: callback,
      title: Text(title, style: TextStyle(color: Colors.white)),
      leading: Icon(leadingIcon, color: Colors.white),
    ),
  );
}
