import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'pageController.dart';

class CryptoInfo extends StatefulWidget {
  final info;

  CryptoInfo(this.info);

  @override
  _CryptoInfoState createState() => _CryptoInfoState();
}

class _CryptoInfoState extends State<CryptoInfo> {
  @override
  Widget build(BuildContext context) {
    Color background = Color(0xff181818);
    List<Color> gradientColors = [
      const Color(0xff23b6e6),
      const Color(0xff02d39a)
    ];

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_sharp),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Home()));
              }),
          title: Text(widget.info['symbol']),
          centerTitle: true,
          backgroundColor: background,
        ),
        body: Container(
            color: background,
            child: SizedBox.expand(
              child: Column(
                children: [
                  // LineChart(
                  //   LineChartData(
                  //     minX: 0,
                  //     maxX: 11,
                  //     minY: 0,
                  //     maxY: 6,
                  //     borderData: FlBorderData(
                  //       show: true,
                  //       border: Border.all(color: Color(0xff37434d), width: 2),
                  //     ),
                  //     lineBarsData: [
                  //       LineChartBarData(
                  //         isCurved: true,
                  //         colors: gradientColors,
                  //         belowBarData: BarAreaData(
                  //           show: true,
                  //           colors: gradientColors
                  //               .map((color) => color.withOpacity(0.3))
                  //               .toList(),
                  //         ),
                  //         spots: [
                  //           FlSpot(0, 3),
                  //           FlSpot(0, 3),
                  //           FlSpot(2.6, 2),
                  //           FlSpot(4.9, 5),
                  //           FlSpot(6.8, 2.5),
                  //           FlSpot(8, 4),
                  //           FlSpot(9.5, 3),
                  //           FlSpot(11, 4),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Container(
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        color: Color(0xff222222),
                        child: ListTile(
                          title: Text("test"),
                        )),
                  )
                ],
              ),
            )));
  }
}
