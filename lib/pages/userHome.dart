import 'package:flutter/material.dart';
import 'package:stock_app/services/prefsController.dart';
import 'package:finance_quote/finance_quote.dart';
import 'package:google_fonts/google_fonts.dart';
import 'crypto/oneCrypto.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  var cryptoTags;
  var stockTags;

  Future<List<Map<String, Map<String, dynamic>>>> getData() async {
    List<String> cryptoWatch = await SharedPrefs.getValues('Watch');
    List<String> stocksWatch = await SharedPrefs.getValues('Stock');

    return await Future.wait(
      [
        FinanceQuote.getRawData(
            quoteProvider: QuoteProvider.yahoo,
            symbols:
                stocksWatch.map((element) => element.toUpperCase()).toList()),
        FinanceQuote.getRawData(
            quoteProvider: QuoteProvider.coincap, symbols: cryptoWatch)
      ],
    );
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
                      future: getData(),
                      builder: (context, AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData) {
                          cryptoTags = snapshot.data[1].keys.toList();
                          stockTags = snapshot.data[0].keys.toList();
                          print(snapshot.data[0]);
                          print("-" * 100);
                          print(snapshot.data[1]);
                          return Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Crypto Watchlist",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 10), 
                                  Expanded(
                                      child: ListView.builder(
                                    itemCount: cryptoTags.length,
                                    itemBuilder: (context, index) {
                                      String change24h = snapshot.data[1]
                                              [cryptoTags[index]]
                                              ['changePercent24Hr']
                                          .substring(0, 4);
                                      String priceRaw = snapshot.data[1]
                                          [cryptoTags[index]]["priceUsd"];
                                      String price = "\$" +
                                          priceRaw.substring(
                                              0, priceRaw.indexOf(".") + 3);
                                      String name = snapshot.data[1]
                                          [cryptoTags[index]]['symbol'];
                                      return Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0)),    
                                        color: Color(0xff222222),
                                        child: ListTile(
                                          leading: Image.asset(
                                              "assets/images/symbols/btc.png",
                                              width: 35,
                                              height: 35),
                                          onTap: () {
                                            {
                                              Navigator.of(context).pop();
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          CryptoInfo(snapshot
                                                                  .data[1][
                                                              cryptoTags[
                                                                  index]])));
                                            }
                                          },
                                          subtitle: Text(change24h + "%",
                                              style: TextStyle(
                                                color:
                                                    double.parse(change24h) < 0
                                                        ? Colors.red
                                                        : Colors.green,
                                              )),
                                          title: Row(children: [
                                            SizedBox(
                                              width: 100,
                                              child: Text(
                                                name,
                                                style: GoogleFonts.firaCode(
                                                  textStyle: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              price,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ]),
                                          trailing: Theme(
                                            data: Theme.of(context).copyWith(
                                              cardColor: background,
                                            ),
                                            child: PopupMenuButton(
                                              onSelected: (choice) async {
                                                if (await SharedPrefs
                                                    .getWatches(
                                                        cryptoTags[index],
                                                        'Watch')) {
                                                  SharedPrefs.deleteWatch(
                                                      cryptoTags[index],
                                                      'Watch');
                                                  setState(() {});
                                                  return;
                                                }
                                                setState(() {});
                                                SharedPrefs.storeSymbol(
                                                    choice, 'Watch');
                                              },
                                              icon: Icon(Icons.more_vert,
                                                  color: Colors.white),
                                              itemBuilder:
                                                  (BuildContext context) {
                                                return <PopupMenuEntry<String>>[
                                                  PopupMenuItem<String>(
                                                    child: FutureBuilder(
                                                      future: SharedPrefs
                                                          .getWatches(
                                                              cryptoTags[index],
                                                              'Watch'),
                                                      builder: (context,
                                                          AsyncSnapshot<bool>
                                                              snapshot) {
                                                        if (snapshot.hasData) {
                                                          // print("test");
                                                          // return Container();
                                                          return snapshot.data
                                                              ? Text("Unwatch",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white))
                                                              : Text("Watch",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white));
                                                        } else {
                                                          return Text("Watch",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white));
                                                        }
                                                      },
                                                    ),
                                                    value: cryptoTags[index],
                                                  ),
                                                ];
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ))
                                ]),
                          );
                        } else {
                          return Container();
                        }
                      }),
                ],
              )),
        ));
  }
}
