import 'package:colorite/components/color_list_card.dart';
import 'package:colorite/components/drawer.dart';
import 'package:colorite/database/database_helper.dart';
import 'package:colorite/models/palette.dart';
import 'dart:convert';
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

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        child: FutureBuilder<List<Palette>>(
          future: getPalletesFromDB(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return PaletteDisplay(
                        title: snapshot.data[index].name,
                        colorList: getStringList(
                            jsonDecode(snapshot.data[index].myColorList)),
                        id: snapshot.data[index].id,
                        onDelete: () => removeItem(snapshot.data[index].id));
                  },
                );
              } else if (snapshot.data.length == 0) {
                return Text('No data found');
              }
            } else {
              return Text('No data found');
            }
          },
        ),
      ),
    );
  }

  void removeItem(int id) async {
    final rowsDeleted = await dbHelper.delete(id);
    setState(() {
      getPalletesFromDB();
    });
    print('deleted $rowsDeleted row(s): row $id');
  }

  //accesses database and returns Future list of palettes
  Future<List<Palette>> getPalletesFromDB() async {
    Future<List<Palette>> palettes = dbHelper.getPalettes();
    return palettes;
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
