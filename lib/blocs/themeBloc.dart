import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CustomTheme {
  final String name;
  final ThemeData themeData;

  const CustomTheme(this.name, this.themeData);
}

class ThemeBloc {
  final Stream<ThemeData> themeDataStream;
  final Sink<CustomTheme> selectedTheme;

  factory ThemeBloc() {
    // ignore: close_sinks
    final selectedTheme = BehaviorSubject<CustomTheme>();
    final themeDataStream =
        selectedTheme.distinct().map((customTheme) => customTheme.themeData);
    return ThemeBloc._(themeDataStream, selectedTheme);
  }

  const ThemeBloc._(this.themeDataStream, this.selectedTheme);

  void dispose() {
    selectedTheme.close();
  }
}
