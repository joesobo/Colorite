import 'package:colorite/components/drawer.dart';
import 'package:colorite/components/popups/color_selector_popup.dart';
import 'package:colorite/components/special_text.dart';
import 'package:colorite/database/shared_pref.dart';
import 'package:colorite/utilities/color_helper.dart';
import 'package:colorite/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GradientPage extends StatefulWidget {
  //TODO: add color saving when navigating between pages
  final Color color1;
  final Color color2;

  GradientPage({this.color1, this.color2});

  @override
  _GradientPageState createState() =>
      _GradientPageState(color1: color1, color2: color2);
}

class _GradientPageState extends State<GradientPage> {
  Color color1;
  Color color2;
  String dropDownStart = 'CenterLeft';
  String dropDownEnd = 'CenterRight';

  _GradientPageState({this.color1, this.color2});

  @override
  void initState() {
    getColors();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: Text('Gradient'),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0, 1],
          colors: [
            color1,
            color2,
          ],
        ),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      drawer: SideDrawer(color1: color1, color2: color2),
      body: Column(
        children: <Widget>[
          //color display
          Container(
            margin: EdgeInsets.fromLTRB(30, 32, 30, 4),
            height: 104,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              gradient: LinearGradient(
                begin: getAlignment(dropDownStart),
                end: getAlignment(dropDownEnd),
                stops: [0, 1],
                colors: [
                  color1,
                  color2,
                ],
              ),
            ),
          ),
          //color info
          GradientInfoCard(text: 'Color 1', color: color1, parent: this),
          GradientInfoCard(text: 'Color 2', color: color2, parent: this),

          //spacing
          SizedBox(
            height: 8,
          ),

          //gradient direction
          directionDropDown('Color 1', dropDownStart, true),
          directionDropDown('Color 2', dropDownEnd, false)
        ],
      ),
    );
  }

  //returns shared preferences accent color
  void getColors() async {
    SharedPref sharedPref = new SharedPref();
    Color tempColor1 = await sharedPref.loadColor('gradientAccent1', Colors.red);
    Color tempColor2 = await sharedPref.loadColor('gradientAccent2', Colors.blue);

    setState(() {
      color1 = tempColor1;
      color2 = tempColor2;
    });
  }

  Widget directionDropDown(String label, String value, bool start) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.fromLTRB(30, 8, 30, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(label),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: DropdownButton<String>(
              value: value,
              onChanged: (String newVal) {
                setState(() {
                  if (start) {
                    dropDownStart = newVal;
                  } else {
                    dropDownEnd = newVal;
                  }
                });
              },
              items: <String>[
                'BottomCenter',
                'BottomLeft',
                'BottomRight',
                'TopCenter',
                'TopLeft',
                'TopRight',
                'Center',
                'CenterLeft',
                'CenterRight',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Alignment getAlignment(String text) {
    if (text == 'BottomCenter') {
      return Alignment.bottomCenter;
    } else if (text == 'BottomLeft') {
      return Alignment.bottomLeft;
    } else if (text == 'BottomRight') {
      return Alignment.bottomRight;
    } else if (text == 'TopCenter') {
      return Alignment.topCenter;
    } else if (text == 'TopLeft') {
      return Alignment.topLeft;
    } else if (text == 'TopRight') {
      return Alignment.topRight;
    } else if (text == 'Center') {
      return Alignment.center;
    } else if (text == 'CenterLeft') {
      return Alignment.centerLeft;
    } else {
      return Alignment.centerRight;
    }
  }
}

//new color info display
class GradientInfoCard extends StatelessWidget {
  final String text;
  final Color color;
  final _GradientPageState parent;
  ColorHelper colorHelper = new ColorHelper();

  GradientInfoCard({this.text, this.color, this.parent});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 28.0, vertical: 8),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //hex
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      text,
                    ),
                  ),
                  SpecialText(text: '#' + colorHelper.toHex(color)),
                ],
              ),
            ),
            //color display
            Stack(
              children: <Widget>[
                Material(
                  elevation: 3,
                  color: Colors.transparent,
                  shadowColor: Colors.grey[800],
                  child: Container(
                    height: 40,
                    margin: EdgeInsets.only(bottom: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                      color: color,
                    ),
                  ),
                ),
                //edit icon for color 1
                Positioned(
                  width: 40,
                  height: 40,
                  right: 0,
                  bottom: 4,
                  //color editing button
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () async {
                      final resultColor = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ColorSelectorPopup(mainColor: color);
                        },
                      );

                      if (resultColor != null) {
                        parent.setState(() {
                          setColor(parent, resultColor, text);
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            //color info
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                //rgb
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          'RGB:',
                          style: smallText,
                        ),
                      ),
                      SpecialText(text: color.red.toString()),
                      SpecialText(text: color.green.toString()),
                      SpecialText(text: color.blue.toString()),
                    ],
                  ),
                ),
                //spacing
                SizedBox(
                  width: 32,
                ),
                //hsv
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          'HSV:',
                          style: smallText,
                        ),
                      ),
                      SpecialText(
                          text:
                              HSVColor.fromColor(color).hue.toStringAsFixed(0)),
                      SpecialText(
                          text: (HSVColor.fromColor(color).saturation * 100)
                              .toStringAsFixed(0)),
                      SpecialText(
                          text: (HSVColor.fromColor(color).value * 100)
                              .toStringAsFixed(0)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //sets accent color for shared preferences
  void setColor(_GradientPageState parent, Color color, String text) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ColorHelper colorHelper = new ColorHelper();

    parent.setState(() {
      if (text == 'Color 1') {
        parent.color1 = (color ?? accentColor);
        prefs.setString('gradientAccent1', colorHelper.toHex(color));
      } else {
        parent.color2 = (color ?? accentColor);
        prefs.setString('gradientAccent2', colorHelper.toHex(color));
      }
    });
  }
}
