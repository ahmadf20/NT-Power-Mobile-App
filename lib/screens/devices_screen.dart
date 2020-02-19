import 'package:flutter/material.dart';
import 'package:ntpower/main.dart';

class DevicesScreen extends StatefulWidget {
  static const routeName = 'devices_screen';

  DevicesScreen({Key key}) : super(key: key);

  @override
  DevicesScreenState createState() => DevicesScreenState();
}

class DevicesScreenState extends State<DevicesScreen> {
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
                          'Device Information',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: IconButton(
                          icon: Icon(Icons.add_box),
                          onPressed: () {
                            // Navigator.of(context)
                            //     .pushNamed(DevicesScreen.routeName);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                InformationCards(),
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
                                'Your Devices',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Tap on the one of the cards below',
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
                                Icons.edit,
                                size: 20,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                      DeviceCardList(),
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

class DeviceCardList extends StatefulWidget {
  DeviceCardList({Key key}) : super(key: key);

  @override
  _DeviceCardListState createState() => _DeviceCardListState();
}

class _DeviceCardListState extends State<DeviceCardList> {
  Widget _buildCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
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
                  '1',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 12,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'SENSOR CLOUD RS234',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.end,
                ),
              )
            ],
          ),
          Text(
            '45678909898765',
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildCard(),
        _buildCard(),
        _buildCard(),
        _buildCard(),
      ],
    );
  }
}

class InformationCards extends StatelessWidget {
  const InformationCards({Key key}) : super(key: key);

  Widget _buildCard(String title, String subtitle) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 12,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildCard('Device Name', 'SENSOR CLOUD RS567'),
        _buildCard('Device Id', '456789056789'),
        _buildCard('Device Address', 'Cipageran Asri, Cimahi Utara'),
        _buildCard('Product Namee/Model', 'IOT100'),
      ],
    );
  }
}
