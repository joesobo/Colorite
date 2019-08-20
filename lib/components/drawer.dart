import 'package:colorite/database/shared_pref.dart';
import 'package:colorite/screens/gradient_page.dart';
import 'package:colorite/screens/home_page.dart';
import 'package:colorite/screens/palette_page.dart';
import 'package:colorite/screens/settings_page.dart';
import 'package:colorite/utilities/constants.dart';
import 'package:flutter/material.dart';

class SideDrawer extends StatefulWidget {
  @override
  _SideDrawerState createState() =>
      _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  Color mainColor;

  @override
  void initState() {
    getColor();

    super.initState();
  }

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
                //home page
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
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                ),
                //palette page
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
                        builder: (context) => PalettePage(),
                      ),
                    );
                  },
                ),
                //gradient page
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
                        builder: (context) => GradientPage(),
                      ),
                    );
                  },
                ),
                //setings page
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
                        builder: (context) => SettingsPage(),
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

  //returns shared preferences accent color
  void getColor() async {
    SharedPref sharedPref = new SharedPref();
    Color color = await sharedPref.loadColor('mainAccent', accentColor);

    setState(() {
      mainColor = color;
    });
  }
}