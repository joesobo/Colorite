import 'package:palytte/utilities/constants.dart';
import 'package:flutter/material.dart';

class PalettePopup extends StatelessWidget {
  String value = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Text(
        'Choose a name for your palette',
        textAlign: TextAlign.center,
      ),
      content: Container(
        height: 140,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
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
            ),
            //save and cancel
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 100,
                child: RaisedButton(
                  color: Colors.blueGrey[600],
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Cancel',
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
                  color: accentColor,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Save',
                    style: defaultText,
                  ),
                  onPressed: () {
                    Navigator.pop(context, value);
                  },
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
