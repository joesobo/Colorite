import 'package:colorite/utilities/constants.dart';
import 'package:flutter/material.dart';

class PaletteInfoPopup extends StatelessWidget {
  final String text;

  PaletteInfoPopup({this.text});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Text(
        'Palette Harmony Info',
        textAlign: TextAlign.center,
      ),
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(text),
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
    );
  }
}
