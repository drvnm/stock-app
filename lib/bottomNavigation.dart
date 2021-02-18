import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'stocks.dart';
import 'homepage.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  Map<int, StatefulWidget> pages = {
    0: StocksPage(),
    1: Home(),
  };
  @override
  Widget build(BuildContext context) {
    Color background = Color(0xff181818);
    return BottomNavigationBar(
      unselectedItemColor: Colors.white,
      onTap: (test) {
        Navigator.of(context).pop();
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => pages[test]));
      },
      items: <BottomNavigationBarItem>[
        item("Stock", Icons.account_circle_outlined),
        item("Crypto", Icons.account_circle_outlined),
        item("Test", Icons.account_circle_outlined),
      ],
      backgroundColor: background,
    );
  }
}

BottomNavigationBarItem item(String label, IconData icon) {
  return BottomNavigationBarItem(
    icon: Icon(icon),
    label: label,
    backgroundColor: Colors.white,
  );
}
