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
      child: Tooltip(
        message: toolTip,
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(text),
                    Container(
                      height: 20,
                      width: 20,
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          //TODO: add to palette
                          print('Colors added to palette');
                        },
                        icon: Icon(
                          Icons.add_circle_outline,
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(children: widgetList),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
