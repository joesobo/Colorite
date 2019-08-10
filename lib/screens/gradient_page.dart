import 'package:colorite/components/drawer.dart';
import 'package:colorite/components/selector_card.dart';
import 'package:colorite/components/special_text.dart';
import 'package:colorite/utilities/color_helper.dart';
import 'package:colorite/utilities/constants.dart';
import 'package:flutter/material.dart';

class GradientPage extends StatefulWidget {
  //TODO: add color saving when navigating between pages
  final Color color1;
  final Color color2;
  final Color mainColor;

  GradientPage({this.color1, this.color2, this.mainColor});

  @override
  _GradientPageState createState() => _GradientPageState(color1: color1, color2: color2, mainColor: mainColor);
}

class _GradientPageState extends State<GradientPage> {
  Color color1;
  Color color2;
  Color mainColor;

  _GradientPageState({this.color1, this.color2, this.mainColor});

  @override
  void initState() {
    if(color1 == null || color2 == null){
      color1 = Colors.red;
      color2 = Colors.yellow;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gradient'),
        backgroundColor: color1,
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      drawer: SideDrawer(mainColor: mainColor, color1: color1, color2: color2),
      body:
          //color viewer
          Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              //color display
              Container(
                margin: EdgeInsets.only(top: 32, left: 32, right: 32),
                height: 104,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    stops: [0, 1],
                    colors: [
                      color1,
                      color2,
                    ],
                  ),
                ),
              ),
              //edit icon for color 1
              Positioned(
                width: 40,
                height: 40,
                left: 32,
                top: 32,
                //color editing button
                child: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () async{
                    final resultColor = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SelectorCard(mainColor: color1);
                          },
                        );

                        if (resultColor != null) {
                          setState(() {
                            color1 = resultColor;
                          });
                        }
                  },
                ),
              ),
              //edit icon for color 2
              Positioned(
                width: 40,
                height: 40,
                right: 32,
                top: 32,
                //color editing button
                child: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () async{
                    final resultColor = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SelectorCard(mainColor: color2);
                          },
                        );

                        if (resultColor != null) {
                          setState(() {
                            color2 = resultColor;
                          });
                        }
                  },
                ),
              ),
            ],
          ),
          //color info
          Container(
              margin: EdgeInsets.only(bottom: 12, left: 32, right: 32),
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                color: ColorHelper().getDarkShade(color1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  //hex row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      //hex 1
                      Row(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'HEX 1:',
                              style: smallText,
                            ),
                          ),
                          SpecialText(
                              text: '#' +
                                  color1.value
                                      .toRadixString(16)
                                      .substring(2)
                                      .toUpperCase()),
                        ],
                      ),
                      //hex 2
                      Row(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'HEX 2:',
                              style: smallText,
                            ),
                          ),
                          SpecialText(
                              text: '#' +
                                  color2.value
                                      .toRadixString(16)
                                      .substring(2)
                                      .toUpperCase()),
                        ],
                      ),
                    ],
                  ),
                  //rgb and hsv 1 row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      //rgb 1
                      Row(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'RGB 1:',
                              style: smallText,
                            ),
                          ),
                          SpecialText(text: color1.red.toString()),
                          SpecialText(text: color1.green.toString()),
                          SpecialText(text: color1.blue.toString()),
                        ],
                      ),
                      //hsv 1
                      Row(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Text(
                              'HSV 1:',
                              style: smallText,
                            ),
                          ),
                          SpecialText(
                              text: HSVColor.fromColor(color1)
                                  .hue
                                  .toStringAsFixed(0)),
                          SpecialText(
                              text:
                                  (HSVColor.fromColor(color1).saturation * 100)
                                      .toStringAsFixed(0)),
                          SpecialText(
                              text: (HSVColor.fromColor(color1).value * 100)
                                  .toStringAsFixed(0)),
                        ],
                      ),
                    ],
                  ),
                  //rgb and hsv 2 row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      //rgb 2
                      Row(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'RGB 2:',
                              style: smallText,
                            ),
                          ),
                          SpecialText(text: color2.red.toString()),
                          SpecialText(text: color2.green.toString()),
                          SpecialText(text: color2.blue.toString()),
                        ],
                      ),
                      //hsv 2
                      Row(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Text(
                              'HSV 2:',
                              style: smallText,
                            ),
                          ),
                          SpecialText(
                              text: HSVColor.fromColor(color2)
                                  .hue
                                  .toStringAsFixed(0)),
                          SpecialText(
                              text:
                                  (HSVColor.fromColor(color2).saturation * 100)
                                      .toStringAsFixed(0)),
                          SpecialText(
                              text: (HSVColor.fromColor(color2).value * 100)
                                  .toStringAsFixed(0)),
                        ],
                      ),
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
