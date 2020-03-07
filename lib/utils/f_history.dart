import 'dart:convert';

import 'package:http/http.dart';
import 'package:ntpower/main.dart';
import 'package:ntpower/models/history.dart';
import 'package:ntpower/utils/f_user.dart';

Future getCurrentHistory(deviceCode) async {
  try {
    var token = await getToken();

    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      // 'X-Authorization': '$token'
    };

    print(header);

    var response = await get(
        '$url/api/manage_history/now/$deviceCode?token=$token',
        headers: header);

    print('${response.headers}\n${response.statusCode}\n${response.body}');

    var responseJson = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return historyFromJson(responseJson);
    } else if (responseJson['msg'] != null) {
      return responseJson['msg'];
    } else {
      return 'failed to login';
    }
  } catch (e) {
    return e;
  }
}

Future getAllHistory(deviceCode) async {
  try {
    var token = await getToken();

    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      // 'X-Authorization': '$token'
    };

    print(header);

    var response = await get(
        '$url/api/manage_history/$deviceCode/$deviceCode?token=$token',
        headers: header);

    print('${response.headers}\n${response.statusCode}\n${response.body}');

    var responseJson = jsonDecode(response.body);

    if (response.statusCode == 200) {
      List<History> list = [];

      for (var item in responseJson) {
        list.add(historyFromJson(item));
      }
      return list;
    } else if (responseJson['msg'] != null) {
      return responseJson['msg'];
    } else {
      return 'failed to login';
    }
  } catch (e) {
    return e;
  }
}
