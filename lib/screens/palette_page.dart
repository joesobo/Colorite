import 'package:colorite/components/color_list_card.dart';
import 'package:colorite/components/drawer.dart';
import 'package:colorite/utilities/color_helper.dart';
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
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 16,
          ), 
          PaletteDisplay(title: '1', color: color),
          PaletteDisplay(title: '2', color: color),
          PaletteDisplay(title: '3', color: color),
          PaletteDisplay(title: '4', color: color),
          PaletteDisplay(title: '5', color: color),
          PaletteDisplay(title: '6', color: color),
          PaletteDisplay(title: '7', color: color),
        ],
      ),
    );
  }
}

class PaletteDisplay extends StatelessWidget {
  final String title;
  final Color color;

  PaletteDisplay({this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return ColorListCard(
      text: title,
      widgetList: ColorListCard().createColorButton(
        ColorHelper().getMonochromatic(color),
        context,
      ),
    );
  }
}
