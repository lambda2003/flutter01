import 'package:flutter/material.dart';
import 'package:light_dart_app/home.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  ThemeMode _themeMode = ThemeMode.system;

  _changeThemeMode(ThemeMode themeMode){
    _themeMode = themeMode;
    setState(() {});
  }

  static const Color seedColor = Color.fromARGB(255, 11, 225, 154);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: _themeMode,

      theme: ThemeData(
        brightness: Brightness.light,
        colorSchemeSeed:  seedColor,
        // colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed:  seedColor,
        // colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
      ),
      home: Home(onChangeTheme: _changeThemeMode),
    );
  }
}
