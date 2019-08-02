import 'package:colorite/utilities/constants.dart';
import 'package:flutter/material.dart';

enum Mode { rgb, hsv }

Mode mode = Mode.rgb;

class SelectorCard extends StatefulWidget {
  final int r = 125;
  final int g = 125;
  final int b = 125;

  @override
  _SelectorCardState createState() => _SelectorCardState(r: r, g: g, b: b);
}

class _SelectorCardState extends State<SelectorCard> {
  int r;
  int g;
  int b;

  _SelectorCardState({this.r, this.g, this.b});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Text(
        'Edit your main color\n $r, $g, $b',
        textAlign: TextAlign.center,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              ColorIndicator(color: Color.fromRGBO(r, g, b, 1)),
              ModeSelector(),
            ],
          ),
          Column(
            children: <Widget>[
              ColorSlider(parent: this, text: 'Red', value: r, activeColor: Colors.red, overlayColor: Color(0x5fe57373),),
              ColorSlider(parent: this, text: 'Green', value: g, activeColor: Colors.green, overlayColor: Color(0x5f81c784),),
              ColorSlider(parent: this, text: 'Blue', value: b, activeColor: Colors.blue, overlayColor: Color(0x5f03A9f4),),
            ],
          ),
          RaisedButton(
            color: Colors.blueGrey,
            elevation: 5,
            splashColor: Colors.lightBlue,
            child: Text(
              'Save',
              style: defaultText,
            ),
            onPressed: () {
              //Navigator.pop(context);
              print(r);
            },
          ),
        ],
      ),
    );
  }
}

class ColorIndicator extends StatelessWidget {
  final Color color;

  ColorIndicator({this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      height: 104,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
      ),
    );
  }
}

class ModeSelector extends StatefulWidget {
  @override
  _ModeSelectorState createState() => _ModeSelectorState();
}

class _ModeSelectorState extends State<ModeSelector> {
  @override
  Widget build(BuildContext context) {
    //creates row for selected color mode
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        //RGB outline vs filled
        mode == Mode.rgb
            ? filled('RGB', () {
                setState(() {
                  mode = Mode.rgb;
                });
              }, Mode.rgb)
            : outline('RGB', () {
                setState(() {
                  mode = Mode.rgb;
                });
              }, Mode.rgb),
        //HSV outline vs filled
        mode == Mode.hsv
            ? filled('HSV', () {
                setState(() {
                  mode = Mode.hsv;
                });
              }, Mode.hsv)
            : outline('HSV', () {
                setState(() {
                  mode = Mode.hsv;
                });
              }, Mode.hsv),
      ],
    );
  }

  //returns outline button of mode selector
  OutlineButton outline(String text, Function onPressed, Mode mode) {
    return OutlineButton(
      highlightedBorderColor: Colors.grey,
      borderSide: BorderSide(color: Colors.grey),
      child: Text(text),
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: mode == Mode.rgb ? Radius.circular(5) : Radius.zero,
          bottomLeft: mode == Mode.rgb ? Radius.circular(5) : Radius.zero,
          topRight: mode == Mode.hsv ? Radius.circular(5) : Radius.zero,
          bottomRight: mode == Mode.hsv ? Radius.circular(5) : Radius.zero,
        ),
      ),
    );
  }

  //returns filled button of mode selector
  FlatButton filled(String text, Function onPressed, Mode mode) {
    return FlatButton(
      color: Colors.grey,
      child: Text(text),
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: mode == Mode.rgb ? Radius.circular(5) : Radius.zero,
          bottomLeft: mode == Mode.rgb ? Radius.circular(5) : Radius.zero,
          topRight: mode == Mode.hsv ? Radius.circular(5) : Radius.zero,
          bottomRight: mode == Mode.hsv ? Radius.circular(5) : Radius.zero,
        ),
      ),
    );
  }
}

class ColorSlider extends StatelessWidget {
  final _SelectorCardState parent;
  final String text;
  final int value;
  final Color activeColor;
  final Color overlayColor;

  ColorSlider({this.parent, this.text, this.value, this.activeColor, this.overlayColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(text),
              Text(value.toString()),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
              thumbColor: Colors.white,
              activeTrackColor: activeColor,
              overlayColor: overlayColor,
            ),
            child: Slider(
              min: 0,
              max: 255,
              value: value.toDouble(),
              onChanged: (double newValue) {
                parent.setState(() {
                  if(text == 'Red'){
                    parent.r = newValue.round();
                  }
                  else if(text == 'Blue'){
                    parent.b = newValue.round();
                  }else{
                    parent.g = newValue.round();
                  }
                });
              },
            ),
          ),
          Container(
            height: 1,
            width: 225,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
