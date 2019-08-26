import 'package:colorite/database/database_helper.dart';
import 'package:colorite/models/palette.dart';
import 'package:colorite/utilities/constants.dart';
import 'package:flutter/material.dart';

class SortPalettePopup extends StatefulWidget {
  final String returnVal;

  SortPalettePopup({this.returnVal});

  @override
  _SortPalettePopupState createState() => _SortPalettePopupState(returnVal: returnVal);
}

class _SortPalettePopupState extends State<SortPalettePopup> {

  String returnVal = '';

  _SortPalettePopupState({this.returnVal});

  final dbHelper = DatabaseHelper.instance;
  List<Palette> paletteList;
  int _currValue = 0;
  String nameDisplayValue = 'A';
  String dateDisplayValue = 'New';

  @override
  void initState() {
    if(returnVal == ''){
      returnVal = 'default';
    } 

    if(returnVal == 'default'){
      _currValue = 0;
    } else if (returnVal == 'nameA') {
      _currValue = 1;
      nameDisplayValue = 'A';
      returnVal = 'name';
    } else if (returnVal == 'nameZ') {
      _currValue = 1;
      nameDisplayValue = 'Z';
      returnVal = 'name';
    } else if (returnVal == 'dateNew') {
      _currValue = 2;
      dateDisplayValue = 'New';
      returnVal = 'date';
    } else if (returnVal == 'dateOld') {
      _currValue = 2;
      dateDisplayValue = 'Old';
      returnVal = 'date';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Text(
        'Sort Palettes by: ',
        textAlign: TextAlign.center,
      ),
      content: Container(
        height: 280,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            //default
            Row(
              children: <Widget>[
                Radio(
                  value: 0,
                  groupValue: _currValue,
                  onChanged: (int i) {
                    setState(() => _currValue = i);
                    returnVal = 'default';
                  },
                ),
                Text('Default')
              ],
            ),
            //name
            Row(
              children: <Widget>[
                Radio(
                  value: 1,
                  groupValue: _currValue,
                  onChanged: (int i) {
                    setState(() => _currValue = i);
                    returnVal = 'name';
                  },
                ),
                Text('Name'),
                SizedBox(
                  width: 100,
                ),
                Container(
                  width: 40,
                  height: 40,
                  child: RaisedButton(
                    child: Text(nameDisplayValue),
                    color: accentColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    onPressed: () {
                      setState(() {
                        if (nameDisplayValue == 'A') {
                          nameDisplayValue = 'Z';
                        } else {
                          nameDisplayValue = 'A';
                        }
                      });
                    },
                  ),
                )
              ],
            ),
            //date
            Row(
              children: <Widget>[
                Radio(
                  value: 2,
                  groupValue: _currValue,
                  onChanged: (int i) {
                    setState(() => _currValue = i);
                    returnVal = 'date';
                  },
                ),
                Text('Date'),
                SizedBox(
                  width: 90,
                ),
                Container(
                  width: 80,
                  height: 40,
                  child: RaisedButton(
                    child: Text(dateDisplayValue),
                    color: accentColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    onPressed: () {
                      setState(() {
                        if (dateDisplayValue == 'New') {
                          dateDisplayValue = 'Old';
                        } else {
                          dateDisplayValue = 'New';
                        }
                      });
                    },
                  ),
                )
              ],
            ),
            //spacer
            SizedBox(
              height: 24,
            ),
            //clear hand sort
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              width: double.infinity,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: Colors.red,
                child: Text('Reset'),
                onPressed: () async {
                  await getPalettes();

                  //update database with priority
                  for (int i = 0; i < paletteList.length; i++) {
                    paletteList[i].priority = -1;
                    Map<String, dynamic> row = paletteList[i].toJson();
                    dbHelper.update(row);
                  }
                  Navigator.pop(context, 'default');
                },
              ),
            ),
            //save and cancel
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
                    onPressed: () {
                      if (returnVal == 'name') {
                        if (nameDisplayValue == 'A') {
                          returnVal += 'A';
                        } else {
                          returnVal += 'Z';
                        }
                      }

                      if (returnVal == 'date') {
                        if (dateDisplayValue == 'New') {
                          returnVal += 'New';
                        } else {
                          returnVal += 'Old';
                        }
                      }

                      Navigator.pop(context, returnVal);
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
    );
  }

  //calls database and returns list of palettes
  Future<void> getPalettes() async {
    List<Palette> palettes = await dbHelper.getPalettes();
    setState(() {
      paletteList = palettes;
    });
  }
}
