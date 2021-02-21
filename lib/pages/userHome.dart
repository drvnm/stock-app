import 'package:flutter/material.dart';
import 'package:stock_app/services/prefsController.dart';
import 'package:finance_quote/finance_quote.dart';
import 'package:google_fonts/google_fonts.dart';

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
        body: SizedBox.expand(
          child: Container(
              color: background,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder(
                    future: FinanceQuote.getRawData(
                        quoteProvider: QuoteProvider.coincap, symbols: symbols),
                    builder: (BuildContext context,
                        AsyncSnapshot<Map<String, Map<String, dynamic>>>
                            snapshot) {
                      print("Future completed");
                      if (snapshot.hasData) {
                        print(snapshot.data['dogecoin']);
                        return Container();
                      }
                      return Container();
                    },
                  ),
                ],
              )),
        ));
  }
}
