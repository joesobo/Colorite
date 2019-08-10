import 'package:colorite/components/color_info.dart';
import 'package:colorite/components/color_list_card.dart';
import 'package:colorite/components/drawer.dart';
import 'package:colorite/components/selector_card.dart';
import 'package:colorite/components/special_text.dart';
import 'package:colorite/utilities/color_helper.dart';
import 'package:colorite/utilities/constants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final Color mainColor;

  HomePage({this.mainColor});

  @override
  _HomePageState createState() => _HomePageState(mainColor: mainColor);
}

class _HomePageState extends State<HomePage> {
  Color mainColor;

  _HomePageState({this.mainColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Colorite'),
        backgroundColor: mainColor,
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      drawer: SideDrawer(color: mainColor),
      body: ListView(
        children: <Widget>[
          //color viewer
          Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 32, left: 32, right: 32),
                    height: 104,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                      color: mainColor,
                    ),
                  ),
                  Positioned(
                    width: 40,
                    height: 40,
                    right: 32,
                    top: 32,
                    //color editing button
                    child: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () async {
                        final resultColor = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SelectorCard(mainColor: mainColor);
                          },
                        );

                        if (resultColor != null) {
                          setState(() {
                            mainColor = resultColor;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 12, left: 32, right: 32),
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                    color: ColorHelper().getDarkShade(mainColor),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      //hex
                      Row(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'HEX:',
                              style: smallText,
                            ),
                          ),
                          SpecialText(text: '#' +
                              mainColor.value
                                  .toRadixString(16)
                                  .substring(2)
                                  .toUpperCase()),
                        ],
                      ),
                      //rgb and hsv
                      Row(
                        children: <Widget>[
                          //rgb
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'RGB:',
                              style: smallText,
                            ),
                          ),
                          SpecialText(text: mainColor.red.toString()),
                          SpecialText(text: mainColor.green.toString()),
                          SpecialText(text: mainColor.blue.toString()),
                          //hsv
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 32.0, right: 8.0),
                            child: Text(
                              'HSV:',
                              style: smallText,
                            ),
                          ),
                          SpecialText(text: HSVColor.fromColor(mainColor)
                              .hue
                              .toStringAsFixed(0)),
                          SpecialText(text: 
                              (HSVColor.fromColor(mainColor).saturation * 100)
                                  .toStringAsFixed(0)),
                          SpecialText(text: 
                              (HSVColor.fromColor(mainColor).value * 100)
                                  .toStringAsFixed(0)),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
          //list of color cards
          ColorListCard(
            text: 'Shade colors',
            widgetList: createColorButton(
              ColorHelper().getShades(mainColor),
            ),
            toolTip:
                'A group of colors that have the same hue but different value',
          ),
          ColorListCard(
            text: 'Tint colors',
            widgetList: createColorButton(
              ColorHelper().getTint(mainColor),
            ),
            toolTip:
                'A group of colors that have the same hue but different saturation',
          ),
          ColorListCard(
            text: 'Triadic colors',
            widgetList: createColorButton(
              ColorHelper().getTriadic(mainColor),
            ),
            toolTip:
                'A group of colors that are evenly spaced around the color wheel',
          ),
          ColorListCard(
            text: 'Analogous colors',
            widgetList: createColorButton(
              ColorHelper().getAnalogous(mainColor),
            ),
            toolTip:
                'A group of colors that are next to each other on the color wheel',
          ),
          ColorListCard(
            text: 'Complimentary colors',
            widgetList: createColorButton(
              ColorHelper().getComplementary(mainColor),
            ),
            toolTip:
                'A group of colors that are opposite each other on the color wheel',
          ),
          ColorListCard(
            text: 'Split Complimentary colors',
            widgetList: createColorButton(
              ColorHelper().getSplitComplement(mainColor),
            ),
            toolTip:
                'A group of colors that are split 3 ways around the color wheel',
          ),
          ColorListCard(
            text: 'Monochromatic colors',
            widgetList: createColorButton(
              ColorHelper().getMonochromatic(mainColor),
            ),
            toolTip:
                'A group of colors that have the same hue but different value and saturation',
          ),
        ],
      ),
    );
  }

  //decides which button based on order
  List<Widget> createColorButton(List<Color> colorList) {
    List<Widget> widgetList = [];
    int count = 0;

    for (Color color in colorList) {
      //first color
      if (colorList[0] == color && count == 0) {
        widgetList.add(
          radiusButton(
            color,
            BorderRadius.only(
              topLeft: Radius.circular(5),
              bottomLeft: Radius.circular(5),
            ),
          ),
        );
      }
      //last color
      else if (colorList[colorList.length - 1] == color &&
          count == colorList.length - 1) {
        widgetList.add(
          radiusButton(
            color,
            BorderRadius.only(
              topRight: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
          ),
        );
        // other colors
      } else {
        widgetList.add(
          radiusButton(
            color,
            null,
          ),
        );
      }
      count++;
    }
    return widgetList;
  }

  //created button with changable radius
  Widget radiusButton(Color color, BorderRadius border) {
    return Expanded(
      child: Material(
        elevation: 3,
        color: Colors.transparent,
        shadowColor: Colors.grey[800],
        child: FlatButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ColorInfo(color: color);
              },
            );
          },
          padding: EdgeInsets.all(0),
          child: Container(
            height: 40,
            margin: EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
              borderRadius: border,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
