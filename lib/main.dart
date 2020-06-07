import 'package:flutter/material.dart';
import 'package:themechanger/utils/theme_utils.dart';
import 'blocs/themeBloc.dart';
import 'package:themechanger/screens/moviesList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = ThemeBloc();
    return StreamBuilder<ThemeData>(
      initialData: defaultTheme.themeData,
      stream: themeBloc.themeDataStream,
      builder: (context, snapshot) {
        return MaterialApp(
          title: 'Theme changer',
          theme: snapshot.data,
          home: MoviesList(themeBloc: themeBloc),
        );
      },
    );
  }
}
