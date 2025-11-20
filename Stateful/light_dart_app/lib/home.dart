import 'package:flutter/material.dart';
import 'package:light_dart_app/main.dart';

class Home extends StatefulWidget {
  final Function(ThemeMode) onChangeTheme;
  const Home({super.key, required this.onChangeTheme});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkModeMediaQuery =
        Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text('Matrial 3 Test'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              foregroundColor: Theme.of(context).colorScheme.onTertiary,
            ),
            onPressed: () {
              //
              isDarkModeMediaQuery
                  ? widget.onChangeTheme(ThemeMode.light)
                  : widget.onChangeTheme(ThemeMode.dark);
            },
            icon: isDarkModeMediaQuery
                ? Icon(Icons.light_mode_outlined)
                : Icon(Icons.dark_mode_outlined),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                foregroundColor: Theme.of(context).colorScheme.onSecondary,
              ),
              onPressed: () {
                //
                widget.onChangeTheme(ThemeMode.dark);
              },
              child: Text('Dark Theme'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                foregroundColor: Theme.of(context).colorScheme.onTertiary,
              ),
              onPressed: () {
                //
                widget.onChangeTheme(ThemeMode.light);
              },
              child: Text('Light Theme'),
            ),
          ],
        ),
      ),
    );
  }

  // === Functions
}
