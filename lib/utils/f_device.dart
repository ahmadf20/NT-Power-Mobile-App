import 'dart:convert';

import 'package:http/http.dart';
import 'package:ntpower/main.dart';
import 'package:ntpower/models/device.dart';
import 'package:ntpower/utils/f_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future setDeviceId(String deviceId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('activeDeviceId', deviceId);
}

Future getDeviceId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String deviceId = prefs.getString('activeDeviceId');
  return deviceId;
}

Future removeDeviceId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('activeDeviceId');
}

Future getDevices() async {
  try {
    var token = await getToken();

    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'X-Authorization': token
    };

    var response = await get('$url/api/manage_device/user', headers: header);

    print('${response.headers}\n${response.statusCode}\n${response.body}');

    var responseJson = jsonDecode(response.body);

    if (response.statusCode == 200) {
      List<Device> listDevice = [];
      for (var item in responseJson) {
        listDevice.add(deviceFromJson(item));
      }
      return listDevice;
    } else if (responseJson['msg'] != null) {
      return responseJson['msg'];
    } else {
      return 'failed to get device list';
    }
  } catch (e) {
    return e;
  }
}
