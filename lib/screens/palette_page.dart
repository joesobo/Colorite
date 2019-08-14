import 'package:colorite/components/color_list_card.dart';
import 'package:colorite/components/drawer.dart';
import 'package:colorite/database/database_helper.dart';
import 'package:colorite/models/palette.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class PalettePage extends StatelessWidget {
  final Color color;

  PalettePage({this.color});

  final dbHelper = DatabaseHelper.instance;

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
          getPalettes(),
        ],
      ),
    );
  }

  Widget getPalettes() {
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
                      colorList: getStringList(jsonDecode(snapshot.data[index].myColorList)),
                      id: snapshot.data[index].id
                    );
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

  //accesses database and returns Future list of palettes
  Future<List<Palette>> getPalletesFromDB() async {
    Future<List<Palette>> palettes = dbHelper.getPalettes();
    return palettes;
  }

  List<String> getStringList(List<dynamic> list){
    List<String> stringList = [];
    for(dynamic item in list){
      stringList.add(item.toString());
    }
    return stringList;
  }
}

class PaletteDisplay extends StatelessWidget {
  final String title;
  final List<dynamic> colorList;
  final int id;

  PaletteDisplay({this.title, this.colorList, this.id});

  @override
  Widget build(BuildContext context) {
    return ColorListCard(
      text: title,
      colorList: convertToColorList(colorList),
      id: id
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
