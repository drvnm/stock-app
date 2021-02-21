import 'package:flutter/material.dart';
import 'settingsData.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    Color background = Color(0xff181818);
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
          backgroundColor: background,
          centerTitle: true,
        ),
        body: Container(
          color: background,
          child: Column(
            children: [
              customTile("Data", Icons.data_usage_sharp, context, Data()),
              customTile("Notifications", Icons.notifications_active_sharp,
                  context, Data()),
              customTile("Appearance", Icons.remove_red_eye, context, Data()),
              customTile("About", Icons.help_center, context, Data()),
            ],
          ),
        ));
  }
}

customTile(
    String title, IconData leadingIcon, BuildContext context, Widget page) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    color: Color(0xff222222),
    child: ListTile(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => page));
      },
      title: Text(title, style: TextStyle(color: Colors.white)),
      leading: Icon(leadingIcon, color: Colors.white),
      trailing: Icon(
        Icons.arrow_forward_ios_sharp,
        color: Colors.white,
        size: 19,
      ),
    ),
  );
}
