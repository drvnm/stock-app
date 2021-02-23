import 'package:flutter/material.dart';
import 'package:finance_quote/finance_quote.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/prefsController.dart';

class StocksPage extends StatefulWidget {
  @override
  _StocksPageState createState() => _StocksPageState();
}

class _StocksPageState extends State<StocksPage> {
  var tags;

  @override
  Widget build(BuildContext context) {
    Color background = Color(0xff181818);
    return Scaffold(
      appBar: AppBar(
        title: Text("Stocks"),
        centerTitle: true,
        backgroundColor: background,
      ),
      body: Container(
        color: background,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                      decoration: InputDecoration(
                        labelText: "Search",
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon:
                            Icon(Icons.search_sharp, color: Colors.white),
                      ),
                    ),
              FutureBuilder(
                future: FinanceQuote.getRawData(
                    quoteProvider: QuoteProvider.yahoo,
                    symbols: <String>['GOOG', 'KO', 'GME', 'BP']),
                builder: (context,
                    AsyncSnapshot<Map<String, Map<String, dynamic>>> snapshot) {
                  if (snapshot.hasData) {
                    // print(snapshot.data);

                    tags = snapshot.data.keys.toList();
       
                    return Expanded(
                                          child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          String change24h = snapshot.data[tags[index]]
                                  ["regularMarketChangePercent"]
                              .toString()
                              .substring(0, 4);
                          var changeBool = double.parse(change24h) > 0;
                          String priceRaw = snapshot.data[tags[index]]
                                  ["regularMarketPrice"]
                              .toString();
                          String price =
                              "\$" + priceRaw.substring(0, priceRaw.indexOf(".") + 3);
                          String name = snapshot.data[tags[index]]['symbol'];
                          return Container(
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                                color: Color(0xff222222),
                                child: ListTile(
                                  leading: changeBool
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(Icons.arrow_upward_sharp,
                                              color: Colors.green),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(Icons.arrow_downward_sharp,
                                              color: Colors.red),
                                        ),
                                  title: Row(
                                    children: [
                                      SizedBox(
                                        width: 80,
                                        child: Text(name,
                                            style: GoogleFonts.firaCode(
                                                textStyle:
                                                    TextStyle(color: Colors.white))),
                                      ),
                                      Text(price,
                                          style: TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                  subtitle: changeBool
                                      ? Text(change24h + "%",
                                          style: TextStyle(
                                            color: Colors.green,
                                          ))
                                      : Text(change24h + "%",
                                          style: TextStyle(
                                            color: Colors.red,
                                          )),
                                  trailing: Theme(
                                    data: Theme.of(context).copyWith(
                                      cardColor: background,
                                    ),
                                    child: PopupMenuButton(
                                      onSelected: (choice) async {
                                        if (await SharedPrefs.getWatches(
                                            tags[index], 'Stock')) {
                                          SharedPrefs.deleteWatch(
                                              tags[index], 'Stock');
                                          setState(() {});
                                          return;
                                        }
                                          
                                        SharedPrefs.storeSymbol(choice, 'Stock');
                                        setState(() {});
                                      },
                                      icon:
                                          Icon(Icons.more_vert, color: Colors.white),
                                      itemBuilder: (BuildContext context) {
                                        return <PopupMenuEntry<String>>[
                                          PopupMenuItem<String>(
                                            child: FutureBuilder(
                                              future: SharedPrefs.getWatches(
                                                  tags[index].toLowerCase(), 'Stock'),
                                              builder: (context,
                                                  AsyncSnapshot<bool> snapshot) {
                                                if (snapshot.hasData) {
                                                  print(snapshot.data);
                                                  print(tags[index]);
                                                  // return Container();
                                                  return snapshot.data
                                                      ? Text("Unwatch",
                                                          style: TextStyle(
                                                              color: Colors.white))
                                                      : Text("Watch",
                                                          style: TextStyle(
                                                              color: Colors.white));
                                                } else {
                                                  return Text("Waddtch",
                                                      style: TextStyle(
                                                          color: Colors.white));
                                                }
                                              },
                                            ),
                                            value: tags[index],
                                          ),
                                        ];
                                      },
                                    ),
                                  ),
                                )),
                          );
                        },
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNav(),
    );
  }
}
