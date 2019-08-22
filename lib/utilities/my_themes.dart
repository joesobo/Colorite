import 'package:flutter/material.dart';

enum MyThemeKeys { 
  Light,
  Dark,
}

class MyThemes {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    cursorColor: Colors.grey[500]
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    cursorColor: Colors.white
  );

  static ThemeData getThemeFromKey(MyThemeKeys themeKey){
    switch(themeKey){
      case MyThemeKeys.Light:
        return lightTheme;
      case MyThemeKeys.Dark:
        return darkTheme;
      default:
        return lightTheme;
    }
  }
}