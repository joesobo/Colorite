import 'dart:convert';

import 'package:colorite/components/popups/color_selector_popup.dart';
import 'package:colorite/database/database_helper.dart';
import 'package:colorite/models/palette.dart';
import 'package:colorite/utilities/color_helper.dart';
import 'package:colorite/utilities/constants.dart';
import 'package:flutter/material.dart';

class CustomPalettePopup extends StatefulWidget {
  @override
  _CustomPalettePopupState createState() => _CustomPalettePopupState();
}

class _CustomPalettePopupState extends State<CustomPalettePopup> {
  List<Color> colorList = [
    Colors.grey[100],
    Colors.grey[200],
    Colors.grey[300],
    Colors.grey[400],
    Colors.grey[500],
  ];
  ColorHelper colorHelper = new ColorHelper();

  @override
  Widget build(BuildContext context) {
    final dbHelper = DatabaseHelper.instance;
    String value;

    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Center(child: Text('Custom Color Palette')),
      content: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Container(
          height: 225,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                children: createColorButton(colorList, context),
              ),
              Text('Click on a color to change it',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  )),
              TextField(
                textCapitalization: TextCapitalization.sentences,
                onChanged: (text) {
                  value = text;
                },
                decoration: new InputDecoration(
                  labelText: "Enter Name",
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide: new BorderSide(),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  //exit
                  Container(
                    width: 100,
                    child: RaisedButton(
                      color: Colors.blueGrey[600],
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Close',
                        style: defaultText,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                    width: 100,
                    child: RaisedButton(
                      elevation: 5,
                      child: Text('Save'),
                      onPressed: () async {
                        //convert color list to hex list
                        List<String> myColorList = [];
                        for (Color color in colorList) {
                          myColorList.add(colorHelper.toHex(color));
                        }

                        //create new palette
                        Palette p = new Palette(
                            name: value, myColorList: jsonEncode(myColorList));

                        Map<String, dynamic> row = p.toJson();

                        //insert new row to database
                        final id = await dbHelper.insert(row);
                        print('inserted row id: $id');
                        print('inserted row name: ${p.name}');
                        print('inserted row list: ${p.myColorList}');
                        Navigator.pop(context);
                      },
                      color: accentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //decides which button based on order
  List<Widget> createColorButton(List<Color> colorList, BuildContext context) {
    List<Widget> widgetList = [];
    int index = 0;

    for (Color color in colorList) {
      //first color
      if (colorList[0] == color && index == 0) {
        widgetList.add(
          radiusButton(
            color,
            BorderRadius.only(
              topLeft: Radius.circular(5),
              bottomLeft: Radius.circular(5),
            ),
            context,
            index,
          ),
        );
      }
      //last color
      else if (colorList[colorList.length - 1] == color &&
          index == colorList.length - 1) {
        widgetList.add(
          radiusButton(
            color,
            BorderRadius.only(
              topRight: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
            context,
            index,
          ),
        );
        // other colors
      } else {
        widgetList.add(
          radiusButton(
            color,
            null,
            context,
            index,
          ),
        );
      }
      index++;
    }
    return widgetList;
  }

  //created button with changable radius
  Widget radiusButton(
      Color color, BorderRadius border, BuildContext context, int index) {
    return Expanded(
      child: Material(
        elevation: 3,
        color: Colors.transparent,
        shadowColor: Colors.grey[800],
        child: FlatButton(
          onPressed: () async {
            final resultColor = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return ColorSelectorPopup(mainColor: color);
              },
            );

            if (resultColor != null) {
              setState(() {
                colorList[index] = resultColor;
              });
            }
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
