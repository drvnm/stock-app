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
              customTile("Data", Icons.data_usage_sharp, context, Data(), 'Clear data, watching data, wallet data'),
              customTile("Notifications", Icons.notifications_active_sharp,
                  context, Data(), 'Notifications'),
              customTile("Appearance", Icons.remove_red_eye, context, Data(), 'Color scheme, currency',),
              customTile("About", Icons.help_center, context, Data(), null),
            ],
          ),
        ));
  }
}

customTile(
    String title, IconData leadingIcon, BuildContext context, Widget page, dynamic subTitle) {
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
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(leadingIcon, color: Colors.white),
      ),
      subtitle: subTitle == null ? null : Text(subTitle, style: TextStyle(color: Colors.grey)),
      trailing: Icon(
        Icons.arrow_forward_ios_sharp,
        color: Colors.white,
        size: 19,
      ),
    ),
  );
}
