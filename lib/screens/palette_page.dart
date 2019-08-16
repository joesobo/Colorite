import 'dart:convert';

import 'package:colorite/components/color_list_card.dart';
import 'package:colorite/components/drawer.dart';
import 'package:colorite/database/database_helper.dart';
import 'package:colorite/models/palette.dart';
import 'package:flutter/material.dart';

class PalettePage extends StatelessWidget {
  final Color color;

  PalettePage({this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Palettes'),
        backgroundColor: color,
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      drawer: SideDrawer(mainColor: color),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 16,
          ),
          PaletteList(),
        ],
      ),
    );
  }
}

class PaletteDisplay extends StatelessWidget {
  final String title;
  final List<dynamic> colorList;
  final int id;
  final VoidCallback onDelete;

  PaletteDisplay({this.title, this.colorList, this.id, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ColorListCard(
      text: title,
      colorList: convertToColorList(colorList),
      id: id,
      onDelete: onDelete,
    );
  }

  //takes in a list of hexs and returns a list of colors
  List<Color> convertToColorList(List<String> list) {
    List<Color> colorList = [];
    for (String hex in list) {
      String newColor = 'FF$hex';
      colorList.add(Color(int.parse(newColor, radix: 16)));
    }
    return colorList;
  }
}

class PaletteList extends StatefulWidget {
  @override
  _PaletteListState createState() => _PaletteListState();
}

class _PaletteListState extends State<PaletteList> {
  final dbHelper = DatabaseHelper.instance;
  List<Palette> paletteList;

  @override
  void initState() {
    getPalettes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ReorderableListView(
        //header: TextField(),
        children: getPaletteList(),
        onReorder: (int oldIndex, int newIndex) {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }

          setState(() {
            var item = paletteList.removeAt(oldIndex);
            paletteList.insert(newIndex, item);

            //get new database info
            List<Map> rows = [];
            for (Palette palette in paletteList) {
              Map<String, dynamic> row = palette.toJson();
              rows.add(row);
            }

            dbHelper.updateFullTable(rows);
            getPaletteList();
          });

          //TODO update database on change
        },
      ),
    );
  }

  List<Widget> getPaletteList() {
    List<Widget> widgetList = [];
    if (paletteList != null) {
      for (Palette palette in paletteList) {
        widgetList.add(
          ListTile(
            key: Key(palette.id.toString()),
            title: PaletteDisplay(
              title: palette.name,
              colorList: getStringList(jsonDecode(palette.myColorList)),
              id: palette.id,
              onDelete: () => removeItem(palette.id),
            ),
          ),
        );
      }
    }
    return widgetList;
  }

  //deletes item with id
  void removeItem(int id) async {
    final rowsDeleted = await dbHelper.delete(id);
    getPalettes();
    print('deleted $rowsDeleted row(s): row $id');
  }

  void getPalettes() async {
    List<Palette> palettes = await dbHelper.getPalettes();
    setState(() {
      paletteList = palettes;
    });
  }

  //converts dynamic list to string list
  List<String> getStringList(List<dynamic> list) {
    List<String> stringList = [];
    for (dynamic item in list) {
      stringList.add(item.toString());
    }
    return stringList;
  }
}
