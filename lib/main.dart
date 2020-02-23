import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ntpower/providers/p_device.dart';
import 'package:ntpower/providers/p_user.dart';
import 'package:ntpower/screens/devices_screen.dart';
import 'package:ntpower/screens/history_screen.dart';
import 'package:ntpower/screens/home_screen.dart';
import 'package:ntpower/screens/login_screen.dart';
import 'package:ntpower/screens/profile_screen.dart';
import 'package:ntpower/utils/f_user.dart';
import 'package:provider/provider.dart';

String url = 'https://polar-temple-18998.herokuapp.com';

void main() => runApp(MyApp());

SystemUiOverlayStyle mySystemUIOverlaySyle = SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.grey[50], // navigation bar color
    systemNavigationBarDividerColor: Colors.black26,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent // status bar color
    );

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String token;

  Future loadToken() async {
    token = await getToken();
    print(token);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadToken();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DeviceProvider(),
        ),
      ],
      child: BotToastInit(
        child: MaterialApp(
          title: 'NT Power',
          debugShowCheckedModeBanner: false,
          navigatorObservers: [BotToastNavigatorObserver()],
          theme: ThemeData(
            primaryColor: Color(0xFF047353),
            accentColor: Color(0xFFe2c472),
          ),
          home: token != null ? HomeScreen() : LoginScreen(),
          initialRoute: '/',
          routes: {
            HomeScreen.routeName: (context) => HomeScreen(),
            LoginScreen.routeName: (context) => LoginScreen(),
            ProfileScreen.routeName: (context) => ProfileScreen(),
            DevicesScreen.routeName: (context) => DevicesScreen(),
            HistoryScreen.routeName: (context) => HistoryScreen(),
          },
        ),
      ),
    );
  }
}
