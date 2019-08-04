import 'package:colorite/components/drawer.dart';
import 'package:colorite/components/selector_card.dart';
import 'package:colorite/utilities/color_helper.dart';
import 'package:colorite/utilities/constants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final Color mainColor = Color.fromRGBO(125, 125, 125, 1);

  @override
  _HomePageState createState() => _HomePageState(mainColor: mainColor);
}

class _HomePageState extends State<HomePage> {
  Color mainColor;

  _HomePageState({this.mainColor});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Colorite'),
        backgroundColor: Colors.blueGrey,
        iconTheme: new IconThemeData(color: Colors.black),
      ),
      drawer: SideDrawer(),
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
                          specialText('#' +
                              mainColor.value.toRadixString(16).substring(2).toUpperCase()),
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
                          specialText(mainColor.red.toString()),
                          specialText(mainColor.green.toString()),
                          specialText(mainColor.blue.toString()),
                          //hsv
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 32.0, right: 8.0),
                            child: Text(
                              'HSV:',
                              style: smallText,
                            ),
                          ),
                          specialText(HSVColor.fromColor(mainColor).hue.toStringAsFixed(0)),
                          specialText((HSVColor.fromColor(mainColor).saturation * 100).toStringAsFixed(0)),
                          specialText((HSVColor.fromColor(mainColor).value * 100).toStringAsFixed(0)),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
          colorListRow(
            'Shade colors',
            getColorContainer(
              ColorHelper().getShades(mainColor),
            ),
          ),
          colorListRow(
            'Tint colors',
            getColorContainer(
              ColorHelper().getTint(mainColor),
            ),
          ),
          colorListRow(
            'Triadic colors',
            getColorContainer(
              ColorHelper().getTriadic(mainColor),
            ),
          ),
          colorListRow(
            'Analogous colors',
            getColorContainer(
              ColorHelper().getAnalogous(mainColor),
            ),
          ),
          colorListRow(
            'Complimentary colors',
            getColorContainer(
              ColorHelper().getComplementary(mainColor),
            ),
          ),
          colorListRow(
            'Split Complimentary colors',
            getColorContainer(
              ColorHelper().getSplitComplement(mainColor),
            ),
          ),
          colorListRow(
            'Monochromatic colors',
            getColorContainer(
              ColorHelper().getMonochromatic(mainColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget specialText(String text) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      padding: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          width: 1,
          color: Colors.white,
        ),
      ),
      child: Text(
        text,
        style: smallText,
      ),
    );
  }

  Widget colorListRow(String text, List<Widget> widgetList) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(text),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(children: widgetList),
          ),
        ],
      ),
    );
  }

  List<Expanded> getColorContainer(List<Color> colorList) {
    double height = 32;
    List<Expanded> widgetList = [];
    int count = 0;

    for (Color color in colorList) {
      //first color
      if (colorList[0] == color && count == 0) {
        widgetList.add(
          Expanded(
            child: Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
                color: color,
              ),
            ),
          ),
        );
      }
      //last color
      else if (colorList[colorList.length - 1] == color && count == colorList.length - 1) {
        widgetList.add(Expanded(
          child: Container(
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
              color: color,
            ),
          ),
        ));
        // other colors
      } else {
        widgetList.add(
          Expanded(
            child: Container(
              height: height,
              color: color,
            ),
          ),
        );
      }
      count++;
    }
    return widgetList;
  }
}
