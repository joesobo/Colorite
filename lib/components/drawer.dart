import 'package:colorite/screens/gradient_page.dart';
import 'package:colorite/screens/home_page.dart';
import 'package:colorite/screens/palette_page.dart';
import 'package:colorite/screens/settings_page.dart';
import 'package:colorite/utilities/constants.dart';
import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  final Color mainColor;
  final Color color1;
  final Color color2;

  SideDrawer({this.mainColor, this.color1, this.color2});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Icon(
                Icons.colorize,
                size: 64,
                color: mainColor,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FlatButton(
                  child: Text(
                    'Colors',
                    textAlign: TextAlign.start,
                    style: defaultText,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(mainColor: mainColor),
                      ),
                    );
                  },
                ),
                FlatButton(
                  child: Text(
                    'Palettes',
                    textAlign: TextAlign.start,
                    style: defaultText,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PalettePage(color: mainColor),
                      ),
                    );
                  },
                ),
                FlatButton(
                  child: Text(
                    'Gradient',
                    textAlign: TextAlign.start,
                    style: defaultText,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GradientPage(color1: color1, color2: color2, mainColor: mainColor),
                      ),
                    );
                  },
                ),
                FlatButton(
                  child: Text(
                    'Settings',
                    textAlign: TextAlign.start,
                    style: defaultText,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsPage(color: mainColor),
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
