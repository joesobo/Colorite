import 'package:colorite/screens/drawer.dart';
import 'package:colorite/utilities/constants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Colorite'),
        backgroundColor: Colors.blueGrey,
        iconTheme: new IconThemeData(color: Colors.black),
      ),
      drawer: SideDrawer(),
      body: ListView(
        children: <Widget>[
          //color viewer
          Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 32, left: 32, right: 32),
                    height: 104,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  Positioned(
                    width: 40,
                    height: 40,
                    right: 32,
                    top: 32,
                    child: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 12, left: 32, right: 32),
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                    color: Colors.blue,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      //hex
                      Row(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'HEX',
                              style: smallText,
                            ),
                          ),
                          specialText('0xFFFFFFFF'),
                        ],
                      ),
                      //rgb
                      Row(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'RGB',
                              style: smallText,
                            ),
                          ),
                          specialText('255'),
                          specialText('200'),
                          specialText('176'),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
          colorRow('Shade colors'),
          colorRow('Tint colors'),
          colorRow('Triadic colors'),
          colorRow('Analogous colors'),
          colorRow('Complimentary colors'),
          colorRow('Related colors'),
        ],
      ),
    );
  }

  Widget specialText(String text) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      padding: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          width: 1,
          color: Colors.white,
        ),
      ),
      child: Text(
        text,
        style: smallText,
      ),
    );
  }

  Widget colorRow(String text) {
    double height = 32;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(text),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: height,
                    color: Colors.lightBlue,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: height,
                    color: Colors.blueAccent,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: height,
                    color: Colors.blue,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
