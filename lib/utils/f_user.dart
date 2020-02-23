import 'dart:convert';

import 'package:http/http.dart';
import 'package:ntpower/main.dart';
import 'package:ntpower/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future setToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('token', token);
}

Future getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  return token;
}

Future removeToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('token');
}

Future<String> login(var data) async {
  var body = jsonEncode(data);
  var header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  try {
    var response = await post('$url/api/authentication/login',
        body: body, headers: header);

    print('${response.headers}\n${response.statusCode}\n${response.body}');

    var responseJson = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return responseJson['token'];
    } else if (responseJson['msg'] != null) {
      return 'error:' + responseJson['msg'];
    } else {
      return 'error has occured';
    }
  } catch (e) {
    return e;
  }
}

Future getUser() async {
  try {
    var token = await getToken();

    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'X-Authorization': token
    };

    var response = await get('$url/api/manage_user', headers: header);

    print('${response.headers}\n${response.statusCode}\n${response.body}');

    var responseJson = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return userFromJson(responseJson[0]);
    } else if (responseJson['msg'] != null) {
      return responseJson['msg'];
    } else {
      return 'failed to login';
    }
  } catch (e) {
    return e;
  }
}

Future updateUser(var data) async {
  try {
    var token = await getToken();

    var body = jsonEncode(data);
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'X-Authorization': token
    };

    var response =
        await put('$url/api/manage_user', body: body, headers: header);

    print('${response.headers}\n${response.statusCode}\n${response.body}');

    var responseJson = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return true;
    } else if (responseJson['msg'] != null) {
      return 'error:' + responseJson['msg'];
    } else {
      return 'error has occured';
    }
  } catch (e) {
    return e;
  }
}
