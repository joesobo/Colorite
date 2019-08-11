import 'package:colorite/components/drawer.dart';
import 'package:colorite/utilities/color_helper.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final Color color;
  final bool isSwitched = false;

  final Color darkSwitch = Color(0xff3c344a);
  final Color lightSwitch = Color(0xffd9bd82);

  SettingsPage({this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: color,
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      drawer: SideDrawer(mainColor: color),
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
}
