import 'package:colorite/screens/home_page.dart';
import 'package:colorite/screens/palette_page.dart';
import 'package:colorite/utilities/constants.dart';
import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  final Color color;

  SideDrawer({this.color});

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
                color: color,
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
                        builder: (context) => HomePage(mainColor: color),
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
                        builder: (context) => PalettePage(color: color),
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
                  onPressed: () {},
                ),
                FlatButton(
                  child: Text(
                    'Settings',
                    textAlign: TextAlign.start,
                    style: defaultText,
                  ),
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
