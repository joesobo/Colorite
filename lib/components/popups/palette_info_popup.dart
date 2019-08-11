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
      content: Text(text),
    );
  }
}
