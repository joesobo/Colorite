import 'package:colorite/components/drawer.dart';
import 'package:colorite/components/special_text.dart';
import 'package:colorite/utilities/color_helper.dart';
import 'package:colorite/utilities/constants.dart';
import 'package:flutter/material.dart';

class GradientPage extends StatelessWidget {
  final Color color;

  GradientPage({this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gradient'),
        backgroundColor: color,
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      drawer: SideDrawer(color: color),
      body: //color viewer
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
                  color: color,
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
                  onPressed: () {},
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
                color: ColorHelper().getDarkShade(color),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  //hex
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'HEX:',
                          style: smallText,
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
                  //rgb and hsv
                  Row(
                    children: <Widget>[
                      //rgb
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'RGB:',
                          style: smallText,
                        ),
                      ),
                      SpecialText(text: color.red.toString()),
                      SpecialText(text: color.green.toString()),
                      SpecialText(text: color.blue.toString()),
                      //hsv
                      Padding(
                        padding: const EdgeInsets.only(left: 32.0, right: 8.0),
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
                ],
              )),
        ],
      ),
    );
  }
}
