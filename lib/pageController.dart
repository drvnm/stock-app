import 'package:flutter/material.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'cryptoList.dart';
import 'stocks.dart';
import 'userHome.dart'; 

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> tags = [];
  int _currentIndex = 0;
  var pages = [StocksPage(), UserHome(), CryptoList(), CryptoList()];
  @override
  Widget build(BuildContext context) {
    Color background = Color(0xff181818);
    return Scaffold(
      
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: <BottomNavigationBarItem>[
          item("Stocks", Icons.attach_money_sharp),
          item("Home", Icons.home_sharp),
          item("Crypto", CryptoFontIcons.BTC),
           item("Settings", Icons.settings_sharp),
        ],
        backgroundColor: background,
      ),
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