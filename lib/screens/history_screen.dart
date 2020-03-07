import 'package:flutter/material.dart';
import 'package:ntpower/main.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:ntpower/models/history.dart';
import 'package:ntpower/utils/f_device.dart';
import 'package:ntpower/utils/f_history.dart';
import 'package:ntpower/widgets/loading_animation.dart';

enum Menu { ampere, kwh, volt }

class HistoryScreen extends StatefulWidget {
  static const routeName = 'history_screen';

  HistoryScreen({Key key}) : super(key: key);

  @override
  HistoryScreenState createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  List<History> currentHistory = [];
  bool isLoading = true;

  Menu selectedMenu = Menu.ampere;

  Future fetchDataHistory() async {
    var deviceCode = await getDeviceId();

    try {
      await getAllHistory(deviceCode).then((response) {
        if (response is List<History>) {
          setState(() {
            currentHistory = response;
          });
        } else {
          print(response);
        }
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDataHistory();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: mySystemUIOverlaySyle,
      child: Scaffold(
        body: SafeArea(
          child: isLoading
              ? loadingIcon()
              : SingleChildScrollView(
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
                      Container(
                        height: 300,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: EnergyChart(
                          data: currentHistory,
                          type: selectedMenu,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              child: Container(
                                height: 50,
                                width: 100,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: selectedMenu == Menu.ampere
                                      ? Theme.of(context).primaryColor
                                      : Colors.grey[300],
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'Ampere',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: selectedMenu == Menu.ampere
                                        ? Colors.white
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  selectedMenu = Menu.ampere;
                                });
                              },
                            ),
                            SizedBox(width: 5),
                            GestureDetector(
                              child: Container(
                                height: 50,
                                width: 100,
                                color: selectedMenu == Menu.volt
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey[300],
                                alignment: Alignment.center,
                                child: Text(
                                  'Voltage',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: selectedMenu == Menu.volt
                                        ? Colors.white
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  selectedMenu = Menu.volt;
                                });
                              },
                            ),
                            SizedBox(width: 5),
                            GestureDetector(
                              child: Container(
                                height: 50,
                                width: 100,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: selectedMenu == Menu.kwh
                                      ? Theme.of(context).primaryColor
                                      : Colors.grey[300],
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'kWh',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: selectedMenu == Menu.kwh
                                        ? Colors.white
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  selectedMenu = Menu.kwh;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 40),
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
                                // SizedBox(
                                //   width: 40,
                                //   height: 40,
                                //   child: FlatButton(
                                //     color: Colors.grey[200],
                                //     padding: EdgeInsets.all(0),
                                //     shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(15),
                                //     ),
                                //     child: Icon(
                                //       Icons.date_range,
                                //       size: 20,
                                //     ),
                                //     onPressed: () {},
                                //   ),
                                // ),
                              ],
                            ),
                            SizedBox(height: 50),
                            DataTableHistory(data: currentHistory),
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

class EnergySeries {
  final DateTime time;
  final int energy;

  EnergySeries({this.time, this.energy});
}

class EnergyChart extends StatelessWidget {
  final List<History> data;
  final Menu type;

  const EnergyChart({Key key, @required this.data, this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(type.toString());
    final List<EnergySeries> input = [
      EnergySeries(time: DateTime(2020, 1, 1), energy: 10),
    ];

    final List<EnergySeries> ouput = [
      EnergySeries(time: DateTime(2020, 1, 1), energy: 12),
    ];
    final List<EnergySeries> saving = [
      EnergySeries(time: DateTime(2020, 1, 1), energy: 65),
    ];
    data.sort((a, b) => a.date.compareTo(b.date));

    if (type == Menu.ampere) {
      data.forEach((item) {
        input.add(EnergySeries(
          energy: int.parse(item.avgInput),
          time: item.date,
        ));
        ouput.add(EnergySeries(
          energy: int.parse(item.avgOutput),
          time: item.date,
        ));
        saving.add(EnergySeries(
          energy: (int.parse(item.avgOutput) - int.parse(item.avgInput)) *
              100 ~/
              int.parse(item.avgOutput),
          time: item.date,
        ));
      });
    } else if (type == Menu.volt) {
      data.forEach((item) {
        input.add(EnergySeries(
          energy: int.parse(item.voltageInput),
          time: item.date,
        ));
        ouput.add(EnergySeries(
          energy: int.parse(item.voltageOutput),
          time: item.date,
        ));
      });
    } else {
      data.forEach((item) {
        input.add(EnergySeries(
          energy: int.parse(item.kwhInput),
          time: item.date,
        ));
        ouput.add(EnergySeries(
          energy: int.parse(item.kwhOutput),
          time: item.date,
        ));
        saving.add(EnergySeries(
          energy: (int.parse(item.kwhOutput) - int.parse(item.kwhInput)) *
              100 ~/
              int.parse(item.kwhOutput),
          time: item.date,
        ));
      });
    }

    List<charts.Series<EnergySeries, DateTime>> series = [
      charts.Series(
        id: "Input",
        data: input,
        domainFn: (EnergySeries series, _) => series.time,
        measureFn: (EnergySeries series, _) => series.energy,
        colorFn: (_, __) => charts.Color.fromHex(code: '#8B8B8B'),
      ),
      charts.Series(
        id: "Ouput",
        data: ouput,
        domainFn: (EnergySeries series, _) => series.time,
        measureFn: (EnergySeries series, _) => series.energy,
        colorFn: (_, __) => charts.Color.fromHex(code: '#E2c743'),
      ),
      charts.Series(
        id: "Saving",
        data: saving,
        domainFn: (EnergySeries series, _) => series.time,
        measureFn: (EnergySeries series, _) => series.energy,
        colorFn: (_, __) => charts.Color.fromHex(code: '#057454'),
      ),
    ];

    return Container(
      child: charts.TimeSeriesChart(
        series,
        animate: true,
        behaviors: [
          new charts.SeriesLegend(
            position: charts.BehaviorPosition.bottom,
            entryTextStyle: charts.TextStyleSpec(fontFamily: 'Montserrat'),
          ),
        ],
        defaultRenderer: new charts.BarRendererConfig(strokeWidthPx: 2.5),
      ),
    );
  }
}

class DataTableHistory extends StatelessWidget {
  final List<History> data;
  const DataTableHistory({Key key, this.data}) : super(key: key);

  Widget createLabel(String title, IconData icon, Color color) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          size: 15,
          color: color,
        ),
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Montserrat',
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Spacer(),
              Flexible(
                child: Center(
                  child: Text(
                    'Ampere',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                flex: 4,
              ),
              Flexible(
                child: Center(
                  child: Text(
                    'kWh',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                flex: 4,
              ),
            ],
          ),
          DataTable(
            columns: [
              DataColumn(
                label: createLabel('Date', null, Colors.blue),
              ),
              DataColumn(
                label:
                    createLabel('In', Icons.arrow_downward, Colors.blueAccent),
              ),
              DataColumn(
                label: createLabel('Out', Icons.arrow_upward, Colors.orange),
              ),
              DataColumn(
                label: createLabel('Save', Icons.save_alt, Colors.green),
              ),
              DataColumn(
                label: createLabel('In', Icons.arrow_downward, Colors.blue),
              ),
              DataColumn(
                label: createLabel('Out', Icons.arrow_upward, Colors.orange),
              ),
              DataColumn(
                label: createLabel('Save', Icons.save_alt, Colors.green),
              ),
            ],
            rows: data.map((item) {
              return DataRow(
                cells: [
                  DataCell(Center(
                      child: Text(
                    '${item.date.month}/${(item.date.year).toString().substring(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ))),
                  DataCell(Center(child: Text('${item.avgInput}'))),
                  DataCell(Center(child: Text('${item.avgOutput}'))),
                  DataCell(
                    Center(
                        child: Text(((int.parse(item.avgOutput) -
                                        int.parse(item.avgInput)) *
                                    100 ~/
                                    int.parse(item.avgInput))
                                .toString() +
                            '%')),
                  ),
                  DataCell(Center(child: Text('${item.kwhInput}'))),
                  DataCell(Center(child: Text('${item.kwhOutput}'))),
                  DataCell(
                    Center(
                        child: Text((((int.parse(item.kwhOutput) -
                                        int.parse(item.kwhInput)) *
                                    100 ~/
                                    int.parse(item.kwhOutput))
                                .toString() +
                            '%'))),
                  )
                ],
              );
            }).toList(),
            horizontalMargin: 0,
            columnSpacing: 0,
          ),
        ],
      ),
    );
  }
}
