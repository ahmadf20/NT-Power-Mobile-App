import 'package:flutter/material.dart';
import 'package:ntpower/main.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = 'edit_profile_screen';

  ProfileScreen({Key key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
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
                            // Navigator.of(context)
                            //     .pushNamed(ProfileScreen.routeName);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
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
                                          borderRadius:
                                              BorderRadius.circular(7.5),
                                        ),
                                        child: Text(
                                          'A',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 12,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Ahmad Faaiz A',
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
                                Icons.edit,
                                size: 20,
                              ),
                              onPressed: () {},
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
                              // controller: _emailTC,
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
                              // controller: _emailTC,
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
                              obscureText: true,
                              // controller: _passwordTC,
                              // focusNode: _passwordFC,
                              textInputAction: TextInputAction.done,
                            ),
                            Container(
                              width: double.maxFinite,
                              height: 55,
                              margin: EdgeInsets.only(bottom: 30, top: 50),
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: Theme.of(context).primaryColor,
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
                                  // Navigator.of(context)
                                  //     .pushNamed(HomeScreen.routeName);
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
}
