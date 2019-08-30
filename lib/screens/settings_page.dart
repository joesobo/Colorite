import 'package:palytte/components/drawer.dart';
import 'package:palytte/components/theme/custom_theme.dart';
import 'package:palytte/database/shared_pref.dart';
import 'package:palytte/utilities/constants.dart';
import 'package:palytte/utilities/my_themes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Color mainColor;
  final bool isSwitched = false;

  final Color darkSwitch = Color(0xff3c344a);
  final Color lightSwitch = Color(0xffd9bd82);

  @override
  void initState() {
    getColor();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: mainColor,
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      drawer: SideDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //main accent color
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Container(
                      width: 260,
                      child: Text(
                        'Clear Main Accent Color: ',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 40,
                    child: FloatingActionButton(
                      heroTag: 'Btn1',
                      onPressed: () {
                        deleteMainColor();
                      },
                      elevation: 5,
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Clear',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
            //gradient accent color
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Container(
                      width: 260,
                      child: Text(
                        'Clear Gradient Accent Colors: ',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 40,
                    child: FloatingActionButton(
                      heroTag: 'Btn2',
                      onPressed: () {
                        deleteGradientColors();
                      },
                      elevation: 5,
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Clear',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 32,
            ),
            //toggle dark mode
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
              child: Text(
                'Toggle Theme of App:',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(horizontal: 12),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 120,
                      height: 40,
                      child: FloatingActionButton(
                        heroTag: 'Btn3',
                        onPressed: () {
                          _changeTheme(context, MyThemeKeys.Dark);
                          print('dark');
                        },
                        elevation: 5,
                        backgroundColor: Color(0xff392e42),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'Dark',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 40,
                      child: FloatingActionButton(
                        heroTag: 'Btn4',
                        onPressed: () {
                          _changeTheme(context, MyThemeKeys.Light);
                          print('light');
                        },
                        elevation: 5,
                        backgroundColor: Color(0xffe6d693),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'Light',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _changeTheme(BuildContext buildContext, MyThemeKeys key) {
    CustomTheme.instanceOf(buildContext).changeTheme(key);
  }

  //returns shared preferences accent color
  void getColor() async {
    SharedPref sharedPref = new SharedPref();
    Color color = await sharedPref.loadColor('mainAccent', accentColor);

    setState(() {
      mainColor = color;
    });
  }

  void deleteMainColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('mainAccent');
    setState(() {
      mainColor = accentColor;
    });
  }

  void deleteGradientColors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('gradientAccent1');
    prefs.remove('gradientAccent2');
  }
}
