import 'package:colorite/components/drawer.dart';
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
    );
  }
}