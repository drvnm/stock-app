import 'package:flutter/material.dart';
import 'package:finance_quote/finance_quote.dart';
import 'package:google_fonts/google_fonts.dart';


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
        title: Text("API test"),
        centerTitle: true,
        backgroundColor: background,
      ),
      body: Container(
        color: background,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: FinanceQuote.getRawData(
                quoteProvider: QuoteProvider.yahoo,
                symbols: <String>[
                  'GOOG'
                  
                ]),
            builder: (context,
                AsyncSnapshot<Map<String, Map<String, dynamic>>> snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);

                tags = snapshot.data.keys.toList();
                print(tags);
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    String change24h = snapshot.data[tags[index]]
                            ['changePercent24Hr']
                        .substring(0, 4);
                    String priceRaw = snapshot.data[tags[index]]["regularMarketPrice:"];
                    String price =
                        "\$" + priceRaw.substring(0, priceRaw.indexOf(".") + 3);
                    String name = snapshot.data[tags[index]]['symbol'];
                    return Container(
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          color: Color(0xff222222),
                          child: ListTile(
                            subtitle: Text(change24h + "%",
                                style: TextStyle(
                                  color: double.parse(change24h) < 0
                                      ? Colors.red
                                      : Colors.green,
                                )),
                            title: Row(
                              children: [
                                Text(name,
                                    style: GoogleFonts.firaCode(textStyle: TextStyle(color: Colors.white))),
                                Padding(
                                  padding: const EdgeInsets.only(left: 48.0),
                                  child: Column(
                                    children: [
                                      Text(price,
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            trailing: Icon(
                              Icons.chevron_right_sharp,
                              color: Colors.white,
                            ),
                          )),
                    );
                  },
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
  