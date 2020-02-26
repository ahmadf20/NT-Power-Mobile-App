import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:ntpower/main.dart';
import 'package:ntpower/models/user.dart';
import 'package:ntpower/providers/p_device.dart';
import 'package:ntpower/providers/p_user.dart';
import 'package:ntpower/screens/login_screen.dart';
import 'package:ntpower/utils/f_user.dart';
import 'package:ntpower/widgets/loading_animation.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = 'edit_profile_screen';

  ProfileScreen({Key key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _emailTC = TextEditingController();
  final TextEditingController _usernameTC = TextEditingController();
  final TextEditingController _passwordTC = TextEditingController();
  final TextEditingController _oldPassTC = TextEditingController();

  bool isEditable = false;
  User user;

  bool isLoading = false;

  Future fetchUser() async {
    try {
      await getUser().then((response) {
        if (response is User) {
          setState(() {
            user = response;
          });
          setInitalValue();
        } else {
          print(response);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  setInitalValue() {
    setState(() {
      _emailTC.text = user.email;
      _usernameTC.text = user.name;
      _passwordTC.text = 'password';
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: mySystemUIOverlaySyle,
      child: Scaffold(
        body: SafeArea(
          child: user == null
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
                                'Profile',
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
                                icon: Icon(
                                  Icons.exit_to_app,
                                ),
                                onPressed: () {
                                  Provider.of<UserProvider>(context,
                                          listen: false)
                                      .clearData();
                                  Provider.of<DeviceProvider>(context,
                                          listen: false)
                                      .clearData();
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      LoginScreen.routeName, (e) => false);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 25),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 150,
                              margin: EdgeInsets.only(bottom: 50),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
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
                                          'Energy Saving',
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              width: 20,
                                              height: 20,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(7.5),
                                              ),
                                              child: Text(
                                                user.name.substring(0, 1),
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 12,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                user.name,
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                                textAlign: TextAlign.end,
                                              ),
                                            )
                                          ],
                                        ),
                                        Spacer(),
                                        Text(
                                          '3556,345',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: 22.5,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.end,
                                        ),
                                        Text(
                                          'kWh',
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
                            ),
                            Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Information Detail',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Tap on the edit button to edit your data',
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
                                      isEditable ? Icons.close : Icons.edit,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      if (isEditable) {
                                        setState(() {
                                          isEditable = !isEditable;
                                        });
                                      } else {
                                        inputOldPassDialog();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 50),
                            Form(
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelText: 'Username',
                                      suffixIcon: Icon(Icons.person_outline),
                                    ),
                                    style: TextStyle(fontFamily: 'OpenSans'),
                                    enabled: isEditable,
                                    controller: _usernameTC,
                                    // focusNode: _emailFC,

                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) {
                                      // FocusScope.of(context).requestFocus(_passwordFC);
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelText: 'Email',
                                      suffixIcon: Icon(Icons.mail_outline),
                                    ),
                                    style: TextStyle(fontFamily: 'OpenSans'),
                                    enabled: isEditable,
                                    controller: _emailTC,
                                    // focusNode: _emailFC,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) {
                                      // FocusScope.of(context).requestFocus(_passwordFC);
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelText: 'Password',
                                      suffixIcon: Icon(Icons.lock_outline),
                                    ),
                                    style: TextStyle(fontFamily: 'OpenSans'),
                                    enabled: isEditable,
                                    obscureText: true,

                                    controller: _passwordTC,
                                    // focusNode: _passwordFC,
                                    textInputAction: TextInputAction.done,
                                  ),
                                  !isEditable
                                      ? Container()
                                      : Container(
                                          width: double.maxFinite,
                                          height: 55,
                                          margin: EdgeInsets.only(
                                              bottom: 30, top: 50),
                                          child: FlatButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            color:
                                                Theme.of(context).primaryColor,
                                            child: Text(
                                              'Update',
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            onPressed: () {
                                              updateUserInfo();
                                            },
                                          ),
                                        ),
                                ],
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

  void inputOldPassDialog() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(25, 25, 25, 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.5),
          ),
          content: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              labelText: 'Password',
              suffixIcon: Icon(Icons.lock_outline),
            ),
            obscureText: true,
            controller: _oldPassTC,
            textInputAction: TextInputAction.done,
            autofocus: true,
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: Colors.grey[150],
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: () {
                  _oldPassTC.clear();
                  return Navigator.of(context).pop();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, bottom: 15),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: Theme.of(context).primaryColor,
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  inputPasswordSubmit();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Future inputPasswordSubmit() async {
    Navigator.of(context).pop();
    BotToast.showCustomLoading(toastBuilder: (context) => loadingIcon());

    try {
      var data = {"email": user.email, "password": _oldPassTC.text};
      await login(data).then(
        (response) async {
          BotToast.closeAllLoading();

          if (response.contains('error')) {
            BotToast.showText(text: 'Wrong Password');
          } else {
            setState(() {
              isEditable = true;
              _passwordTC.text = _oldPassTC.text;
            });
          }
        },
      );
    } catch (e) {
      BotToast.showText(text: e);
    } finally {
      _oldPassTC.clear();
      BotToast.closeAllLoading();
    }
  }

  Future updateUserInfo() async {
    Map data = {
      "email": _emailTC.text,
      "name": _usernameTC.text,
      "password": _passwordTC.text
    };

    BotToast.showCustomLoading(toastBuilder: (context) => loadingIcon());

    try {
      await updateUser(data).then((response) {
        if (response == true) {
          setState(() {
            isEditable = false;
          });
          BotToast.showText(text: 'Successfully updated');
        } else if (response is String) {
          BotToast.showText(text: response);
        } else {
          BotToast.showText(text: 'error has occured');
        }
      });
    } catch (e) {
      BotToast.showText(text: e);
    } finally {
      BotToast.closeAllLoading();
    }
  }
}
