import 'package:colorite/components/popups/color_info_popup.dart';
import 'package:colorite/components/popups/palette_info_popup.dart';
import 'package:flutter/material.dart';

class ColorListCard extends StatelessWidget {
  final String text;
  final List<Widget> widgetList;
  final String toolTip;

  ColorListCard({this.text, this.widgetList, this.toolTip});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 8),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //top row
              toolTip != null ? 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(text),
                  Row(
                    children: <Widget>[
                      Container(
                        height: 20,
                        width: 20,
                        child: IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return PaletteInfoPopup(text: toolTip);
                              },
                            );
                          },
                          icon: Icon(
                            Icons.info_outline,
                            size: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        height: 20,
                        width: 20,
                        child: IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            //TODO: add to palette
                          },
                          icon: Icon(
                            Icons.add_circle_outline,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
              : Text(text),
              //color list
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(children: widgetList),
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
            context,
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
            context,
          ),
        );
        // other colors
      } else {
        widgetList.add(
          radiusButton(
            color,
            null,
            context,
          ),
        );
      }
      count++;
    }
    return widgetList;
  }

  //created button with changable radius
  Widget radiusButton(Color color, BorderRadius border, BuildContext context) {
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
                return ColorInfoPopup(color: color);
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
