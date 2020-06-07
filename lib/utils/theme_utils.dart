import 'package:flutter/material.dart';
import 'package:themechanger/blocs/themeBloc.dart';

final CustomTheme lightTheme = _buildLightTheme();

CustomTheme _buildLightTheme() {
  return CustomTheme(
      'light',
      ThemeData(
        brightness: Brightness.light,
        accentColor: Colors.lightBlueAccent,
        primaryColor: Colors.cyanAccent,
      ));
}

final CustomTheme darkTheme = _buildDarkTheme();

CustomTheme _buildDarkTheme() {
  return CustomTheme(
      'dark',
      ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.teal,
        primaryColor: Color(0xff032038),
      ));
}

final CustomTheme defaultTheme = _buildDefaultTheme();

CustomTheme _buildDefaultTheme() {
  return CustomTheme(
      'default',
      ThemeData(
        brightness: Brightness.light,
        accentColor: Colors.amber,
        primaryColor: Colors.deepOrange,
      ));
}
