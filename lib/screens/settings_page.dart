import 'package:colorite/components/drawer.dart';
import 'package:colorite/database/shared_pref.dart';
import 'package:colorite/utilities/color_helper.dart';
import 'package:colorite/utilities/constants.dart';
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            //main accent color
            Row(
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
            //gradient accent color
            Row(
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
            //toggle dark mode
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    'Toggle Dark Mode: ',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Transform.scale(
                  scale: 1.5,
                  child: Switch(
                    value: isSwitched,
                    onChanged: (value) {},
                    activeTrackColor: ColorHelper().getLightShade(lightSwitch),
                    activeColor: lightSwitch,
                    inactiveTrackColor: ColorHelper().getLightShade(darkSwitch),
                    inactiveThumbColor: darkSwitch,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
