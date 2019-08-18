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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_circle_outline, color: Colors.white,),
            onPressed: (){
              //TODO: add popup for custom palettes
            },
          )
        ],
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
  List<Palette> filteredList = [];
  String inputText = '';

  @override
  void initState() {
    getPalettes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ReorderableListView(
        header: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: TextField(
            onChanged: (text) {
              setState(() {
                inputText = text;
              });
              filterSearchResults(text);
            },
            decoration: new InputDecoration(
              labelText: "Search",
              prefixIcon: Icon(Icons.search),
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(10.0),
                borderSide: new BorderSide(),
              ),
            ),
          ),
        ),
        children: (filteredList == null || filteredList.isEmpty)
            ? getPaletteList(paletteList)
            : getPaletteList(filteredList),
        onReorder: (int oldIndex, int newIndex) async {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }

          var item = paletteList.removeAt(oldIndex);
          paletteList.insert(newIndex, item);

          Map<String, dynamic> oldPalette = paletteList[oldIndex].toJson();
          Map<String, dynamic> newPalette = paletteList[newIndex].toJson();

          await dbHelper.update(oldPalette);
          await dbHelper.update(newPalette);

          setState(() {
            //getPalettes();
            getPaletteList(paletteList);
          });
        },
      ),
    );
  }

  //filters paletteList by input string
  void filterSearchResults(String query) {
    List<Palette> returnSearchList = [];
    if (query.isNotEmpty || query == '') {
      paletteList.forEach((item) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          returnSearchList.add(item);
        }
      });
    }

    setState(() {
      filteredList = returnSearchList;
    });
  }

  //returns list of palette widgets
  List<Widget> getPaletteList(List<Palette> pList) {
    List<Widget> widgetList = [];
    if (pList != null) {
      for (Palette palette in pList) {
        widgetList.add(
          ListTile(
            contentPadding: EdgeInsets.all(0),
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

  //calls database and returns list of palettes
  void getPalettes() async {
    List<Palette> palettes = await dbHelper.getPalettes();
    setState(() {
      paletteList = palettes;
    });
    if (filteredList != null || filteredList.isNotEmpty) {
      filterSearchResults(inputText);
    }
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
