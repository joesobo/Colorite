import 'package:colorite/components/drawer.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final Color color;

  SettingsPage({this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: color,
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      drawer: SideDrawer(color: color),
    );
  }
}