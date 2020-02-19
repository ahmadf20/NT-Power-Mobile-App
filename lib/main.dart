import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ntpower/screens/devices_screen.dart';
import 'package:ntpower/screens/history_screen.dart';
import 'package:ntpower/screens/home_screen.dart';
import 'package:ntpower/screens/login_screen.dart';
import 'package:ntpower/screens/profile_screen.dart';

void main() => runApp(MyApp());

SystemUiOverlayStyle mySystemUIOverlaySyle = SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.grey[50], // navigation bar color
    systemNavigationBarDividerColor: Colors.black26,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent // status bar color
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      // debugShowMaterialGrid: true,
      title: 'NT Power',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF047353),
        accentColor: Color(0xFFe2c472),
      ),
      home: LoginScreen(),
      initialRoute: '/',
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        ProfileScreen.routeName: (context) => ProfileScreen(),
        DevicesScreen.routeName: (context) => DevicesScreen(),
        HistoryScreen.routeName: (context) => HistoryScreen(),
      },
    );
  }
}
