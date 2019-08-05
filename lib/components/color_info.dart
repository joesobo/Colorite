import 'package:colorite/components/color_indicator.dart';
import 'package:colorite/utilities/constants.dart';
import 'package:flutter/material.dart';

class ColorInfo extends StatelessWidget {
  final Color color;

  ColorInfo({this.color});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Center(child: Text('Color Info')),
      content: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Container(
          height: 225,
          child: Column(
            children: <Widget>[
              Text('Hex: #' +
                  color.value.toRadixString(16).substring(2).toUpperCase()),
              ColorIndicator(color: color),
              Container(
                margin: EdgeInsets.only(bottom: 16),
                height: 1,
                width: 225,
                color: Colors.grey,
              ),
              Row(
                children: <Widget>[
                  Text('RGB: '),
                  specialText(color.red.toString()),
                  specialText(color.green.toString()),
                  specialText(color.blue.toString()),
                ],
              ),
              SizedBox(height: 8,),
              Row(
                children: <Widget>[
                  Text('HSV: '),
                  specialText(HSVColor.fromColor(color).hue.toStringAsFixed(0)),
                  specialText((HSVColor.fromColor(color).saturation * 100).toStringAsFixed(0)),
                  specialText((HSVColor.fromColor(color).value * 100).toStringAsFixed(0)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //text wrapped in special border
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
}
