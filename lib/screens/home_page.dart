import 'package:colorite/components/color_list_card.dart';
import 'package:colorite/components/drawer.dart';
import 'package:colorite/components/popups/color_selector_popup.dart';
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
  ColorListCard colorListCard = new ColorListCard();

  _HomePageState({this.mainColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Colorite'),
        backgroundColor: mainColor,
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      drawer: SideDrawer(mainColor: mainColor),
      body: ListView(
        children: <Widget>[
          //color viewer
          Container(
            margin: EdgeInsets.fromLTRB(30, 32, 30, 4),
            height: 104,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              color: mainColor,
            ),
          ),

          //new color info
          ColorInfoCard(text: 'Hex: ', color: mainColor, parent: this),

          SizedBox(height: 8,),

          //list of color cards
          ColorListCard(
            text: 'Shade colors',
            colorList: ColorHelper().getShades(mainColor),
            toolTip:
                'A group of colors that have the same hue but different value',
          ),
          ColorListCard(
            text: 'Tint colors',
            colorList: ColorHelper().getTint(mainColor),
            toolTip:
                'A group of colors that have the same hue but different saturation',
          ),
          ColorListCard(
            text: 'Triadic colors',
            colorList: ColorHelper().getTriadic(mainColor),
            toolTip:
                'A group of colors that are evenly spaced around the color wheel',
          ),
          ColorListCard(
            text: 'Analogous colors',
            colorList: ColorHelper().getAnalogous(mainColor),
            toolTip:
                'A group of colors that are next to each other on the color wheel',
          ),
          ColorListCard(
            text: 'Complimentary colors',
            colorList: ColorHelper().getComplementary(mainColor),
            toolTip:
                'A group of colors that are opposite each other on the color wheel',
          ),
          ColorListCard(
            text: 'Split Complimentary colors',
            colorList: ColorHelper().getSplitComplement(mainColor),
            toolTip:
                'A group of colors that are split 3 ways around the color wheel',
          ),
          ColorListCard(
            text: 'Monochromatic colors',
            colorList: ColorHelper().getMonochromatic(mainColor),
            toolTip:
                'A group of colors that have the same hue but different value and saturation',
          ),
        ],
      ),
    );
  }
}

//new color info display
class ColorInfoCard extends StatelessWidget {
  final String text;
  final Color color;
  final _HomePageState parent;

  ColorInfoCard({this.text, this.color, this.parent});

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
                  SpecialText(
                      text: '#' +
                          color.value
                              .toRadixString(16)
                              .substring(2)
                              .toUpperCase()),
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
                          parent.mainColor = resultColor;
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
}
