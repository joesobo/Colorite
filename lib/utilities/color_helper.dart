import 'package:flutter/material.dart';

class ColorHelper {
  //ColorHelper(this.mainColor);

  //final Color mainColor;

  HSVColor getHSVColor(Color mainColor) {
    return HSVColor.fromColor(mainColor);
  }

  //returns mainColor and complement in a list
  List<Color> getComplementary(Color mainColor) {
    //main color
    List<Color> result = [];
    HSVColor color = getHSVColor(mainColor);
    result.add(mainColor);

    //2nd color
    double newHue = ((color.hue + 180) - 360).abs();
    HSVColor newColor =
        HSVColor.fromAHSV(1, newHue, color.saturation, color.value);
    result.add(newColor.toColor());

    return result;
  }

  //returns mainColor and 2 complements in a list
  List<Color> getSplitComplement(Color mainColor) {
    List<Color> result = [];
    HSVColor color = getHSVColor(mainColor);

    //color 1
    double newHue = ((color.hue + 150) - 360).abs();
    HSVColor newColor =
        HSVColor.fromAHSV(1, newHue, color.saturation, color.value);
    result.add(newColor.toColor());

    //main color
    result.add(mainColor);

    //color 2
    newHue = ((color.hue + 210) - 360).abs();
    newColor = HSVColor.fromAHSV(1, newHue, color.saturation, color.value);
    result.add(newColor.toColor());

    return result;
  }

  //returns mainColor and 3 complements in a list
  List<Color> getTriadic(Color mainColor) {
    List<Color> result = [];
    HSVColor color = getHSVColor(mainColor);

    //color 1
    double newHue = ((color.hue + 90) - 360).abs();
    HSVColor newColor =
        HSVColor.fromAHSV(1, newHue, color.saturation, color.value);
    result.add(newColor.toColor());

    //color 2
    newHue = ((color.hue + 180) - 360).abs();
    newColor = HSVColor.fromAHSV(1, newHue, color.saturation, color.value);
    result.add(newColor.toColor());

    //main color
    result.add(mainColor);

    //color 3
    newHue = ((color.hue + 270) - 360).abs();
    newColor = HSVColor.fromAHSV(1, newHue, color.saturation, color.value);
    result.add(newColor.toColor());

    return result;
  }

  //returns mainColor and 3 analogous in a list
  List<Color> getAnalogous(Color mainColor) {
    List<Color> result = [];
    HSVColor color = getHSVColor(mainColor);

    //color 1
    double newHue = ((color.hue + 30) - 360).abs();
    HSVColor newColor =
        HSVColor.fromAHSV(1, newHue, color.saturation, color.value);
    result.add(newColor.toColor());

    //color 2
    newHue = ((color.hue + 60) - 360).abs();
    newColor = HSVColor.fromAHSV(1, newHue, color.saturation, color.value);
    result.add(newColor.toColor());

    //main color
    result.add(mainColor);

    //color 3
    newHue = ((color.hue + 90) - 360).abs();
    newColor = HSVColor.fromAHSV(1, newHue, color.saturation, color.value);
    result.add(newColor.toColor());

    return result;
  }

  //returns mainColor and shades in a list
  List<Color> getShades(Color mainColor) {
    List<Color> result = [];
    HSVColor color = getHSVColor(mainColor);

    //color 1
    double newValue = (color.value - 0.25).abs();
    HSVColor newColor =
        HSVColor.fromAHSV(1, color.hue, color.saturation, newValue);
    result.add(newColor.toColor());

    //color 2
    newValue = (color.value - 0.5).abs();
    newColor = HSVColor.fromAHSV(1, color.hue, color.saturation, newValue);
    result.add(newColor.toColor());

    //main color
    result.add(mainColor);

    //color 3
    newValue = (color.value - 0.75).abs();
    newColor = HSVColor.fromAHSV(1, color.hue, color.saturation, newValue);
    result.add(newColor.toColor());

    //color 4
    newValue = (color.value - 1).abs();
    newColor = HSVColor.fromAHSV(1, color.hue, color.saturation, newValue);
    result.add(newColor.toColor());

    return result;
  }

  //returns mainColor and shades in a list
  List<Color> getTint(Color mainColor) {
    List<Color> result = [];
    HSVColor color = getHSVColor(mainColor);

    //color 1
    double newSaturation = (color.saturation - 0.25).abs();
    HSVColor newColor =
        HSVColor.fromAHSV(1, color.hue, newSaturation, color.value);
    result.add(newColor.toColor());

    //color 2
    newSaturation = (color.saturation - 0.5).abs();
    newColor = HSVColor.fromAHSV(1, color.hue, newSaturation, color.value);
    result.add(newColor.toColor());

    //main color
    result.add(mainColor);

    //color 3
    newSaturation = (color.saturation - 0.75).abs();
    newColor = HSVColor.fromAHSV(1, color.hue, newSaturation, color.value);
    result.add(newColor.toColor());

    //color 4
    newSaturation = (color.saturation - 1).abs();
    newColor = HSVColor.fromAHSV(1, color.hue, newSaturation, color.value);
    result.add(newColor.toColor());

    return result;
  }

  //returns mainColor and monochromatic colors in a list
  List<Color> getMonochromatic(Color mainColor) {
    List<Color> result = [];
    HSVColor color = getHSVColor(mainColor);

    //color 1
    HSVColor newColor = HSVColor.fromAHSV(1, color.hue, color.saturation, 0.5);
    result.add(newColor.toColor());

    //color 2
    newColor = HSVColor.fromAHSV(
        1,
        color.hue,
        color.saturation <= 0.7
            ? (color.saturation + .3).abs()
            : (color.saturation - .3).abs(),
        1);
    result.add(newColor.toColor());

    //main color
    result.add(mainColor);

    //color 3
    newColor = HSVColor.fromAHSV(
        1,
        color.hue,
        color.saturation <= 0.7
            ? (color.saturation + .3).abs()
            : (color.saturation - .3).abs(),
        0.5);
    result.add(newColor.toColor());

    //color 4
    newColor = HSVColor.fromAHSV(1, color.hue, color.saturation, 0.8);
    result.add(newColor.toColor());

    return result;
  }

  //returns a slightly darker shade for display
  Color getDarkShade(Color mainColor) {
    HSVColor color = getHSVColor(mainColor);

    //color 1
    double newValue = (color.value - 0.15).abs();
    HSVColor newColor =
        HSVColor.fromAHSV(1, color.hue, color.saturation, newValue);
    return newColor.toColor();
  }
}
