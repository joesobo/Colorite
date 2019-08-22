import 'package:colorite/components/theme/custom_theme.dart';
import 'package:colorite/screens/home_page.dart';
import 'package:colorite/utilities/my_themes.dart';
import 'package:flutter/material.dart';

void main() => runApp(
  CustomTheme(
    initialThemeKey: MyThemeKeys.Dark,
    child: MyApp(),
  )
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: CustomTheme.of(context),
      home: HomePage(),
    );
  }
}
