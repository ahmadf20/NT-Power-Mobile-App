import 'package:flutter/material.dart';
import 'package:ntpower/main.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HistoryScreen extends StatefulWidget {
  static const routeName = 'history_screen';

  HistoryScreen({Key key}) : super(key: key);

  @override
  HistoryScreenState createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: mySystemUIOverlaySyle,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'History',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ChartHistory(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Data Table',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Shows your energy usage annualy',
                                style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: FlatButton(
                              color: Colors.grey[200],
                              padding: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Icon(
                                Icons.date_range,
                                size: 20,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChartHistory extends StatelessWidget {
  const ChartHistory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfCartesianChart(
          plotAreaBorderWidth: 0,
          tooltipBehavior: TooltipBehavior(enable: true),
          primaryYAxis: NumericAxis(
              majorGridLines: MajorGridLines(width: 0),
              axisLine: AxisLine(color: Colors.white),
              interval: 100,
              visibleMaximum: 500),
          primaryXAxis: CategoryAxis(
            plotOffset: -7.5,
            majorGridLines: MajorGridLines(width: 0),
            majorTickLines: MajorTickLines(width: 0),
            rangePadding: ChartRangePadding.none,
          ),
          series: <ChartSeries>[
            SplineSeries<SalesData, String>(
                name: 'Pemasukkan Poin',
                color: Color(0xffffd800),
                splineType: SplineType.cardinal,
                cardinalSplineTension: 0.7,
                dataSource: chartDummyData,
                xValueMapper: (SalesData sales, _) => sales.year,
                yValueMapper: (SalesData sales, _) => sales.sales)
          ]),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

var chartDummyData = <SalesData>[
  SalesData('Minggu 1', 150),
  SalesData('Minggu 2', 100),
  SalesData('Minggu 3', 350),
  SalesData('Minggu 4', 200),
];
