import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../pageController.dart';
import 'package:google_fonts/google_fonts.dart';

class StockInfo extends StatefulWidget {
  final info;

  StockInfo(this.info);

  @override
  _CryptoInfoState createState() => _CryptoInfoState();
}

class _CryptoInfoState extends State<StockInfo> {
  @override
  Widget build(BuildContext context) {
    Color background = Color(0xff181818);
    Color foreground = Color(0xff222222);
    List<Color> gradientColors = [
      const Color(0xff23b6e6),
      const Color(0xff02d39a)
    ];
    var info = widget.info;

    print(info);
    Widget subtitle = info['regularMarketChangePercent'] < 0
        ? Row(
            children: [
              Icon(Icons.arrow_upward, color: Colors.red),
              Text(
                  " ^ ${info['regularMarketChange'].toString().substring(0, 4)} - ${info['regularMarketChangePercent'].toString().substring(0, 4)}%",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                  )),
            ],
          )
        : Row(
            children: [
              Icon(Icons.arrow_upward, color: Colors.green),
              Text(
                  " ${info['regularMarketChange'].toString().substring(0, 4)} + ${info['regularMarketChangePercent'].toString().substring(0, 4)}%",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 15,
                  )),
            ],
          );
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_sharp),/
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Home()));
              }),
          title: Text('Information'),
          centerTitle: true,
          backgroundColor: background,
        ),
        body: Container(
          color: background,
          child: SizedBox.expand(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    child: Center(
                      child: Text("Graph data will be here.",
                          style: TextStyle(color: Colors.white, fontSize: 15)),
                    ),
                    decoration: BoxDecoration(
                        color: foreground,
                        border: Border.all(
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    width: 380,
                    height: 200,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 14.0, left: 10.0),
                  child: Text(info['longName'],
                      style: GoogleFonts.varelaRound(
                          color: Colors.white, fontSize: 20)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0, left: 6.0),
                  child: subtitle,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 22.0),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: foreground,
                          border: Border.all(
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      width: 380,
                      height: 120,
                      child: Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Open",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18)),
                                          Text(
                                              "\$" +
                                                  info['regularMarketOpen']
                                                      .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14)),
                                          Padding(
                                            padding: const EdgeInsets.only(top:8.0),
                                            child: Text("Day high",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18)),
                                          ),
                                          Text(
                                              "\$" +=
                                                  info['regularMarketDayHigh']
                                                      .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14)),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Previous closing",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18)),
                                          Text(
                                              "\$" +
                                                  info['regularMarketPreviousClose']
                                                      .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14)),
                                          Padding(
                                            padding: const EdgeInsets.only(top:8.0),
                                            child: Text("Day low",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18)),
                                          ),
                                          Text(
                                              "\$" +
                                                  info['regularMarketDayLow']
                                                      .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
