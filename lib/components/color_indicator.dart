import 'package:flutter/material.dart';

class ColorIndicator extends StatelessWidget {
  final Color color;

  ColorIndicator({this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 16),
      height: 104,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
      ),
    );
  }
}