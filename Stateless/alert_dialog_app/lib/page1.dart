import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alert dialog'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Page1')
      )
    );
  }

}
