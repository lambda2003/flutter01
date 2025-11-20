import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  late bool button2Visible;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    button2Visible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hide Widget')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                //
                button2Visible = true;
                setState(() {});
              },
              child: Text('Visible Button'),
            ),
            Visibility(
              visible: button2Visible,
              child: TextButton(
                onPressed: () {
                  //
                },
                child: Text('Button'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                //
                button2Visible = false;
                setState(() {});
              },
              child: Text('Invisible Button'),
            ),
          ],
        ),
      ),
    );
  }
}
