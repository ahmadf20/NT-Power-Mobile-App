import 'package:flutter/material.dart';
import 'package:ntpower/main.dart';
import 'package:ntpower/models/history.dart';
import 'package:ntpower/screens/devices_screen.dart';
import 'package:ntpower/screens/history_screen.dart';
import 'package:ntpower/screens/profile_screen.dart';
import 'package:ntpower/utils/f_device.dart';
import 'package:ntpower/utils/f_history.dart';
import 'package:ntpower/widgets/loading_animation.dart';

enum Menu { ampere, kwh, volt }

class HomeScreen extends StatefulWidget {
  static const routeName = 'home_screen';
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  History currentHistory;

  Menu selectedMenu = Menu.ampere;

  Future fetchCurrentHistory() async {
    var deviceCode = await getDeviceId();

    try {
      await getCurrentHistory(deviceCode).then((response) {
        if (response is History) {
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
    fetchCurrentHistory();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: mySystemUIOverlaySyle.copyWith(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: isLoading
              ? loadingIcon(color: Colors.white)
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
                                Icons.settings,
                                color: Colors.white,
                              ),
                              onPressed: () => Navigator.of(context)
                                  .pushNamed(DevicesScreen.routeName),
                            ),
                            Expanded(
                              child: Center(
                                child: Image.asset(
                                  'assets/images/icon3.png',
                                  height: 25,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.person_outline,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(ProfileScreen.routeName);
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 200,
                        width: 200,
                        margin: EdgeInsets.only(top: 35),
                        child: Placeholder(),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(right: 25, top: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'Device',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                '${currentHistory.deviceName}',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 45),
                        margin: EdgeInsets.only(top: 50),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 50,
                                offset: Offset(0, -5),
                              )
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Energy Consumption',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Shows energy input - output in real time',
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
                                      Icons.trending_up,
                                      size: 20,
                                    ),
                                    onPressed: () => Navigator.of(context)
                                        .pushNamed(HistoryScreen.routeName),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 35),
                              child: Container(
                                height: 125,
                                child: Row(
                                  children: <Widget>[
                                    EnergyCard(
                                      title: 'Ampere',
                                      tag: 'A',
                                      value: Menu.ampere,
                                      groupValue: selectedMenu,
                                      onPressed: (value) {
                                        print(value);
                                        setState(() {
                                          selectedMenu = value;
                                        });
                                      },
                                      data: {
                                        'input': currentHistory.avgInput,
                                        'output': currentHistory.avgOutput
                                      },
                                    ),
                                    SizedBox(width: 20),
                                    EnergyCard(
                                      title: 'kWh',
                                      tag: 'w',
                                      value: Menu.kwh,
                                      groupValue: selectedMenu,
                                      onPressed: (value) {
                                        setState(() {
                                          selectedMenu = value;
                                        });
                                      },
                                      data: {
                                        'input': currentHistory.kwhInput,
                                        'output': currentHistory.kwhOutput,
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                height: 125,
                                child: Row(
                                  children: <Widget>[
                                    EnergyCard(
                                      title: 'Volt',
                                      tag: 'V',
                                      value: Menu.volt,
                                      groupValue: selectedMenu,
                                      onPressed: (value) {
                                        setState(() {
                                          selectedMenu = value;
                                        });
                                      },
                                      data: {
                                        'input': currentHistory.voltageInput,
                                        'output': currentHistory.voltageOutput,
                                      },
                                    ),
                                    SizedBox(width: 20),
                                    EnergyCard(
                                      title: 'Volt',
                                      tag: 'V',
                                      value: Menu.volt,
                                      groupValue: selectedMenu,
                                      onPressed: (value) {
                                        setState(() {
                                          selectedMenu = value;
                                        });
                                      },
                                      data: {
                                        'input': currentHistory.voltageInput,
                                        'output': currentHistory.voltageOutput,
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
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

class EnergyCard extends StatefulWidget {
  final Function(dynamic) onPressed;
  final String title;
  final String tag;
  final Map data;
  final value;
  final groupValue;

  EnergyCard(
      {Key key,
      this.onPressed,
      this.title,
      this.tag,
      this.data,
      this.value,
      this.groupValue})
      : super(key: key);

  @override
  _EnergyCardState createState() => _EnergyCardState();
}

class _EnergyCardState extends State<EnergyCard> {
  @override
  Widget build(BuildContext context) {
    var isSelected = widget.groupValue == widget.value;
    return Expanded(
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(0),
        color: isSelected ? Theme.of(context).primaryColor : Colors.grey[200],
        child: Stack(
          children: <Widget>[
            Container(
              height: double.maxFinite,
              width: double.maxFinite,
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(bottom: 20),
              child: ClipRect(
                child: Transform.translate(
                  offset: Offset(-10, 0),
                  child: Text(
                    '${widget.title}',
                    style: TextStyle(
                      fontSize: 35,
                      color: isSelected ? Colors.white12 : Colors.black12,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.maxFinite,
              height: double.maxFinite,
              padding: EdgeInsets.all(17.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 20,
                        height: 20,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(7.5),
                        ),
                        child: Text(
                          '${widget.tag}',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12,
                            color: isSelected
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${widget.title}',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: isSelected ? Colors.white : Colors.grey,
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  Text(
                    '${widget.data['input']}',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: isSelected ? Colors.white : Colors.grey,
                      fontSize: 22.5,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  Text(
                    '${widget.data['output']}',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: isSelected ? Colors.white : Colors.grey,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ),
          ],
        ),
        onPressed: () => widget.onPressed(widget.value),
      ),
    );
  }
}
