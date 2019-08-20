import 'package:colorite/components/color_indicator.dart';
import 'package:colorite/components/special_text.dart';
import 'package:colorite/utilities/constants.dart';
import 'package:flutter/material.dart';

class ColorInfoPopup extends StatelessWidget {
  final Color color;

  ColorInfoPopup({this.color});

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
                  SpecialText(text: color.red.toString()),
                  SpecialText(text: color.green.toString()),
                  SpecialText(text: color.blue.toString()),
                ],
              ),
              SizedBox(height: 8,),
              Row(
                children: <Widget>[
                  Text('HSV: '),
                  SpecialText(text: HSVColor.fromColor(color).hue.toStringAsFixed(0)),
                  SpecialText(text: (HSVColor.fromColor(color).saturation * 100).toStringAsFixed(0)),
                  SpecialText(text: (HSVColor.fromColor(color).value * 100).toStringAsFixed(0)),
                ],
              ),
              //exit 
              Container(
                width: 100,
                child: RaisedButton(
                  color: accentColor,
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
            ],
          ),
        ),
      ),
    );
  }
}
