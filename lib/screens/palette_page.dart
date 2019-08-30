import 'dart:convert';

import 'package:palytte/components/color_list_card.dart';
import 'package:palytte/components/drawer.dart';
import 'package:palytte/components/popups/custom_palette_popup.dart';
import 'package:palytte/components/popups/sort_palette_popup.dart';
import 'package:palytte/database/database_helper.dart';
import 'package:palytte/database/shared_pref.dart';
import 'package:palytte/models/palette.dart';
import 'package:palytte/utilities/constants.dart';
import 'package:flutter/material.dart';

class PalettePage extends StatefulWidget {
  @override
  _PalettePageState createState() => _PalettePageState();
}

class _PalettePageState extends State<PalettePage> {
  Color mainColor;
  final dbHelper = DatabaseHelper.instance;
  List<Palette> paletteList;
  List<Palette> filteredList = [];
  String inputText = '';
  String sortValue = 'default';

  @override
  void initState() {
    getColor();

    getPalettes();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Palettes'),
        backgroundColor: mainColor,
        iconTheme: new IconThemeData(color: Colors.white),
        actions: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.add_circle_outline,
                  color: Colors.white,
                ),
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomPalettePopup();
                    },
                  );
                  getPalettes();
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.sort,
                  color: Colors.white,
                ),
                onPressed: () async {
                  final resultSort = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SortPalettePopup(returnVal: sortValue,);
                    },
                  );
                  getPalettes();

                  if (resultSort != null) {
                    setState(() {
                      sortValue = resultSort;
                    });
                  }
                },
              ),
            ],
          )
        ],
      ),
      drawer: SideDrawer(),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 16,
          ),

          //list of palettes
          Flexible(
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
              children: getPaletteList(paletteSort(filteredList)),
              onReorder: (int oldIndex, int newIndex) async {
                List<Palette> tempList = paletteList
                    .map((palette) => Palette(
                          id: palette.id,
                          name: palette.name,
                          myColorList: palette.myColorList,
                          priority: palette.priority,
                        ))
                    .toList();

                if (newIndex > oldIndex) {
                  newIndex -= 1;
                }

                if(tempList[0].priority != -1){
                  tempList.sort((a,b) => a.priority.compareTo(b.priority));
                }else{
                  tempList.sort((a, b) => b.id.compareTo(a.id));
                }

                final item = tempList.removeAt(oldIndex);
                tempList.insert(newIndex, item);

                for (int i = 0; i < tempList.length; i++) {
                  tempList[i].priority = i;
                }

                for (int i = 0; i < tempList.length; i++) {
                  paletteList[i].priority = find(tempList, paletteList[i].id).priority;
                }

                filterSearchResults("");

                setState(() {
                  getPaletteList(paletteSort(filteredList));
                });

                //update database with priority
                for (int i = 0; i < paletteList.length; i++) {
                  Map<String, dynamic> row = paletteList[i].toJson();
                  dbHelper.update(row);
                }
                print('updated');
              },
            ),
          )
        ],
      ),
    );
  }

  //sorts through palette list looking for id
  Palette find(List<Palette> pList, int index) {
    for (int i = 0; i < pList.length; i++) {
      if (pList[i].id == index) {
        return pList[i];
      }
    }
  }

  //returns shared preferences accent color
  void getColor() async {
    SharedPref sharedPref = new SharedPref();
    Color color = await sharedPref.loadColor('mainAccent', accentColor);

    setState(() {
      mainColor = color;
    });
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

      setState(() {
        filteredList = returnSearchList;
      });
    } else {
      setState(() {
        filteredList = paletteList;
      });
    }
  }

  //sorts based on popup
  List<Palette> paletteSort(List<Palette> pList) {
    if (pList.length == 0) {
      return [];
    }
    if (sortValue == 'default') {
      //if no handsort
      if (pList[0].priority == -1) {
        //default to sorting by newest
        pList.sort((a, b) => b.id.compareTo(a.id));
      } else {
        //otherwise sort by hand sort
        pList.sort((a, b) => a.priority.compareTo(b.priority));
        print('hand sort');
      }
    } else if (sortValue == 'nameA') {
      pList.sort((a, b) => a.name.compareTo(b.name));
    } else if (sortValue == 'nameZ') {
      pList.sort((a, b) => b.name.compareTo(a.name));
    } else if (sortValue == 'dateNew') {
      pList.sort((a, b) => b.id.compareTo(a.id));
    } else if (sortValue == 'dateOld') {
      pList.sort((a, b) => a.id.compareTo(b.id));
    }
    print(sortValue);
    return pList;
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
    filterSearchResults(inputText);
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
