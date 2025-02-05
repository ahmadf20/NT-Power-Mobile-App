import 'package:flutter/material.dart';
import 'package:ntpower/main.dart';
import 'package:ntpower/providers/p_user.dart';
import 'package:ntpower/screens/home_screen.dart';
import 'package:ntpower/utils/f_user.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTC = TextEditingController();
  final TextEditingController _passwordTC = TextEditingController();

  final FocusNode _emailFC = FocusNode();
  final FocusNode _passwordFC = FocusNode();

  String errorMessage = '';
  bool isLoading = false;

  Future handleSubmitted() async {
    FocusScope.of(context).unfocus();
    setState(() {
      isLoading = true;
      errorMessage = '';
    });
    try {
      var data = {"email": _emailTC.text, "password": _passwordTC.text};
      await login(data).then((response) async {
        if (response.contains('error')) {
          print(response);
          setState(() {
            errorMessage = response;
          });
        } else {
          await setToken(response);
          Provider.of<UserProvider>(context, listen: false).setToken(response);
          Navigator.of(context).pushNamed(HomeScreen.routeName);
        }
      });
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion(
        value: mySystemUIOverlaySyle,
        child: SafeArea(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Spacer(),
                    Image.asset(
                      'assets/images/icon2.png',
                      height: 175,
                    ),
                    Text(
                      'Sign In',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30, top: 20),
                      child: Text(
                        'Please sign in into your account',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Form(
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: 'Email',
                              suffixIcon: Icon(Icons.mail_outline),
                              errorText: errorMessage.contains('found')
                                  ? 'Email doesn\'t exist'
                                  : null,
                            ),
                            controller: _emailTC,
                            focusNode: _emailFC,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_passwordFC);
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
                              errorText: errorMessage.contains('match')
                                  ? 'Wrong password'
                                  : null,
                            ),
                            obscureText: true,
                            controller: _passwordTC,
                            focusNode: _passwordFC,
                            textInputAction: TextInputAction.done,
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: double.maxFinite,
                      height: 55,
                      margin: EdgeInsets.only(bottom: 30),
                      child: isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor,
                                ),
                              ),
                            )
                          : FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: Theme.of(context).primaryColor,
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onPressed: handleSubmitted,
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
