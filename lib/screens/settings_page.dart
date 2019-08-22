import 'package:colorite/components/drawer.dart';
import 'package:colorite/components/theme/custom_theme.dart';
import 'package:colorite/database/shared_pref.dart';
import 'package:colorite/utilities/constants.dart';
import 'package:colorite/utilities/my_themes.dart';
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
          children: <Widget>[
            //main accent color
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'Clear Main Accent Color: ',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 40,
                    child: FloatingActionButton(
                      heroTag: 'Btn1',
                      onPressed: () {
                        deleteMainColor();
                      },
                      elevation: 5,
                      backgroundColor: accentColor,
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
                    child: Text(
                      'Clear Gradient Accent Colors: ',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 40,
                    child: FloatingActionButton(
                      heroTag: 'Btn2',
                      onPressed: () {
                        deleteGradientColors();
                      },
                      elevation: 5,
                      backgroundColor: accentColor,
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
            //toggle dark mode
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 80,
                  height: 40,
                  child: FloatingActionButton(
                    heroTag: 'Btn3',
                    onPressed: () {
                      _changeTheme(context, MyThemeKeys.Dark);
                      print('dark');
                    },
                    elevation: 5,
                    backgroundColor: accentColor,
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
                  width: 80,
                  height: 40,
                  child: FloatingActionButton(
                    heroTag: 'Btn4',
                    onPressed: () {
                      _changeTheme(context, MyThemeKeys.Light);
                      print('light');
                    },
                    elevation: 5,
                    backgroundColor: accentColor,
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
