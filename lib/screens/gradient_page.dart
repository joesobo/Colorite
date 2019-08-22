import 'package:colorite/components/drawer.dart';
import 'package:colorite/components/popups/color_selector_popup.dart';
import 'package:colorite/components/special_text.dart';
import 'package:colorite/database/shared_pref.dart';
import 'package:colorite/utilities/color_helper.dart';
import 'package:colorite/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;

class GradientPage extends StatefulWidget {
  @override
  _GradientPageState createState() =>
      _GradientPageState();
}

class _GradientPageState extends State<GradientPage> {
  Color color1;
  Color color2;
  String dropDownStart = 'CL';
  String dropDownEnd = 'CR';

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
      drawer: SideDrawer(),
      body: (color1 != null || color2 != null) ?
      Column(
        children: <Widget>[
          //color display
          Container(
            margin: EdgeInsets.fromLTRB(30, 32, 30, 4),
            height: 160,
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
          //color info 1
          GradientInfoCard(text: 'Color 1', color: color1, parent: this),

          //swap
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 4),
              width: 40,
              height: 40,
              child: FloatingActionButton(
                heroTag: "btn1",
                elevation: 5,
                backgroundColor: accentColor,
                onPressed: () {
                  Color temp = color1;
                  swapColors(color1, color2);
                  setState(() {
                    color1 = color2;
                    color2 = temp;
                  });
                },
                child: Icon(
                  Icons.swap_horiz,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),

          //color info 2
          GradientInfoCard(text: 'Color 2', color: color2, parent: this),

          //gradient direction
          Column(
            children: <Widget>[
              SizedBox(
                height: 24,
              ),

              //row
              Card(
                margin: EdgeInsets.symmetric(horizontal: 30),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      //bottom left to top right
                      Transform.rotate(
                        angle: -math.pi / 4,
                        child: FloatingActionButton(
                          heroTag: "btn2",
                          elevation: 5,
                          backgroundColor: accentColor,
                          onPressed: () {
                            swapColors(color1, color2);
                            setState(() {
                              dropDownStart = 'BL';
                              dropDownEnd = 'TR';
                            });
                          },
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      //center left to center right
                      FloatingActionButton(
                        heroTag: "btn3",
                        elevation: 5,
                        backgroundColor: accentColor,
                        onPressed: () {
                          swapColors(color1, color2);
                          setState(() {
                            dropDownStart = 'CL';
                            dropDownEnd = 'CR';
                          });
                        },
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                      //top left to bottom right
                      Transform.rotate(
                        angle: math.pi / 4,
                        child: FloatingActionButton(
                          heroTag: "btn4",
                          elevation: 5,
                          backgroundColor: accentColor,
                          onPressed: () {
                            swapColors(color1, color2);
                            setState(() {
                              dropDownStart = 'TL';
                              dropDownEnd = 'BR';
                            });
                          },
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      //top to bottom
                      Transform.rotate(
                        angle: math.pi / 2,
                        child: FloatingActionButton(
                          heroTag: "btn5",
                          elevation: 5,
                          backgroundColor: accentColor,
                          onPressed: () {
                            swapColors(color1, color2);
                            setState(() {
                              dropDownStart = 'TC';
                              dropDownEnd = 'BC';
                            });
                          },
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //helper text
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                child: Text(
                  'Tap button to change direction of gradient',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ],
      )
      : Container()
    );
  }

  //returns shared preferences accent color
  void getColors() async {
    SharedPref sharedPref = new SharedPref();
    Color tempColor1 =
        await sharedPref.loadColor('gradientAccent1', Colors.red);
    Color tempColor2 =
        await sharedPref.loadColor('gradientAccent2', Colors.blue);

    setState(() {
      color1 = tempColor1;
      color2 = tempColor2;
    });
  }

  //swaps colors in shared preferences database
  void swapColors(Color color1, Color color2) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ColorHelper colorHelper = new ColorHelper();
    setState(() {
      prefs.setString('gradientAccent1', colorHelper.toHex(color2));
      prefs.setString('gradientAccent2', colorHelper.toHex(color1));
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
                'BC',
                'BL',
                'BR',
                'TC',
                'TL',
                'TR',
                'C',
                'CL',
                'CR',
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
    if (text == 'BC') {
      return Alignment.bottomCenter;
    } else if (text == 'BL') {
      return Alignment.bottomLeft;
    } else if (text == 'BR') {
      return Alignment.bottomRight;
    } else if (text == 'TC') {
      return Alignment.topCenter;
    } else if (text == 'TL') {
      return Alignment.topLeft;
    } else if (text == 'TR') {
      return Alignment.topRight;
    } else if (text == 'C') {
      return Alignment.center;
    } else if (text == 'CL') {
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
