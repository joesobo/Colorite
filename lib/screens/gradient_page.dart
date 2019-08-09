import 'package:colorite/components/drawer.dart';
import 'package:flutter/material.dart';

class GradientPage extends StatelessWidget {
  final Color color;

  GradientPage({this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gradient'),
        backgroundColor: color,
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      drawer: SideDrawer(color: color),
    );
  }
}