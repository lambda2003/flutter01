import 'package:character_app/layout/top.dart';
import 'package:character_app/layout/topDrawer.dart';
import 'package:flutter/material.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[300],
      // appBar: TopApp(),
      appBar: AppBar(
        title: Text('aaaaaaa'),
      ),
      body: Center(child: Text('aa')),
    );
  }
}
