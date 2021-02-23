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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Your wallet ID",
                  labelStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(Icons.search_sharp, color: Colors.white),
                ),
              ),
            ),
            customTile("Clear data", Icons.clear, SharedPrefs.deleteAll,
                'This will clear all your data,\nYou won\'t see your watches or portfolio.'),
            Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 8.0),
              child: Text(
                "Your watch list",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            FutureBuilder(
                future: SharedPrefs.getValues('Watch'),
                builder: (context, AsyncSnapshot<List<String>> snapshot) {
                  if (snapshot.hasData && snapshot.data.length != 0) {
                    print(snapshot.data.length);
                    return Expanded(
                                          child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return customTile(snapshot.data[index], Icons.money, null, null);
                        },
                      ),
                    );
                  }
                  return Container();
                })
          ],
        ),
      ),
    );
  }
}

Widget customTile(
    String title, IconData leadingIcon, Function callback, dynamic subTitle) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: Color(0xff222222),
      child: ListTile(
        subtitle: subTitle == null
            ? null
            : Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 3.0),
                child: Text(subTitle, style: TextStyle(color: Colors.grey)),
              ),
        onTap: callback,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(title, style: TextStyle(color: Colors.white)),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(leadingIcon, color: Colors.white),
        ),
      ),
    ),
  );
}
