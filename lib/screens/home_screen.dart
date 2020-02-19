import 'package:flutter/material.dart';
import 'package:ntpower/main.dart';
import 'package:ntpower/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home_screen';
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                          Icons.settings,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                      Expanded(
                        child: Center(
                          child: Text('NT POWER'),
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
                          'SENSOR CLOUD RS4521',
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
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 45),
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
                              onPressed: () {},
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
                              EnergyCard(),
                              SizedBox(width: 20),
                              EnergyCard(),
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
                              EnergyCard(),
                              SizedBox(width: 20),
                              EnergyCard(),
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
    return Expanded(
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(0),
        color: Theme.of(context).primaryColor,
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
                    'Ampere',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white12,
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7.5),
                        ),
                        child: Text(
                          'A',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Ampere',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
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
                    '395',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontSize: 22.5,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  Text(
                    '420',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ),
          ],
        ),
        onPressed: () {},
      ),
    );
  }
}
