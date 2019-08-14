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
        height: 130,
        child: Column(
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
            RaisedButton(
              onPressed: (){
                //print(value);
                Navigator.pop(context, value);
              },
              color: Colors.blueGrey[600],
              shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
