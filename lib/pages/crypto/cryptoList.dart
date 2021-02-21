import 'package:flutter/material.dart';
import 'package:finance_quote/finance_quote.dart';
import 'package:google_fonts/google_fonts.dart';
import 'oneCrypto.dart';
import '../../services/prefsController.dart';
import 'dart:collection';

class CryptoList extends StatefulWidget {
  @override
  _CryptoListState createState() => _CryptoListState();
}

class _CryptoListState extends State<CryptoList> {
  List<String> tags;
  var data;
  var holder;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color background = Color(0xff181818);
    return Scaffold(
      appBar: AppBar(
        title: Text("Crypto"),
        centerTitle: true,
        backgroundColor: background,
      ),
      body: Container(
        color: background,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: FinanceQuote.getRawData(
                quoteProvider: QuoteProvider.coincap,
                symbols: <String>[
                  'bitcoin',
                  'dogecoin',
                  'ethereum',
                  'chainlink',
                  'litecoin',
                  'tezos',
                  'monero',
                  'cardano',
                  'tron',
                ]),
            builder: (context,
                AsyncSnapshot<Map<String, Map<String, dynamic>>> snapshot) {
              if (snapshot.hasData) {
                data = snapshot.data;
                holder = snapshot.data;
                print(data);
                tags = data.keys.toList();
                return Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Search",
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon:
                            Icon(Icons.search_sharp, color: Colors.white),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          String change24h = data[tags[index]]
                                  ['changePercent24Hr']
                              .substring(0, 4);
                          String priceRaw = data[tags[index]]["priceUsd"];
                          String price = "\$" +
                              priceRaw.substring(0, priceRaw.indexOf(".") + 3);
                          String name = data[tags[index]]['symbol'];
                          return Container(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                              color: Color(0xff222222),
                              child: ListTile(
                                onTap: () {
                                  {
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                CryptoInfo(snapshot
                                                    .data[tags[index]])));
                                  }
                                },
                                subtitle: Text(change24h + "%",
                                    style: TextStyle(
                                      color: double.parse(change24h) < 0
                                          ? Colors.red
                                          : Colors.green,
                                    )),
                                title: Row(children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      name,
                                      style: GoogleFonts.firaCode(
                                        textStyle:
                                            TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    price,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ]),
                                trailing: Theme(
                                  data: Theme.of(context).copyWith(
                                    cardColor: background,
                                  ),
                                  child: PopupMenuButton(
                                    onSelected: (choice) async {
                                      if (await SharedPrefs.getWatches(
                                          tags[index])) {
                                        SharedPrefs.deleteWatch(tags[index]);
                                        setState(() {});
                                        return;
                                      }

                                      SharedPrefs.storeSymbol(choice);
                                    },
                                    icon: Icon(Icons.more_vert,
                                        color: Colors.white),
                                    itemBuilder: (BuildContext context) {
                                      return <PopupMenuEntry<String>>[
                                        PopupMenuItem<String>(
                                          child: FutureBuilder(
                                            future: SharedPrefs.getWatches(
                                                tags[index]),
                                            builder: (context,
                                                AsyncSnapshot<bool> snapshot) {
                                              if (snapshot.hasData) {
                                                return data
                                                    ? Text("Unwatch",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white))
                                                    : Text("Watch",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white));
                                              } else {
                                                return Text("Watch",
                                                    style: TextStyle(
                                                        color: Colors.white));
                                                ;
                                              }
                                            },
                                          ),
                                          value: tags[index],
                                        ),
                                      ];
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
      // bottomNavigationBar: BottomNav(),
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
