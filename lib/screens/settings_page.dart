import 'package:colorite/components/drawer.dart';
import 'package:colorite/database/shared_pref.dart';
import 'package:colorite/utilities/color_helper.dart';
import 'package:flutter/material.dart';

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
    Color color = await sharedPref.loadColor('mainAccent');

    setState(() {
      mainColor = color;
    });
  }
}
