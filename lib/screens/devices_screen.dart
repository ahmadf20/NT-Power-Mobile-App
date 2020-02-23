import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:ntpower/main.dart';
import 'package:ntpower/models/device.dart';
import 'package:ntpower/providers/p_device.dart';
import 'package:ntpower/utils/f_device.dart';
import 'package:ntpower/widgets/loading_animation.dart';
import 'package:provider/provider.dart';

class DevicesScreen extends StatefulWidget {
  static const routeName = 'devices_screen';

  DevicesScreen({Key key}) : super(key: key);

  @override
  DevicesScreenState createState() => DevicesScreenState();
}

class DevicesScreenState extends State<DevicesScreen> {
  bool isLoading = true;

  List<Device> listDevice = [];

  Future getDeviceList() async {
    try {
      await getDevices().then((response) {
        if (response is List<Device>) {
          listDevice = response;
          fetchActiveDevice();
        } else {
          BotToast.showText(text: response);
        }
      });
    } catch (e) {
      BotToast.showText(text: e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future fetchActiveDevice() async {
    try {
      String activeDeviceID = await getDeviceId();
      print(activeDeviceID);

      if (activeDeviceID == null) {
        await setDeviceId(listDevice[0].code);
        Provider.of<DeviceProvider>(context, listen: false)
            .setActiveDevice(listDevice[0]);
      } else {
        listDevice.forEach((device) {
          if (device.code == activeDeviceID) {
            Provider.of<DeviceProvider>(context, listen: false)
                .setActiveDevice(device);
          }
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getDeviceList();
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
                                'Device Information',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InformationCards(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 25),
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
                              ],
                            ),
                            SizedBox(height: 50),
                            DeviceCardList(
                              list: listDevice,
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

class DeviceCardList extends StatefulWidget {
  final List<Device> list;
  DeviceCardList({Key key, this.list}) : super(key: key);

  @override
  _DeviceCardListState createState() => _DeviceCardListState();
}

class _DeviceCardListState extends State<DeviceCardList> {
  List<Device> deviceList = [];

  @override
  void initState() {
    super.initState();
    deviceList = widget.list;
  }

  Widget _buildCard(int index) {
    var item = deviceList[index];
    Device activeDevice =
        Provider.of<DeviceProvider>(context).getActiveDevice();
    bool isActive = activeDevice.code == item.code;

    return Container(
      margin: EdgeInsets.only(bottom: 25),
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: isActive ? Theme.of(context).primaryColor : Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: FlatButton(
        onPressed: () {
          Provider.of<DeviceProvider>(context, listen: false)
              .setActiveDevice(item);
          setDeviceId(item.code);
        },
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                    color: isActive
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(7.5),
                  ),
                  child: Text(
                    (index + 1).toString(),
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 12,
                      color: isActive
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    item.deviceName.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: isActive ? Colors.white : Colors.black45,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.end,
                  ),
                )
              ],
            ),
            Text(
              item.code,
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: isActive ? Colors.white : Colors.black45,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(deviceList.length, (index) {
        return _buildCard(index);
      }),
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
    Device activeDevice =
        Provider.of<DeviceProvider>(context).getActiveDevice();
    return Column(
      children: <Widget>[
        _buildCard('Device Name', '${activeDevice.deviceName}'),
        _buildCard('Device Id', '${activeDevice.code}'),
        _buildCard('Device Address', '${activeDevice.address}'),
        _buildCard('Product Name/Model', '${activeDevice.productName}'),
      ],
    );
  }
}
