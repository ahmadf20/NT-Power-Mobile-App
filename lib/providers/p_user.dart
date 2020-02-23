import 'package:flutter/cupertino.dart';
import 'package:ntpower/utils/f_user.dart' as FUser;
import 'package:ntpower/models/user.dart';

class UserProvider extends ChangeNotifier {
  String _token;
  User _user;

  String getToken() {
    return _token;
  }

  void setToken(String token) {
    _token = token;
    FUser.setToken(token);
    notifyListeners();
  }

  User getUser() {
    return _user;
  }

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void clearData() {
    _token = null;
    _user = null;
    FUser.removeToken();
    notifyListeners();
  }
}
